local BERRY_TYPES = { "berries", "berriesmore", "berriesmost" }
local function setberries(inst, pct) --设置浆果
    if inst._setberriesonanimover then
        inst._setberriesonanimover = nil
        inst:RemoveEventCallback("animover", setberries)
    end

    local berries =
        (not pct and "") or
        (pct >= .9 and "berriesmost") or
        (pct >= .33 and "berriesmore") or
        "berries"

    for i, berry_type in ipairs(BERRY_TYPES) do
        if berry_type == berries then
            inst.AnimState:Show(berry_type)
        else
            inst.AnimState:Hide(berry_type)
        end
    end
end

local function setberriesonanimover(inst)
    if inst._setberriesonanimover then
        setberries(inst, nil)
    else
        inst._setberriesonanimover = true
        inst:ListenForEvent("animover", setberries)
    end
end

local function cancelsetberriesonanimover(inst)
    if inst._setberriesonanimover then
        setberries(inst, nil)
    end
end

local function makeemptyfn(inst) --把浆果丛上的浆果移除【摘了，吃了
    if POPULATING then
        inst.AnimState:PlayAnimation("idle", true)
		inst.AnimState:SetFrame(math.random(inst.AnimState:GetCurrentAnimationNumFrames()) - 1)
    elseif inst:HasTag("withered") or inst.AnimState:IsCurrentAnimation("dead") then
        --inst.SoundEmitter:PlaySound("dontstarve/common/bush_fertilize")
        inst.AnimState:PlayAnimation("dead_to_idle")
        inst.AnimState:PushAnimation("idle")
    else
        inst.AnimState:PlayAnimation("idle", true)
    end
    setberries(inst, nil)
end

local function makebarrenfn(inst)--, wasempty) --空了的时候开始生长浆果的【制作浆果（直译hh
    if not POPULATING and (inst:HasTag("withered") or inst.AnimState:IsCurrentAnimation("idle")) then
        inst.AnimState:PlayAnimation("idle_to_dead")
        inst.AnimState:PushAnimation("dead", false)
    else
        inst.AnimState:PlayAnimation("dead")
    end
    cancelsetberriesonanimover(inst)
end

local function shake(inst) --生成火鸡的时候浆果丛会抖动【抖动的代码
    if inst.components.pickable and
            not inst.components.pickable:CanBePicked() and
            inst.components.pickable:IsBarren() then
        inst.AnimState:PlayAnimation("shake_dead")
        inst.AnimState:PushAnimation("dead", false)
    else
        inst.AnimState:PlayAnimation("shake")
        inst.AnimState:PushAnimation("idle")
    end
    cancelsetberriesonanimover(inst)
end

local function spawnperd(inst) --生成火鸡的
    if inst:IsValid() then
        local perd = SpawnPrefab("caomeixie")
        local x, y, z = inst.Transform:GetWorldPosition()
        local angle = math.random() * PI2
        perd.Transform:SetPosition(x + math.cos(angle), 0, z + math.sin(angle))
        perd.sg:GoToState("appear")
        perd.components.homeseeker:SetHome(inst)
        shake(inst)
    end
end

local function onpickedfn(inst, picker) --被采摘的时候
    if inst.components.pickable then
        --V2C: nil cycles_left means unlimited picks, so use max value for math
        --local old_percent = inst.components.pickable.cycles_left ~= nil and (inst.components.pickable.cycles_left + 1) / inst.components.pickable.max_cycles or 1
        --setberries(inst, old_percent)
        if inst.components.pickable:IsBarren() then
            inst.AnimState:PlayAnimation("idle_to_dead")
            inst.AnimState:PushAnimation("dead", false)
            setberries(inst, nil)
        else
            inst.AnimState:PlayAnimation("picked")
            inst.AnimState:PushAnimation("idle")
            setberriesonanimover(inst)
        end
    end

    if not (picker and picker:HasTag("berrythief") or inst._noperd) and
            math.random() < (IsSpecialEventActive(SPECIAL_EVENTS.YOTG) and TUNING.YOTG_PERD_SPAWNCHANCE or TUNING.PERD_SPAWNCHANCE) then
        inst:DoTaskInTime(3 + math.random() * 3, spawnperd)
    end
