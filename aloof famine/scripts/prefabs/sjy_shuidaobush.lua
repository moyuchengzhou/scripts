local assets =
{
    Asset("ANIM", "anim/grass.zip"),
    Asset("ANIM", "anim/sjy_shuidaobush.zip"),
    Asset("SOUND", "sound/common.fsb"),
    Asset("IMAGE", "images/inventoryimages/sjy_shuidaobush.tex"),
	Asset("ATLAS", "images/inventoryimages/sjy_shuidaobush.xml"),
}

local prefabs =
{
    "forgetmelots",
	"dug_sjy_shuidaobush",
    -- "dragonfruit"
    
}

local function dig_up(inst, worker)
    if inst.components.pickable ~= nil and inst.components.lootdropper ~= nil then
        local withered = inst.components.witherable ~= nil and inst.components.witherable:IsWithered()

        if inst.components.pickable:CanBePicked() then
            inst.components.lootdropper:SpawnLootPrefab(inst.components.pickable.product)
        end
            inst.components.lootdropper:SpawnLootPrefab(withered and "sjy_guzi" or "dug_sjy_shuidaobush")
        end
       
    
    inst:Remove()
end

-- 生长动画
local function onregenfn(inst)
    inst.AnimState:PlayAnimation("idle",true)--生长
    inst.AnimState:PushAnimation("idle", true)--展示成熟动画
end

local function makeemptyfn(inst)
    if not POPULATING and
        (   inst.components.witherable ~= nil and
            inst.components.witherable:IsWithered() or
            inst.AnimState:IsCurrentAnimation("idle2",true)-- 枯萎动画
        ) then
        inst.AnimState:PlayAnimation("idle1",true)-- 枯萎变成绿色
        inst.AnimState:PushAnimation("idle1", true)-- 绿色的草根
    else
        inst.AnimState:PlayAnimation("idle1",true)-- 绿色的草根
    end
end

local function makebarrenfn(inst, wasempty)
    if not POPULATING and
        (   inst.components.witherable ~= nil and
            inst.components.witherable:IsWithered()
        ) then                                      -- 枯萎变成绿色      --缩回去枯萎动画
        inst.AnimState:PlayAnimation(wasempty and "idle2" or "idle2")
        inst.AnimState:PushAnimation("idle2", true) --枯萎动画
    else
        inst.AnimState:PlayAnimation("idle2",true)-- 枯萎动画
    end
end

local function onpickedfn(inst)
    inst.SoundEmitter:PlaySound("dontstarve/wilson/pickup_reeds")
    inst.AnimState:PlayAnimation("idle1")--摘走动画

    if inst.components.pickable:IsBarren() then
        inst.AnimState:PushAnimation("idle1",true) --枯萎变成绿色
        inst.AnimState:PushAnimation("idle2", true) --枯萎动画
    else
        inst.AnimState:PushAnimation("idle1", true) -- 采摘动画
        
    end
    inst:Remove()
end

local function ontransplantfn(inst)
    inst.components.pickable:MakeBarren()
end

local function fn()
    local sjy_shuidaobush = "sjy_shuidaobush"

    local inst = CreateEntity()
    
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    -- inst.MiniMapEntity:SetIcon("monkeytail.png")
    inst.MiniMapEntity:SetIcon(sjy_shuidaobush..".tex")
    
    inst:AddTag("plant")
    inst:AddTag("silviculture") -- for silviculture book

    -- witherable (from witherable component) added to pristine state for optimization
    inst:AddTag("witherable")
    
    inst.AnimState:SetBank("sjy_shuidaobush")
    inst.AnimState:SetBuild("sjy_shuidaobush")
    inst.AnimState:PlayAnimation("idle", true)
    inst.AnimState:SetScale(.5,.5,.5)

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

   

    inst.components.pickable:SetUp("sjy_guzi", 2400,5)
    inst.components.pickable.onregenfn = onregenfn
    inst.components.pickable.onpickedfn = onpickedfn
    inst.components.pickable.makeemptyfn = makeemptyfn
    inst.components.pickable.makebarrenfn = makebarrenfn
    inst.components.pickable.max_cycles = 1
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


return Prefab("sjy_shuidaobush", fn, assets, prefabs)
