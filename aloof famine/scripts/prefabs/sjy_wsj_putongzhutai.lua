require "prefabutil"
--路灯
local assets = 
{
   Asset("ANIM", "anim/sjy_wsj_putongzhutai.zip"),  
   Asset("IMAGE", "images/inventoryimages/sjy_wsj_putongzhutai.tex"),
   Asset("ATLAS", "images/inventoryimages/sjy_wsj_putongzhutai.xml"),--默认:雪人
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

-- local function CalcSanityAura(inst)
--     return inst.components.lootdropper.target ~= nil and -10 or -20
-- end

local function zidonglight(inst, phase)             --自动灯光
   if phase == "night" then
      inst.AnimState:PlayAnimation("idle2")
      inst.Light:Enable(true)                       --夜晚发光
   else
      inst.AnimState:PlayAnimation("idle")
      inst.Light:Enable(false)                      --其余时间关闭
   end
end

function fn()
   local inst = CreateEntity()                     --创建一个实体
   inst.entity:AddTransform()                      --添加坐标组件
   inst.entity:AddNetwork()                        --添加网络组件
   inst.entity:AddSoundEmitter()                   --添加声音组件
     
   inst.entity:AddLight()                          --添加发光组件
   inst.Light:Enable(false)                        --默认关
   inst.Light:SetRadius(2*2)                       --发光范围:半径2格地皮
   inst.Light:SetFalloff(1)                        --衰减
   inst.Light:SetIntensity(0.5)                   --强度
   inst.Light:SetColour(248/255, 206/255, 44/255)  --黄色

   inst.entity:AddAnimState()                      --添加动画组件
   inst.AnimState:SetBank("sjy_wsj_putongzhutai")        --
   inst.AnimState:SetBuild("sjy_wsj_putongzhutai")       --smcl文件的名字
   inst.AnimState:PlayAnimation("idle")            --动画子名称,播放的就是它

   inst:AddTag("sjy_wsj_putongzhutai")                   --独有标签

   inst:AddTag("lightsource")                      --光源
    
   inst:AddTag("structure")                        --建筑标签

   inst.entity:SetPristine()                       --初始化

   if not TheWorld.ismastersim then                --接下来的代码仅主机运行
      return inst
   end

   inst:AddComponent("inspectable")                           --添加可检查组件

   inst:AddComponent("lootdropper")                           --添加掉落组件  --破坏组件需求
--    inst:AddComponent("sanityaura")
--    inst.components.sanityaura.aurafn = CalcSanityAura
   inst:AddComponent("workable")                              --添加可破坏组件
   inst.components.workable:SetWorkAction(ACTIONS.HAMMER)     --锤子
   inst.components.workable:SetWorkLeft(4)                    --敲4次
   inst.components.workable:SetOnFinishCallback(onhammered)   --锤敲掉落材料
   

   inst:WatchWorldState("phase", zidonglight)                 --自动灯光
   zidonglight(inst, TheWorld.state.phase)
   
   inst:ListenForEvent("onbuilt", onbuilt)                    --监听:建造

   inst:AddComponent("hauntable")                             --可闹鬼的
    
   return inst
end

return Prefab("sjy_wsj_putongzhutai", fn, assets),
MakePlacer("sjy_wsj_putongzhutai_placer", "sjy_wsj_putongzhutai", "sjy_wsj_putongzhutai", "idle")