end

local function getregentimefn_normal(inst) --普通 的再生时间计算？
    if not inst.components.pickable then
        return TUNING.BERRY_REGROW_TIME
    end
    --V2C: nil cycles_left means unlimited picks, so use max value for math
    local max_cycles = inst.components.pickable.max_cycles
    local cycles_left = inst.components.pickable.cycles_left or max_cycles
    local num_cycles_passed = math.max(0, max_cycles - cycles_left)
    return TUNING.BERRY_REGROW_TIME
        + TUNING.BERRY_REGROW_INCREASE * num_cycles_passed
        + TUNING.BERRY_REGROW_VARIANCE * math.random()
end


local function makefullfn(inst) --长好了
    local anim = "idle"
    local berries = nil
    if inst.components.pickable then
        if inst.components.pickable:CanBePicked() then
            berries = (inst.components.pickable.cycles_left and inst.components.pickable.cycles_left / inst.components.pickable.max_cycles) or 1
        elseif inst.components.pickable:IsBarren() then
            anim = "dead"
        end
    end
    if anim ~= "idle" then
        inst.AnimState:PlayAnimation(anim)
    elseif POPULATING then
        inst.AnimState:PlayAnimation("idle", true)
		inst.AnimState:SetFrame(math.random(inst.AnimState:GetCurrentAnimationNumFrames()) - 1)
    else
        inst.AnimState:PlayAnimation("grow")
        inst.AnimState:PushAnimation("idle", true)
    end
    setberries(inst, berries)
end

local function dig_up_common(inst, worker, numberries) --铲掉
    if inst.components.pickable and inst.components.lootdropper then
        local withered = (inst.components.witherable ~= nil and inst.components.witherable:IsWithered())


        if withered or inst.components.pickable:IsBarren() then
            inst.components.lootdropper:SpawnLootPrefab("twigs")
            inst.components.lootdropper:SpawnLootPrefab("twigs")
        else
            if inst.components.pickable:CanBePicked() then
                local pt = inst:GetPosition()
                pt.y = pt.y + (inst.components.pickable.dropheight or 0)
                for i = 1, numberries do
                    inst.components.lootdropper:SpawnLootPrefab(inst.components.pickable.product, pt)
                end
            end
            inst.components.lootdropper:SpawnLootPrefab("dug_"..inst.prefab)
        end
    end
    inst:Remove()
end

local function dig_up_normal(inst, worker) --铲普通的作物
    dig_up_common(inst, worker, 1)
end


local function ontransplantfn(inst) --移植【种植
    inst.AnimState:PlayAnimation("dead")
    setberries(inst, nil)
    inst.components.pickable:MakeBarren()
end

local function OnHaunt(inst) --作祟
    if math.random() <= TUNING.HAUNT_CHANCE_ALWAYS then
        shake(inst)
        inst.components.hauntable.hauntvalue = TUNING.HAUNT_COOLDOWN_TINY
        return true
    else
        return false
    end
end

local function OnSave(inst, data) --存储
    data.was_herd = inst.components.herdmember and true or nil
end

local function OnPreLoad(inst, data) --读取
    if data and data.was_herd then
        if TheWorld.components.lunarthrall_plantspawner then
            TheWorld.components.lunarthrall_plantspawner:setHerdsOnPlantable(inst)
        end
    end    
end

-- local function createbush(name, inspectname, berryname, master_postinit)
--     local assets =
--     {
--         Asset("ANIM", "anim/"..name..".zip"),
--         Asset("PKGREF", "anim/berrybush.zip"),
		
-- 		--Asset("ATLAS","images/inventoryimages/"..name..".xml"),
-- 		--Asset("IMAGE","images/inventoryimages/"..name..".tex"),
--     }

