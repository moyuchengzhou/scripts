local assets =
{
    Asset("ANIM", "anim/grass.zip"),
    Asset("ANIM", "anim/jiucai.zip"),
    Asset("SOUND", "sound/common.fsb"),
    Asset("IMAGE", "images/inventoryimages/jiucai.tex"),
	Asset("ATLAS", "images/inventoryimages/jiucai.xml"),
}

local prefabs =
{
    "jiucaibean",
	"dug_jiucai",
    -- "dragonfruit"
    "jiucaihua"
}

local function dig_up(inst, worker)
    if inst.components.pickable ~= nil and inst.components.lootdropper ~= nil then
        local withered = inst.components.witherable ~= nil and inst.components.witherable:IsWithered()

        if inst.components.pickable:CanBePicked() then
            inst.components.lootdropper:SpawnLootPrefab(inst.components.pickable.product)
        end
        local shuiji = math.random()
        if shuiji >= 0.2 then
            inst.components.lootdropper:SpawnLootPrefab(withered and "jiucaibean" or "dug_jiucai")
            -- 
            -- body
        end
        else inst.components.lootdropper:SpawnLootPrefab(withered and "jiucaihua" or "dug_jiucai")
    end
    inst:Remove()
end

-- 生长动画
local function onregenfn(inst)
    inst.AnimState:PlayAnimation("grow")--生长
    inst.AnimState:PushAnimation("idle", true)--展示成熟动画
end

local function makeemptyfn(inst)
    if not POPULATING and
        (   inst.components.witherable ~= nil and
            inst.components.witherable:IsWithered() or
            inst.AnimState:IsCurrentAnimation("idle_dead")-- 枯萎动画
        ) then
        inst.AnimState:PlayAnimation("dead_to_empty")-- 枯萎变成绿色
        inst.AnimState:PushAnimation("picked", false)-- 绿色的草根
    else
        inst.AnimState:PlayAnimation("picked")-- 绿色的草根
    end
end

local function makebarrenfn(inst, wasempty)
    if not POPULATING and
        (   inst.components.witherable ~= nil and
            inst.components.witherable:IsWithered()
        ) then                                      -- 枯萎变成绿色      --缩回去枯萎动画
        inst.AnimState:PlayAnimation(wasempty and "empty_to_dead" or "full_to_dead")
        inst.AnimState:PushAnimation("idle_dead", false) --枯萎动画
    else
        inst.AnimState:PlayAnimation("idle_dead")-- 枯萎动画
    end
end

local function onpickedfn(inst)
    inst.SoundEmitter:PlaySound("dontstarve/wilson/pickup_reeds")
    inst.AnimState:PlayAnimation("picking")--摘走动画

    if inst.components.pickable:IsBarren() then
        inst.AnimState:PushAnimation("empty_to_dead") --枯萎变成绿色
        inst.AnimState:PushAnimation("idle_dead", false) --枯萎动画
    else
        inst.AnimState:PushAnimation("picked", false) -- 采摘动画
    end
end

local function ontransplantfn(inst)
    inst.components.pickable:MakeBarren()
end

local function fn()
    local jiucai = "jiucai"

    local inst = CreateEntity()
    
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    -- inst.MiniMapEntity:SetIcon("monkeytail.png")
    inst.MiniMapEntity:SetIcon(jiucai..".tex")
    
    inst:AddTag("plant")
    inst:AddTag("silviculture") -- for silviculture book

    --witherable (from witherable component) added to pristine state for optimization
    inst:AddTag("witherable")
    
    inst.AnimState:SetBank("jiucai")
    inst.AnimState:SetBuild("jiucai")
    inst.AnimState:PlayAnimation("idle", true)

    inst.scrapbook_specialinfo = "NEEDFERTILIZER"
    
    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end

    ------------------------------------------------------------------------
	inst.AnimState:SetFrame(math.random(inst.AnimState:GetCurrentAnimationNumFrames()) - 1)
    local color = 0.75 + math.random() * 0.25
    inst.AnimState:SetMultColour(color, color, color, 1)

    ------------------------------------------------------------------------
    inst:AddComponent("pickable")
    inst.components.pickable.picksound = "dontstarve/wilson/pickup_reeds"

    local shuiji2 = math.random()
    if shuiji2 >= 0.2 then

    inst.components.pickable:SetUp("jiucaibean", 5)
    
    else inst.components.pickable:SetUp("jiucaihua" ,5)
       
    end
    inst.components.pickable.onregenfn = onregenfn
    inst.components.pickable.onpickedfn = onpickedfn
    inst.components.pickable.makeemptyfn = makeemptyfn
    inst.components.pickable.makebarrenfn = makebarrenfn
    inst.components.pickable.max_cycles = 30
    inst.components.pickable.cycles_left = inst.components.pickable.max_cycles
    inst.components.pickable.ontransplantfn = ontransplantfn

    ------------------------------------------------------------------------
    inst:AddComponent("witherable")

    ------------------------------------------------------------------------
    inst:AddComponent("lootdropper")

    ------------------------------------------------------------------------
    inst:AddComponent("inspectable")

    ------------------------------------------------------------------------
    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.SMALL_FUEL


	if not GetGameModeProperty("disable_transplanting") then
		inst:AddComponent("workable")
		inst.components.workable:SetWorkAction(ACTIONS.DIG)
		inst.components.workable:SetOnFinishCallback(dig_up)
		inst.components.workable:SetWorkLeft(1)
	end

    ------------------------------------------------------------------------
    MakeSmallBurnable(inst, TUNING.SMALL_FUEL)
    MakeSmallPropagator(inst)

    ------------------------------------------------------------------------
    MakeNoGrowInWinter(inst)

    ------------------------------------------------------------------------
    MakeHauntableIgnite(inst)
    
    return inst
end

-- local function jiucaibean(inst) 
--     inst.components.pickable:SetUp("jiucaibean", 120)
--     inst.components.pickable.getregentimefn = getregentimefn_normal
--     inst.components.pickable.max_cycles = TUNING.BERRYBUSH_CYCLES + math.random(2)
--     inst.components.pickable.cycles_left = inst.components.pickable.max_cycles

--     if inst.components.workable then
--         inst.components.workable:SetOnFinishCallback(dig_up_normal)
--     end
-- end


return Prefab("jiucai", fn, assets, prefabs)
