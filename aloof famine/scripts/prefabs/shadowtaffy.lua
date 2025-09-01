local assets =
{
    Asset("ANIM", "anim/shadowtaffy.zip"),
    Asset("ATLAS","images/inventoryimages/shadowtaffy.xml"),
	Asset("IMAGE","images/inventoryimages/shadowtaffy.tex"),
}

STRINGS.NAMES.SHADOWTAFFY = "阴影太妃糖"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SHADOWTAFFY = "暗影的力量如此甜美"



local function oneaten(inst, eater)
    if eater.components.timer and eater:HasTag("player") then -- 判断是玩家
        eater.components.debuffable:AddDebuff("shadowtaffybuff", "shadowtaffybuff")
			
        
    end
end


local function fn()
    local inst = CreateEntity()
	inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("shadowtaffy")
    inst.AnimState:SetBuild("shadowtaffy")
    inst.AnimState:PlayAnimation("idle")
    inst:AddTag("preparedfood")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "shadowtaffy"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/shadowtaffy.xml"

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("edible")
    inst.components.edible.foodtype = "GOODIES"--食物类型
    inst.components.edible.healthvalue = 0
    inst.components.edible.hungervalue = 0
    inst.components.edible.sanityvalue = -80
	inst.components.edible:SetOnEatenFn(oneaten)
	
	
	
    inst:AddComponent("inspectable")
    inst:AddComponent("tradable")
    inst:AddComponent("timer")
	




    return inst
end

return Prefab("shadowtaffy", fn, assets)