require("worldsettingsutil")

local assets =
{
    Asset("ANIM", "anim/marsh_tile.zip"),
    Asset("ANIM", "anim/splash.zip"),
    Asset("IMAGE", "images/inventoryimages/sjy_chitang.tex"),
    Asset("ATLAS", "images/inventoryimages/sjy_chitang.xml"),
}

local prefabs_normal =
{
    "marsh_plant",
    "pondfish",
    "frog",
}


local function onhammered(inst, worker)   --锤敲掉落材料
   inst.components.lootdropper:DropLoot()
   local fx = SpawnPrefab("collapse_small")
   fx.Transform:SetPosition(inst.Transform:GetWorldPosition())  --特效
   fx:SetMaterial("metal")
   inst:Remove()  --移除
end

local function onbuilt(inst)               --建造虚影
   inst.AnimState:PlayAnimation("idle")
   inst.SoundEmitter:PlaySound("dontstarve/common/icebox_craft")
end


local function SpawnPlants(inst)
    inst.task = nil

    if inst.plant_ents ~= nil then
        return
    end

    if inst.plants == nil then
        inst.plants = {}
        for i = 1, math.random(2, 4) do
            local theta = math.random() * 2 * PI
            table.insert(inst.plants,
            {
                offset =
                {
                    math.sin(theta) * 1.9 + math.random() * .3,
                    0,
                    math.cos(theta) * 2.1 + math.random() * .3,
                },
            })
        end
    end

    inst.plant_ents = {}

    for i, v in pairs(inst.plants) do
        if type(v.offset) == "table" and #v.offset == 3 then
            local plant = SpawnPrefab(inst.planttype)
            if plant ~= nil then
                plant.entity:SetParent(inst.entity)
                plant.Transform:SetPosition(unpack(v.offset))
                plant.persists = false
                table.insert(inst.plant_ents, plant)
            end
        end
    end
end

local function DespawnPlants(inst)
    if inst.plant_ents ~= nil then
        for i, v in ipairs(inst.plant_ents) do
            if v:IsValid() then
                v:Remove()
            end
        end

        inst.plant_ents = nil
    end

    inst.plants = nil
end

local function OnSnowLevel(inst, snowlevel)
    if snowlevel > .02 then
        if not inst.frozen then
            inst.frozen = true
            inst.AnimState:PlayAnimation("frozen")
            inst.SoundEmitter:PlaySound("dontstarve/winter/pondfreeze")
            inst.components.childspawner:StopSpawning()
            inst.components.fishable:Freeze()

            inst.Physics:SetCollisionGroup(COLLISION.LAND_OCEAN_LIMITS)
            inst.Physics:ClearCollisionMask()
            inst.Physics:CollidesWith(COLLISION.WORLD)
            inst.Physics:CollidesWith(COLLISION.ITEMS)

            DespawnPlants(inst)

            inst.components.watersource.available = false
        end
    elseif inst.frozen then
        inst.frozen = false
        inst.AnimState:PlayAnimation("idle"..inst.pondtype, true)
        inst.components.childspawner:StartSpawning()
        inst.components.fishable:Unfreeze()

		inst.Physics:SetCollisionGroup(COLLISION.OBSTACLES)
        inst.Physics:ClearCollisionMask()
        inst.Physics:CollidesWith(COLLISION.ITEMS)
        inst.Physics:CollidesWith(COLLISION.CHARACTERS)
        inst.Physics:CollidesWith(COLLISION.GIANTS)

        SpawnPlants(inst)

        inst.components.watersource.available = true
    elseif inst.frozen == nil then
        inst.frozen = false
        SpawnPlants(inst)
    end
end

local function OnSave(inst, data)
    data.plants = inst.plants
    data.nitreformations = inst.nitreformations
end

local function OnLoad(inst, data)
    if data ~= nil then
        if inst.task ~= nil and inst.plants == nil then
            inst.plants = data.plants
        end
    end
end


local function OnPreLoadFrog(inst, data)
    WorldSettings_ChildSpawner_PreLoad(inst, data, TUNING.FROG_POND_SPAWN_TIME, TUNING.FROG_POND_REGEN_TIME)
