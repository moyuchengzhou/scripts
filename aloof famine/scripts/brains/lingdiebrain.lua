-- 引入饥荒标准行为树组件和节点
require "behaviours/chaseandattack"
require "behaviours/wander"
require "behaviours/doaction"
require "behaviours/runaway"
local BrainCommon = require("brains/braincommon")

local MAX_CHASE_DIST = 15
local MAX_CHASE_TIME = 8
local WANDER_DIST = 10

local LingdieBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

-- 检查是否有战斗目标
local function HasTarget(inst)
    return inst.components and inst.components.combat and inst.components.combat.target ~= nil
end

-- 寻找玩家目标
local function FindPlayer(inst)
    return FindEntity(inst, 15, function(guy)
        return guy:HasTag("player") and not guy:HasTag("playerghost") and guy:IsValid()
    end)
end

-- 寻找敌人目标
local function FindEnemy(inst)
    return FindEntity(inst, 10, function(guy)
        return guy:IsValid() and inst.components and inst.components.combat and inst.components.combat:CanTarget(guy)
    end, nil, {"INLIMBO", "notarget", "sjy_lingdie", "playerghost"})
end

-- 获取目标行为（修复核心：使用正确的Action创建方式）
local function AcquireTargetAction(inst)
    return DoAction(inst, function()
        if not HasTarget(inst) then
            local target = FindPlayer(inst) or FindEnemy(inst)
            if target then
                inst.components.combat:SetTarget(target)
                inst:PushEvent("start_attack", {target = target})
                -- 使用标准攻击行为创建方式
                return BufferedAction(inst, target, ACTIONS.ATTACK)
            end
        elseif HasTarget(inst) then
            -- 已有目标时返回攻击行为
            return BufferedAction(inst, inst.components.combat.target, ACTIONS.ATTACK)
        end
        return nil  -- 无目标时返回空
    end, "AcquireTarget")
end

function LingdieBrain:OnStart()
    local root = PriorityNode({
        -- 通用恐慌行为（如着火时）
        BrainCommon.PanicTrigger(self.inst),
        
        -- 战斗逻辑：追逐并攻击目标
        WhileNode(function() return HasTarget(self.inst) end, "Combat",
            ChaseAndAttack(self.inst, SpringCombatMod(MAX_CHASE_TIME), SpringCombatMod(MAX_CHASE_DIST))
        ),
        
        -- 没有目标时寻找目标
        AcquireTargetAction(self.inst),
        
        -- 空闲时漫游
        Wander(self.inst, function() return self.inst:GetPosition() end, WANDER_DIST, {
            minwalktime = 1,
            maxwalktime = 2,
            minwaittime = 1,
            maxwaittime = 2,
        })
    }, 1)

    self.bt = BT(self.inst, root)
end

-- 初始化时记录初始位置作为"家"
function LingdieBrain:OnInitializationComplete()
    if self.inst.components and self.inst.components.knownlocations then
        self.inst.components.knownlocations:RememberLocation("home", self.inst:GetPosition())
    end
end

return LingdieBrain