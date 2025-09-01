require "prefabutil"
--路灯
local assets = 
{
   Asset("ANIM", "anim/sjy_jiangbingxiang1.zip"), 
   Asset("IMAGE", "images/inventoryimages/sjy_jiangbingxiang1.tex"),
   Asset("ATLAS", "images/inventoryimages/sjy_jiangbingxiang1.xml"),
   --默认:雪人
}

local function onopen(inst)
    --inst.AnimState:PlayAnimation("open")
    inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open")
end

local function onclose(inst)
    --inst.AnimState:PlayAnimation("close")
    inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close")
end

-- local function onhammered(inst, worker)   --锤敲掉落材料
--    inst.components.lootdropper:DropLoot()
--    local fx = SpawnPrefab("collapse_small")
--    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())  --特效
--    fx:SetMaterial("metal")
--    inst:Remove()  --移除
-- end

local function onbuilt(inst)               --建造虚影
   inst.AnimState:PlayAnimation("idle")
   inst.SoundEmitter:PlaySound("dontstarve/common/icebox_craft")
end


local function onhammered(inst,worker)
   inst.components.lootdropper:DropLoot()
   if inst.components.container then
      inst.components.container:DropEverything()-- body
   end
   local fx = SpawnPrefab("collapse_small")
   fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
   inst:Remove()
   
end


function fn()
   local inst = CreateEntity()                     --创建一个实体
   inst.entity:AddTransform()                      --添加坐标组件
   inst.entity:AddNetwork()                        --添加网络组件
   inst.entity:AddSoundEmitter()                   --添加声音组件
     
   inst.entity:AddAnimState()                      --添加动画组件
   inst.AnimState:SetBank("sjy_jiangbingxiang1")        --
   inst.AnimState:SetBuild("sjy_jiangbingxiang1")       --smcl文件的名字
   inst.AnimState:PlayAnimation("idle")            --动画子名称,播放的就是它

   inst:AddTag("sjy_jiangbingxiang1")                   --独有标签
    
   inst:AddTag("structure")                        --建筑标签

   inst.entity:SetPristine()                       --初始化

   

   if not TheWorld.ismastersim then                --接下来的代码仅主机运行
      return inst
   end
   inst:AddComponent("container")
   inst.components.container:WidgetSetup("sjy_jiangbingxiang1")
   inst.components.container.onopenfn = onopen
   inst.components.container.onclosefn = onclose
   inst.components.container.skipclosesnd = true
   inst.components.container.skipopensnd = true

   inst:AddComponent("inspectable")                           --添加可检查组件

   inst:AddComponent("lootdropper")                           --添加掉落组件  --破坏组件需求

   inst:AddComponent("workable")                              --添加可破坏组件
   inst.components.workable:SetWorkAction(ACTIONS.HAMMER)     --锤子
   inst.components.workable:SetWorkLeft(4)                    --敲4次
   inst.components.workable:SetOnFinishCallback(onhammered)   --锤敲掉落材料
   
   inst:ListenForEvent("onbuilt", onbuilt)                    --监听:建造
   inst:AddComponent("hauntable")                             --可闹鬼的
    
   return inst
end

return Prefab("sjy_jiangbingxiang1", fn, assets),
MakePlacer("sjy_jiangbingxiang1_placer", "sjy_jiangbingxiang1", "sjy_jiangbingxiang1", "idle")