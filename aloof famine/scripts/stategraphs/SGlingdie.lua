local WALK_SPEED = 6  -- 匹配移动速度

local actionhandlers =
{
    ActionHandler(ACTIONS.GOHOME, "land"),
    ActionHandler(ACTIONS.POLLINATE, function(inst)
        if inst and inst.sg and inst.sg:HasStateTag("landed") then
            return "pollinate"
        else
            return "land"
        end
    end),
    ActionHandler(ACTIONS.ATTACK, "attack"),
}

local events=
{
    EventHandler("locomote", function(inst)
        if inst and inst.sg and not inst.sg:HasStateTag("busy") then
            local is_moving = inst.sg:HasStateTag("moving")
            local wants_to_move = inst.components and inst.components.locomotor and inst.components.locomotor:WantsToMoveForward()
            if is_moving ~= wants_to_move then
                if wants_to_move then
                    inst.sg.statemem.wantstomove = true
                    inst.sg:GoToState("moving")
                else
                    inst.sg:GoToState("idle")
                end
            end
        end
    end),
    EventHandler("death", function(inst) 
        if inst and inst.sg then
            inst.sg:GoToState("death") 
        end
    end),
    EventHandler("attacked", function(inst)
        if inst and inst.sg and not inst.sg:HasStateTag("busy") then
            inst.sg:GoToState("hit")
        end
    end),
    EventHandler("start_attack", function(inst)
        if inst and inst.sg and not inst.sg:HasStateTag("busy") and inst.components.combat and inst.components.combat.target then
            inst.sg:GoToState("attack")
        end
    end),
    -- 攻击冷却结束后重新检查目标
    EventHandler("attack_cooldown_over", function(inst)
        if inst and inst.sg and inst.components.combat and inst.components.combat.target then
            inst.sg:GoToState("attack")
        end
    end),
    CommonHandlers.OnFreeze(),
}

-- 辅助函数：安全检查动画是否存在
local function HasAnimation(animstate, animname)
    -- 尝试获取动画长度，如果失败则认为动画不存在
    if animstate and animname then
        local ok, len = pcall(animstate.GetAnimationLength, animstate, animname)
        return ok and len ~= nil and len > 0
    end
    return false
end

