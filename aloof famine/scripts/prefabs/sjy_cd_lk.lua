local assets = {
   Asset("ANIM", "anim/xl_changpian.zip"),
   Asset("IMAGE", "images/inventoryimages/xl_changpian.tex"),
   Asset("ATLAS", "images/inventoryimages/xl_changpian.xml"),

   Asset("SOUNDPACKAGE","sound/sjy_lk.fev"),
   Asset("SOUND","sound/sjy_lk.fsb"),
}

STRINGS.NAMES.SJY_RENYUWAN = "洛克_人鱼湾"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SJY_RENYUWAN = "洛克_人鱼湾"
STRINGS.RECIPE_DESC.SJY_RENYUWAN = "洛克_人鱼湾"
STRINGS.NAMES.SJY_MYFARM = "洛克_我的农场"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SJY_MYFARM = "洛克_我的农场"
STRINGS.RECIPE_DESC.SJY_MYFARM = "洛克_我的农场"
STRINGS.NAMES.SJY_XUERENGU = "洛克_雪人谷"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SJY_XUERENGU = "洛克_雪人谷"
STRINGS.RECIPE_DESC.SJY_XUERENGU = "洛克_雪人谷"

local function SetRecord(inst, name)
   if name == nil then
       name = "default"
   end
   local RECORDS = 
   {
   default = {song = "sjy_lk/sjy_lk/"..inst.cdname, imageicon = nil,},
   }

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

local function make(cd_name)
local function fn()

   local inst = CreateEntity()

   inst.entity:AddTransform()
   inst.entity:AddAnimState()
   inst.entity:AddNetwork()

   MakeInventoryPhysics(inst)
   
   inst.AnimState:SetBank("xl_changpian")
   inst.AnimState:SetBuild("xl_changpian")
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
   inst.components.inventoryitem.imagename = "xl_changpian"
   inst.components.inventoryitem.atlasname = "images/inventoryimages/xl_changpian.xml"
   inst:AddComponent("inspectable")
   inst:AddComponent("tradable")

   MakeHauntableLaunchAndIgnite(inst)


   inst.cdname = cd_name

   inst.SetRecord = SetRecord
   inst.OnSave = OnSave
   inst.OnLoad = OnLoad

   inst:SetRecord()

   return inst
end
return Prefab(cd_name, fn, assets)

end

return  make("sjy_xuerengu"),
        make("sjy_renyuwan"),
        make("sjy_myfarm")