end
local function commonfn(pondtype)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

	MakePondPhysics(inst, 1.95)

    inst.AnimState:SetBuild("marsh_tile")
    inst.AnimState:SetBank("marsh_tile")
    inst.AnimState:PlayAnimation("idle"..pondtype, true)
    print(pondtype)
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(3)

    inst.MiniMapEntity:SetIcon("pond"..pondtype..".png")

    -- From watersource component
    inst:AddTag("watersource")
    inst:AddTag("pond")
    inst:AddTag("antlion_sinkhole_blocker")
    inst:AddTag("birdblocker")

    inst.no_wet_prefix = true

    inst:SetDeployExtraSpacing(2)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.pondtype = pondtype

    inst:AddComponent("childspawner")

    --inst.frozen = nil
    --inst.acidinfused = nil
    --inst.plants = nil
    --inst.plant_ents = nil
    --inst.nitreformations = nil
    --inst.nitreformation_ents = nil

    inst:AddComponent("inspectable")
    inst.components.inspectable.nameoverride = "pond"

    inst:AddComponent("fishable")
    inst.components.fishable:SetRespawnTime(TUNING.FISH_RESPAWN_TIME)

    inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

    inst:AddComponent("watersource")

    inst.OnSave = OnSave
    inst.OnLoad = OnLoad

    return inst
end

local function ReturnChildren(inst)
    for k, child in pairs(inst.components.childspawner.childrenoutside) do
        if child.components.homeseeker ~= nil then
            child.components.homeseeker:GoHome()
        end
        child:PushEvent("gohome")
    end
end

local function OnIsDay(inst, isday)
    if isday ~= inst.dayspawn then
        inst.components.childspawner:StopSpawning()
        ReturnChildren(inst)
    elseif not TheWorld.state.iswinter then
        inst.components.childspawner:StartSpawning()
    end
end

local function OnInit(inst)
    inst.task = nil
    inst:WatchWorldState("isday", OnIsDay)
    inst:WatchWorldState("snowlevel", OnSnowLevel)
    OnIsDay(inst, TheWorld.state.isday)
    OnSnowLevel(inst, TheWorld.state.snowlevel)
end



local function pondfrog()
    local inst = commonfn("")

    if not TheWorld.ismastersim then
        return inst
    end

    inst.components.childspawner:SetSpawnPeriod(TUNING.FROG_POND_SPAWN_TIME)
    inst.components.childspawner:SetRegenPeriod(TUNING.FROG_POND_REGEN_TIME)
    if TUNING.FROG_POND_CHILDREN.max == 0 then
        inst.components.childspawner:SetMaxChildren(0)
    else
        inst.components.childspawner:SetMaxChildren(math.random(TUNING.FROG_POND_CHILDREN.min, TUNING.FROG_POND_CHILDREN.max))
    end

    WorldSettings_ChildSpawner_SpawnPeriod(inst, TUNING.FROG_POND_SPAWN_TIME, TUNING.FROG_POND_ENABLED)
    WorldSettings_ChildSpawner_RegenPeriod(inst, TUNING.FROG_POND_REGEN_TIME, TUNING.FROG_POND_ENABLED)
    if not TUNING.FROG_POND_ENABLED then
        inst.components.childspawner.childreninside = 0
    end

    inst.components.childspawner:StartRegen()
    inst.components.childspawner.childname = "wobster_sheller_land"
    inst.components.fishable:AddFish("pondeel")
    inst:AddComponent("lootdropper")  
    inst:AddComponent("workable")                              --添加可破坏组件
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)     --锤子
    inst.components.workable:SetWorkLeft(4)                    --敲4次
    inst.components.workable:SetOnFinishCallback(onhammered)   --锤敲掉落材料

    inst:ListenForEvent("onbuilt", onbuilt)                    --监听:建造

    inst.planttype = "flower_cave"
    inst.dayspawn = true
    inst.task = inst:DoTaskInTime(0, OnInit)

    inst.OnPreLoad = OnPreLoadFrog

    return inst
end

return
        Prefab( "sjy_chitang",  pondfrog, assets, prefabs_normal ),
        MakePlacer("sjy_chitang_placer", "marsh_tile", "marsh_tile", "idle")
