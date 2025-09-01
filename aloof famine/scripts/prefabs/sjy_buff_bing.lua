local assets =
{
    Asset("ANIM", "anim/lavaarena_player_revive_fx.zip"),
}



local function spikefn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("lavaarena_player_revive_fx")
    inst.AnimState:SetBuild("lavaarena_player_revive_fx")
    inst.AnimState:PlayAnimation("player_revive")

    inst:AddTag("FX")

    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end
    inst:DoTaskInTime(3.1,function()
        if inst.froze_target then
            local target = inst.froze_target
            if not target:IsValid() or target.components.health == nil
            or (target.components.health and target.components.health:IsDead()) then
                return
            end
            if target.components.freezable  then
                if target:HasTag("player") then
                    target.components.talker:Say("冻冻回魂归主！")
                    target.components.freezable:Freeze(2)
                    target.components.debuffable:AddDebuff("healthregenbuff", "healthregenbuff")
                    
                else
                    
                    -- target.components.talker:Say("冻住不洗澡！")
                    target.components.freezable:Freeze(1145140000)
                    
                end
        
            end
        end
        -- inst:Remove()
    end)

    return inst
end

return Prefab("sjy_buff_bing", spikefn, assets)