--     local prefabs =
--     {
--         berryname,
--         "dug_"..name,
--         "perd",
--         "twigs",
--         "spoiled_food",
--     }

--     local function fn()
--         local inst = CreateEntity()

--         inst.entity:AddTransform()
--         inst.entity:AddAnimState()
--         inst.entity:AddMiniMapEntity()
--         inst.entity:AddNetwork()
-- 		inst.MiniMapEntity:SetIcon(name..".tex")

--         MakeSmallObstaclePhysics(inst, .1)

--         inst:AddTag("bush")
--         inst:AddTag("plant")
--         inst:AddTag("renewable")
--         inst:AddTag("lunarplant_target")

--         --witherable (from witherable component) added to pristine state for optimization
--         inst:AddTag("witherable")

--         local is_quagmire = (TheNet:GetServerGameMode() == "quagmire")
--         if is_quagmire then
--             -- for stats tracking
--             inst:AddTag("quagmire_wildplant")
--         end

--         --inst.MiniMapEntity:SetIcon(name..".png") --设置地图上的图标(居然是png！？
-- 		--好像没用？
-- 		   -- inst.MiniMapEntity:SetIcon(name..".tex")
--         inst.AnimState:SetBank(name)
--         inst.AnimState:SetBuild(name)
--         inst.AnimState:PlayAnimation("idle", true)
--         setberries(inst, 1)

--         MakeSnowCoveredPristine(inst)

--         inst.scrapbook_specialinfo = "NEEDFERTILIZER"

--         inst.entity:SetPristine()
--         if not TheWorld.ismastersim then
--             return inst
--         end
		
--         print(inst.AnimState:GetCurrentAnimationNumFrames())

-- 		inst.AnimState:SetFrame(math.random(inst.AnimState:GetCurrentAnimationNumFrames()) - 1)

--         inst:AddComponent("pickable")
--         inst.components.pickable.picksound = "dontstarve/wilson/harvest_berries"
--         inst.components.pickable.onpickedfn = onpickedfn
--         inst.components.pickable.makeemptyfn = makeemptyfn
--         inst.components.pickable.makebarrenfn = makebarrenfn
--         inst.components.pickable.makefullfn = makefullfn
--         inst.components.pickable.ontransplantfn = ontransplantfn

--         inst:AddComponent("witherable")

--         MakeLargeBurnable(inst)
--         MakeMediumPropagator(inst)

--         MakeHauntableIgnite(inst)
--         AddHauntableCustomReaction(inst, OnHaunt, false, false, true)

--         inst:AddComponent("lootdropper")

--         if not GetGameModeProperty("disable_transplanting") then
--             inst:AddComponent("workable")
--             inst.components.workable:SetWorkAction(ACTIONS.DIG)
--             inst.components.workable:SetWorkLeft(1)
--         end

--         inst:AddComponent("inspectable")
--         if name ~= inspectname then
--             inst.components.inspectable.nameoverride = inspectname
--         end

--         inst:ListenForEvent("onwenthome", shake)
--         MakeSnowCovered(inst)
--         MakeNoGrowInWinter(inst)

--         master_postinit(inst)

--         if IsSpecialEventActive(SPECIAL_EVENTS.YOTG) then
--             inst:ListenForEvent("spawnperd", spawnperd)
--         end

--         if is_quagmire then
--             event_server_data("quagmire", "prefabs/berrybush").master_postinit(inst)
--         end

--         inst.OnSave = OnSave
--         inst.OnPreLoad = OnPreLoad

--         return inst
--     end

--     return Prefab(name, fn, assets, prefabs)
-- end

local function createcaomeibush(name, inspectname, berryname, master_postinit)
    local assets =
    {
        Asset("ANIM", "anim/"..name..".zip"),
        Asset("PKGREF", "anim/berrybush.zip"),
        Asset("IMAGE", "images/inventoryimages/caomeibush.tex"),
	    Asset("ATLAS", "images/inventoryimages/caomeibush.xml"),

    }

    local prefabs =
    {
        berryname,
        "dug_"..name,
        "caomeixie",
        "twigs",
    }

    local function fn()

        local caomeibush = "caomeibush"

        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddMiniMapEntity()
        inst.entity:AddNetwork()

        MakeSmallObstaclePhysics(inst, .1)

        inst:AddTag("bush")
        inst:AddTag("plant")
        inst:AddTag("renewable")
        inst:AddTag("lunarplant_target")

        --可凋谢（来自可凋谢组件）添加到原始状态以进行优化
        inst:AddTag("witherable")

        inst.MiniMapEntity:SetIcon(caomeibush..".tex")
        -- print (name)
        -- inst.MiniMapEntity:SetIcon(caomeibush.tex)

        inst.AnimState:SetBank("berrybush")
        inst.AnimState:SetBuild("berrybush")
        inst.AnimState:PlayAnimation("blown_loop_idle1", true)
        setberries(inst, 1)

        inst.AnimState:OverrideSymbol("bush_berry_build","caomeibush","bush_berry_build")
        inst.AnimState:OverrideSymbol("berries","caomeibush","berries")

        MakeSnowCoveredPristine(inst)

        inst.scrapbook_specialinfo = "NEEDFERTILIZER"

        inst.entity:SetPristine()
        if not TheWorld.ismastersim then
            return inst
        end

        print(inst.AnimState:GetCurrentAnimationNumFrames())

		inst.AnimState:SetFrame(math.random(inst.AnimState:GetCurrentAnimationNumFrames()) - 1)

        inst:AddComponent("pickable")
        inst.components.pickable.picksound = "dontstarve/wilson/harvest_berries"
        inst.components.pickable.onpickedfn = onpickedfn
        inst.components.pickable.makeemptyfn = makeemptyfn
        inst.components.pickable.makebarrenfn = makebarrenfn
        inst.components.pickable.makefullfn = makefullfn
        inst.components.pickable.ontransplantfn = ontransplantfn

        inst:AddComponent("witherable")

        MakeLargeBurnable(inst)
        MakeMediumPropagator(inst)

        MakeHauntableIgnite(inst)
        AddHauntableCustomReaction(inst, OnHaunt, false, false, true)

        inst:AddComponent("lootdropper")

        if not GetGameModeProperty("disable_transplanting") then
            inst:AddComponent("workable")
            inst.components.workable:SetWorkAction(ACTIONS.DIG)
            inst.components.workable:SetWorkLeft(1)
        end

        inst:AddComponent("inspectable")

        inst:ListenForEvent("onwenthome", shake)
        MakeSnowCovered(inst)
        MakeNoGrowInWinter(inst)

        master_postinit(inst)

        if IsSpecialEventActive(SPECIAL_EVENTS.YOTG) then
            inst:ListenForEvent("spawnperd", spawnperd)
        end

        inst.OnSave = OnSave
        inst.OnPreLoad = OnPreLoad

        return inst
    end

    return Prefab(name, fn, assets, prefabs)
end

local function createlanmeibush(name, inspectname, berryname, master_postinit)
    local assets =
    {
        Asset("ANIM", "anim/"..name..".zip"),
        Asset("PKGREF", "anim/berrybush.zip"),
        Asset("IMAGE", "images/inventoryimages/lanmeibush.tex"),
	    Asset("ATLAS", "images/inventoryimages/lanmeibush.xml"),
    }

    local prefabs =
    {
        berryname,
        "dug_"..name,
        "caomeixie",
        "twigs",
    }

    local function fn()

        local lanmeibush = "lanmeibush"

        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddMiniMapEntity()
        inst.entity:AddNetwork()

        MakeSmallObstaclePhysics(inst, .1)

        inst:AddTag("bush")
        inst:AddTag("plant")
        inst:AddTag("renewable")
        inst:AddTag("lunarplant_target")

        --可凋谢（来自可凋谢组件）添加到原始状态以进行优化
        inst:AddTag("witherable")

        inst.MiniMapEntity:SetIcon(lanmeibush..".tex")

        inst.AnimState:SetBank("berrybush")
        inst.AnimState:SetBuild("berrybush")
        inst.AnimState:PlayAnimation("idle", true)
        setberries(inst, 1)

        inst.AnimState:OverrideSymbol("bush_berry_build","lanmeibush","bush_berry_build")
        inst.AnimState:OverrideSymbol("berries","lanmeibush","berries")

        MakeSnowCoveredPristine(inst)

        inst.scrapbook_specialinfo = "NEEDFERTILIZER"

        inst.entity:SetPristine()
        if not TheWorld.ismastersim then
            return inst
        end

        print(inst.AnimState:GetCurrentAnimationNumFrames())

		inst.AnimState:SetFrame(math.random(inst.AnimState:GetCurrentAnimationNumFrames()) - 1)

        inst:AddComponent("pickable")
        inst.components.pickable.picksound = "dontstarve/wilson/harvest_berries"
        inst.components.pickable.onpickedfn = onpickedfn
        inst.components.pickable.makeemptyfn = makeemptyfn
        inst.components.pickable.makebarrenfn = makebarrenfn
        inst.components.pickable.makefullfn = makefullfn
        inst.components.pickable.ontransplantfn = ontransplantfn

        inst:AddComponent("witherable")

        MakeLargeBurnable(inst)
        MakeMediumPropagator(inst)

        MakeHauntableIgnite(inst)
        AddHauntableCustomReaction(inst, OnHaunt, false, false, true)

        inst:AddComponent("lootdropper")

        if not GetGameModeProperty("disable_transplanting") then
            inst:AddComponent("workable")
            inst.components.workable:SetWorkAction(ACTIONS.DIG)
            inst.components.workable:SetWorkLeft(1)
        end

        inst:AddComponent("inspectable")

        inst:ListenForEvent("onwenthome", shake)
        MakeSnowCovered(inst)
        MakeNoGrowInWinter(inst)

        master_postinit(inst)

        if IsSpecialEventActive(SPECIAL_EVENTS.YOTG) then
            inst:ListenForEvent("spawnperd", spawnperd)
        end

        inst.OnSave = OnSave
        inst.OnPreLoad = OnPreLoad

        return inst
    end

    return Prefab(name, fn, assets, prefabs)
end

local function normal_postinit(inst) --普通浆果
    inst.components.pickable:SetUp("caomeibean", TUNING.BERRY_REGROW_TIME)
    inst.components.pickable.getregentimefn = getregentimefn_normal
    inst.components.pickable.max_cycles = TUNING.BERRYBUSH_CYCLES + math.random(2)
    inst.components.pickable.cycles_left = inst.components.pickable.max_cycles

    if inst.components.workable then
        inst.components.workable:SetOnFinishCallback(dig_up_normal)
    end
end

local function lanmeibean(inst) --普通浆果
    inst.components.pickable:SetUp("lanmeibean", TUNING.BERRY_REGROW_TIME)
    inst.components.pickable.getregentimefn = getregentimefn_normal
    inst.components.pickable.max_cycles = TUNING.BERRYBUSH_CYCLES + math.random(2)
    inst.components.pickable.cycles_left = inst.components.pickable.max_cycles

    if inst.components.workable then
        inst.components.workable:SetOnFinishCallback(dig_up_normal)
    end
end

-- local function mogu(inst) --普通浆果
--     inst.components.pickable:SetUp("mogu", TUNING.BERRY_REGROW_TIME)
--     inst.components.pickable.getregentimefn = getregentimefn_normal
--     inst.components.pickable.max_cycles = TUNING.BERRYBUSH_CYCLES + math.random(2)
--     inst.components.pickable.cycles_left = inst.components.pickable.max_cycles

--     if inst.components.workable then
--         inst.components.workable:SetOnFinishCallback(dig_up_normal)
--     end
-- end

-- local function createtouxiang(name, inspectname, berryname, master_postinit)
--     local assets =
--     {
--         Asset("ANIM", "anim/"..name..".zip"),
--         Asset("PKGREF", "anim/touxiang.zip"),
--         Asset("IMAGE", "images/inventoryimages/touxiang.tex"),
-- 	    Asset("ATLAS", "images/inventoryimages/touxiang.xml"),

--     }

--     local prefabs =
--     {
--         berryname,
--         "dug_"..name,
--         "perd",
--         "twigs",
--     }

--     local function fn()

--         local touxiang = "touxiang"

--         local inst = CreateEntity()

--         inst.entity:AddTransform()
--         inst.entity:AddAnimState()
--         inst.entity:AddMiniMapEntity()
--         inst.entity:AddNetwork()

--         MakeSmallObstaclePhysics(inst, .1)

--         inst:AddTag("bush")
--         inst:AddTag("plant")
--         inst:AddTag("renewable")
--         inst:AddTag("lunarplant_target")

--         --可凋谢（来自可凋谢组件）添加到原始状态以进行优化
--         inst:AddTag("witherable")

--         inst.MiniMapEntity:SetIcon(touxiang..".tex")
--         -- print (name)
--         -- inst.MiniMapEntity:SetIcon(touxiang.tex)

--         inst.AnimState:SetBank(name)
--         inst.AnimState:SetBuild(name)
--         inst.AnimState:PlayAnimation("idle", true)
--         setberries(inst, 1)

--         -- inst.AnimState:OverrideSymbol("bush_berry_build","touxiang","bush_berry_build")
--         -- inst.AnimState:OverrideSymbol("berries","touxiang","berries")

--         MakeSnowCoveredPristine(inst)

--         inst.scrapbook_specialinfo = "NEEDFERTILIZER"

--         inst.entity:SetPristine()
--         if not TheWorld.ismastersim then
--             return inst
--         end

--         print(inst.AnimState:GetCurrentAnimationNumFrames())

-- 		inst.AnimState:SetFrame(math.random(inst.AnimState:GetCurrentAnimationNumFrames()) - 1)

--         inst:AddComponent("pickable")
--         inst.components.pickable.picksound = "dontstarve/wilson/harvest_berries"
--         inst.components.pickable.onpickedfn = onpickedfn
--         inst.components.pickable.makeemptyfn = makeemptyfn
--         inst.components.pickable.makebarrenfn = makebarrenfn
--         inst.components.pickable.makefullfn = makefullfn
--         inst.components.pickable.ontransplantfn = ontransplantfn

--         inst:AddComponent("witherable")

--         MakeLargeBurnable(inst)
--         MakeMediumPropagator(inst)

--         MakeHauntableIgnite(inst)
--         AddHauntableCustomReaction(inst, OnHaunt, false, false, true)

--         inst:AddComponent("lootdropper")

--         if not GetGameModeProperty("disable_transplanting") then
--             inst:AddComponent("workable")
--             inst.components.workable:SetWorkAction(ACTIONS.DIG)
--             inst.components.workable:SetWorkLeft(1)
--         end

--         inst:AddComponent("inspectable")

--         inst:ListenForEvent("onwenthome", shake)
--         MakeSnowCovered(inst)
--         MakeNoGrowInWinter(inst)

--         master_postinit(inst)

--         if IsSpecialEventActive(SPECIAL_EVENTS.YOTG) then
--             inst:ListenForEvent("spawnperd", spawnperd)
--         end

--         inst.OnSave = OnSave
--         inst.OnPreLoad = OnPreLoad

--         return inst
--     end

--     return Prefab(name, fn, assets, prefabs)
-- end


return createcaomeibush("caomeibush", nil, "caomeibean", normal_postinit),
       createlanmeibush("lanmeibush", nil, "berries", lanmeibean)
    --    createtouxiang("touxiang", nil, "mogu", mogu)
