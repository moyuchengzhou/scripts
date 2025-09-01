require "prefabutil" -- for the MakePlacer function

local banli_assets =
{
    -- 岩石鳄梨
    Asset("ANIM", "anim/banlibean.zip"),
    Asset("IMAGE", "images/inventoryimages/banlibean.tex"),
    Asset("ATLAS", "images/inventoryimages/banlibean.xml"),
}

local banlibean1_assets =
{
    -- 岩石鳄梨果实成熟
    Asset("ANIM", "anim/banlibean.zip"),
    Asset("IMAGE", "images/inventoryimages/banlibean1.tex"),
    Asset("ATLAS", "images/inventoryimages/banlibean1.xml"),
}

local cookbanli_assets =
{
    -- 熟的牛油果
    Asset("ANIM", "anim/banlibean.zip"),
    Asset("IMAGE", "images/inventoryimages/cookbanli.tex"),
    Asset("ATLAS", "images/inventoryimages/cookbanli.xml"),
   
}


local rock_fruit_prefabs = {
    "banlike",
    "banlibean1",
    "acorn",
    -- "banli_sprout_sapling",
}

local function on_mine(inst, miner, workleft, workdone)
    local num_fruits_worked = math.clamp(math.ceil(workdone / TUNING.ROCK_FRUIT_MINES), 1, inst.components.stackable:StackSize())

    local loot_data = TUNING.ROCK_FRUIT_LOOT
    if inst.components.stackable:StackSize() > num_fruits_worked then
        inst.AnimState:PlayAnimation("banlibeanidle")
        inst.AnimState:PushAnimation("banlibeanidle", false)
    end

    -- Generate a list of prefabs to create first and optimize the loop by having every type here.
    local spawned_prefabs = {
        ["banlibean1"] = 0,
        ["acorn"] = 0,
        ["banlike"] = 0,
    }
    local odds_ripe = loot_data.RIPE_CHANCE
    local odds_seed = odds_ripe + loot_data.SEED_CHANCE
    for _ = 1, num_fruits_worked do
        -- Choose a ripeness to spawn.
        local loot_roll = math.random()
        if loot_roll < odds_ripe then
            spawned_prefabs["banlibean1"] = spawned_prefabs["banlibean1"] + 1
        elseif loot_roll < odds_seed then
            spawned_prefabs["acorn"] = spawned_prefabs["acorn"] + 1
        else
            spawned_prefabs["banlike"] = spawned_prefabs["banlike"] + 1
        end
    end

    -- Then create these prefabs while stacking them up as much as they are able to.
    for prefab, count in pairs(spawned_prefabs) do
        local i = 1
        while i <= count do
            local loot = SpawnPrefab(prefab)
            local room = loot.components.stackable ~= nil and loot.components.stackable:RoomLeft() or 0
            if room > 0 then
                local stacksize = math.min(count - i, room) + 1
                loot.components.stackable:SetStackSize(stacksize)
                i = i + stacksize
            else
                i = i + 1
            end
            LaunchAt(loot, inst, miner, loot_data.SPEED, loot_data.HEIGHT, nil, loot_data.ANGLE)
            if prefab == "banlibean1" then
                loot.AnimState:PlayAnimation("banlibean1idle")
                loot.AnimState:PushAnimation("banlibean1idle")
            end
        end
    end

    -- Finally, remove the actual stack items we just consumed
    local top_stack_item = inst.components.stackable:Get(num_fruits_worked)
    top_stack_item:Remove()
end

local function OnExplosion_banli_full(inst, data)
    local miner = data and data.explosive or nil
    if miner then
        local loot_data = TUNING.ROCK_FRUIT_LOOT
        LaunchAt(inst, inst, miner, loot_data.SPEED, loot_data.HEIGHT, nil, loot_data.ANGLE)
    end
end

local function stack_size_changed(inst, data)
    if data ~= nil and data.stacksize ~= nil and inst.components.workable ~= nil then
        inst.components.workable:SetWorkLeft(data.stacksize * TUNING.ROCK_FRUIT_MINES)
    end
end

local function banli_full()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("banlibean")
    inst.AnimState:SetBuild("banlibean")
    inst.AnimState:PlayAnimation("banlibeanidle")

    inst.pickupsound = "rock"

    inst:AddTag("molebait")

    MakeInventoryPhysics(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    -- inst.components.inventoryitem:ChangeImageName("banlibean")
    inst.components.inventoryitem:SetSinks(true)

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("tradable")

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.MINE)
    inst.components.workable:SetWorkLeft(TUNING.ROCK_FRUIT_MINES * inst.components.stackable.stacksize)
    --inst.components.workable:SetOnFinishCallback(on_mine)
    inst.components.workable:SetOnWorkCallback(on_mine)

    inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.ELEMENTAL
    inst.components.edible.hungervalue = 2
    inst:AddComponent("bait")

    -- The amount of work needs to be updated whenever the size of the stack changes
    inst:ListenForEvent("stacksizechange", stack_size_changed)
    -- Explosions knock around these fruits in specific.
    inst:ListenForEvent("explosion", OnExplosion_banli_full)

    MakeHauntableLaunch(inst)
    inst.components.inventoryitem.atlasname = "images/inventoryimages/banlibean.xml"
    return inst
end

local function banlibean1()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("banlibean")
    inst.AnimState:SetBuild("banlibean")
    inst.AnimState:PlayAnimation("banlibean1idle")

    --cookable (from cookable component) added to pristine state for optimization
    inst:AddTag("cookable")

    inst:AddTag("molebait")

    MakeInventoryPhysics(inst)

    MakeInventoryFloatable(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.scrapbook_anim = "banlibean1idle"

    inst:AddComponent("edible")
    inst.components.edible.healthvalue = 3
    inst.components.edible.hungervalue = 12.3
    inst.components.edible.sanityvalue = 3
    inst.components.edible.foodtype = FOODTYPE.VEGGIE

    inst:AddComponent("bait")

    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(4800)
    inst.components.perishable.onperishreplacement = "spoiled_food"
    inst.components.perishable:StartPerishing()

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    -- inst.components.inventoryitem:ChangeImageName("banlibean1")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/banlibean1.xml"
    inst:AddComponent("tradable")

    inst:AddComponent("cookable")
    inst.components.cookable.product = "cookbanli"

    MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
    MakeSmallPropagator(inst)

    MakeHauntableLaunchAndPerish(inst)

  
    return inst
end

local function cookbanli()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("banlibean")
    inst.AnimState:SetBuild("banlibean")
    inst.AnimState:PlayAnimation("cookbanliidle")

    MakeInventoryPhysics(inst)

    MakeInventoryFloatable(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.scrapbook_anim = "cooked"

    inst:AddComponent("edible")
    inst.components.edible.healthvalue = -5
    inst.components.edible.hungervalue = 18
    inst.components.edible.sanityvalue = 5
    inst.components.edible.foodtype = FOODTYPE.VEGGIE

    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(4800)
    inst.components.perishable.onperishreplacement = "spoiled_food"
    inst.components.perishable:StartPerishing()

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    -- inst.components.inventoryitem:ChangeImageName("cookbanli")

    inst:AddComponent("tradable")

    MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
    MakeSmallPropagator(inst)

    MakeHauntableLaunchAndPerish(inst)

    inst.components.inventoryitem.atlasname = "images/inventoryimages/cookbanli.xml"

    return inst
end


return Prefab("cookbanli", cookbanli, cookbanli_assets),
    Prefab("banlibean1", banlibean1, banlibean1_assets, {"cookbanli"}),
    Prefab("banlibean", banli_full, banli_assets, rock_fruit_prefabs)
