local assets = {
    Asset("ANIM", "anim/myjmdqt_1_changpian.zip"),
    Asset("IMAGE", "images/inventoryimages/myjmdqt_1_changpian.tex"),
	Asset("ATLAS", "images/inventoryimages/myjmdqt_1_changpian.xml"),
    Asset("INV_IMAGE", "record"),
    Asset("SOUNDPACKAGE","sound/xincp.fev"),
    Asset("SOUND","sound/xincp.fsb"),
}

local RECORDS = {
    default = {song = "xincp/BGM/myjmdqt_1", imageicon = nil,},
}

local function SetRecord(inst, name)
    if name == nil then
        name = "default"
    end

    local recorddata = RECORDS[name]
    if recorddata == nil then
        print("Error: Bad record name to SetRecord.", inst, name)
        return
    end

    inst.recordname = name

    inst.songToPlay = recorddata.song
    if inst.songToPlay_skin == nil then -- FIXME(JBK): Manage inventory image names for other records that are not skins.
        inst.components.inventoryitem:ChangeImageName(recorddata.imageicon)
    end
end

-- Save/Load
local function OnSave(inst, data)
    if inst.recordname ~= "default" then
        data.name = inst.recordname
    end
end

local function OnLoad(inst, data)
    if data then
        if data.name then
            inst:SetRecord(data.name)
        end
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("myjmdqt_1_changpian")
    inst.AnimState:SetBuild("myjmdqt_1_changpian")
    inst.AnimState:PlayAnimation("idle")

    --inst.pickupsound = "vegetation_grassy"

    inst:AddTag("cattoy")
    inst:AddTag("phonograph_record")

    MakeInventoryFloatable(inst, "med", 0.02, 0.7)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.scrapbook_tex = "record"

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/myjmdqt_1_changpian.xml"
    inst:AddComponent("inspectable")
    inst:AddComponent("tradable")

    MakeHauntableLaunchAndIgnite(inst)

    inst.SetRecord = SetRecord
    inst.OnSave = OnSave
    inst.OnLoad = OnLoad

    inst:SetRecord()

    return inst
end

return Prefab("myjmdqt_1_changpian", fn, assets)