local states=
{
    State{
        name = "moving",
        tags = {"moving", "canrotate"},

        onenter = function(inst)
            if inst and inst.components and inst.components.locomotor then
                inst.components.locomotor:WalkForward()
            end
            if inst and inst.AnimState then
                inst.AnimState:PlayAnimation("flight_cycle", true)
            end
        end,

        events = {
            EventHandler("animover", function(inst)
                if inst and inst.sg and inst.sg.statemem.wantstomove then
                    inst.sg:GoToState("moving")
                end
            end),
        },
    },

    State{
        name = "idle",
        tags = {"idle"},

        onenter = function(inst)
            if inst and inst.Physics then
                inst.Physics:Stop()
            end
            if inst and inst.AnimState and not inst.AnimState:IsCurrentAnimation("idle_flight_loop") then
                inst.AnimState:PlayAnimation("idle_flight_loop", true)
            end
            if inst and inst.sg then
                local animlen = inst.AnimState and inst.AnimState:GetCurrentAnimationLength() or 1
                inst.sg:SetTimeout(animlen)
            end
        end,

        ontimeout = function(inst)
            if inst and inst.sg and inst.sg.statemem.wantstomove then
                inst.sg:GoToState("moving")
            elseif inst and inst.sg then
                inst.sg:GoToState("idle")
            end
        end,
    },

    -- 攻击状态：修复攻击调用逻辑
    State{
        name = "attack",
        tags = {"attack", "busy"},

        onenter = function(inst)
            if inst and inst.Physics then
                inst.Physics:Stop()
            end
            -- 确保使用正确的攻击动画，若不存在则使用land动画
            if inst and inst.AnimState then
                -- 使用自定义的HasAnimation检查函数
                local anim = HasAnimation(inst.AnimState, "attack") and "attack" or "land"
                inst.AnimState:PlayAnimation(anim)
            end
            -- 安全调用攻击方法
            if inst and inst.components and inst.components.combat and 
               inst.components.combat.target and inst.components.combat.Attack then
                inst.components.combat:Attack(inst.components.combat.target)
            end
        end,

        timeline = {
            TimeEvent(5 * FRAMES, function(inst)
                if inst and inst.SoundEmitter then
                    inst.SoundEmitter:PlaySound("dontstarve/bee/bee_attack")
                end
            end),
        },

        events = {
            EventHandler("animover", function(inst)
                if inst and inst.sg then
                    -- 攻击结束后回到idle状态，允许再次攻击
                    inst.sg:GoToState("idle")
                    -- 触发攻击冷却事件（与attackperiod同步）
                    inst:DoTaskInTime(inst.components.combat.attackperiod, function()
                        inst:PushEvent("attack_cooldown_over")
                    end)
                end
            end),
        },
    },

    -- 受击状态
    State{
        name = "hit",
        tags = {"hit", "busy"},

        onenter = function(inst)
            if inst and inst.Physics then
                inst.Physics:Stop()
            end
            if inst and inst.AnimState then
                -- 使用自定义的HasAnimation检查函数
                local anim = HasAnimation(inst.AnimState, "hit") and "hit" or "idle_flight_loop"
                inst.AnimState:PlayAnimation(anim)
            end
            if inst and inst.SoundEmitter then
                inst.SoundEmitter:PlaySound("dontstarve/bee/bee_hurt")
            end
            if inst and inst.sg then
                inst.sg:SetTimeout(0.5)
            end
        end,

        ontimeout = function(inst)
            if inst and inst.sg then
                inst.sg:GoToState("idle")
            end
        end,
    },

    State{
        name = "death",
        tags = {"busy"},

        onenter = function(inst)
            if inst and inst.AnimState then
                inst.AnimState:PlayAnimation("death")
            end
            if inst and inst.Physics then
                inst.Physics:Stop()
            end
            RemovePhysicsColliders(inst)
            if inst and inst.components and inst.components.lootdropper then
                local x, y, z = inst.Transform:GetWorldPosition()
                inst.components.lootdropper:DropLoot(Vector3(x, y, z))
            end
            if inst and inst.SoundEmitter then
                inst.SoundEmitter:PlaySound("dontstarve/bee/bee_death")
            end
        end,

        timeline = {
            TimeEvent(10 * FRAMES, function(inst)
                if inst then
                    LandFlyingCreature(inst)
                end
            end),
        },
    },

    State{
        name = "land",
        tags = {"busy", "landing"},

        onenter = function(inst)
            if inst and inst.Physics then
                inst.Physics:Stop()
            end
            if inst and inst.AnimState then
                inst.AnimState:PlayAnimation("land")
            end
            if inst then
                LandFlyingCreature(inst)
            end
        end,

        events = {
            EventHandler("animover", function(inst)
                if inst and inst.bufferedaction then
                    if inst.bufferedaction.action == ACTIONS.POLLINATE then
                        inst.sg:GoToState("pollinate")
                    elseif inst.bufferedaction.action == ACTIONS.GOHOME then
                        inst:Remove()
                    else
                        inst.sg:GoToState("land_idle")
                    end
                elseif inst and inst.sg then
                    inst.sg:GoToState("land_idle")
                end
            end),
        },

        onexit = function(inst)
            if inst then
                RaiseFlyingCreature(inst)
            end
        end,
    },

    State{
        name = "land_idle",
        tags = {"busy", "landed"},

        onenter = function(inst)
            if inst and inst.AnimState then
                inst.AnimState:PushAnimation("idle", true)
            end
            if inst then
                LandFlyingCreature(inst)
            end
        end,

        onexit = function(inst)
            if inst then
                RaiseFlyingCreature(inst)
            end
        end,
    },

    State{
        name = "pollinate",
        tags = {"busy", "landed"},

        onenter = function(inst)
            if inst and inst.AnimState then
                inst.AnimState:PushAnimation("idle", true)
            end
            if inst then
                inst:PerformBufferedAction()
            end
            if inst and inst.sg then
                inst.sg:SetTimeout(GetRandomWithVariance(3, 1))
            end
            if inst then
                LandFlyingCreature(inst)
            end
        end,

        ontimeout = function(inst)
            if inst and inst.sg then
                inst.sg:GoToState("takeoff")
            end
        end,

        onexit = function(inst)
            if inst then
                RaiseFlyingCreature(inst)
            end
        end,
    },

    State{
        name = "takeoff",
        tags = {"busy"},

        onenter = function(inst)
            if inst and inst.Physics then
                inst.Physics:Stop()
            end
            if inst and inst.AnimState then
                inst.AnimState:PlayAnimation("take_off")
            end
            if inst and inst.SoundEmitter then
                inst.SoundEmitter:PlaySound("dontstarve/bee/bee_takeoff")
            end
        end,

        events = {
            EventHandler("animover", function(inst)
                if inst and inst.sg then
                    inst.sg:GoToState("idle")
                end
            end),
        },
    },
}

CommonStates.AddFrozenStates(states, 
    function(inst) if inst then LandFlyingCreature(inst) end end,
    function(inst) if inst then RaiseFlyingCreature(inst) end end
)

return StateGraph("SGlingdie", states, events, "takeoff", actionhandlers)