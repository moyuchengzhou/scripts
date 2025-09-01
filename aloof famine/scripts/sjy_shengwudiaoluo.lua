AddPrefabPostInit(
    "butterfly",   --蝴蝶
    function(inst)
        if not TheWorld.ismastersim then
            return
        end


        if inst.components.lootdropper then

            local old_DropLoot = inst.components.lootdropper.DropLoot
            inst.components.lootdropper.DropLoot = function(self,...)
                    -- self:SpawnLootPrefab("fwd_in_pdt_food_pig_liver")    --掉落材料2

                    if math.random(100) <= 1 then  --30%概率掉落
                    self:SpawnLootPrefab("sjy_lingdie")   --掉落材料1

                    end

                return old_DropLoot(self,...)
            end
            
        end

    end)





AddPrefabPostInit(
        "moonbutterfly",   --疯猪
        function(inst)
            if not TheWorld.ismastersim then
                return
            end
    
    
            if inst.components.lootdropper then
    
                local old_DropLoot = inst.components.lootdropper.DropLoot
                inst.components.lootdropper.DropLoot = function(self,...)
                    if math.random(100) <= 1 then  --30%概率掉落
                    self:SpawnLootPrefab("sjy_lingdie")   --掉落材料1

                    end
                        -- self:SpawnLootPrefab("fwd_in_pdt_food_pig_liver")    --掉落材料2
    
                        -- if math.random(100) <= 30 then  --30%概率掉落
                        --     self:SpawnLootPrefab("fwd_in_pdt_food_large_intestine")
                        --     self:SpawnLootPrefab("fwd_in_pdt_food_pig_liver")
                        -- end
    
                    return old_DropLoot(self,...)
                end
                
            end
    
        end)

AddPrefabPostInit(
        "squid",   --疯猪
        function(inst)
            if not TheWorld.ismastersim then
                return
            end
    
    
            if inst.components.lootdropper then
    
                local old_DropLoot = inst.components.lootdropper.DropLoot
                inst.components.lootdropper.DropLoot = function(self,...)
                        self:SpawnLootPrefab("sjy_youyuxu")   --掉落材料1
                        -- self:SpawnLootPrefab("fwd_in_pdt_food_pig_liver")    --掉落材料2
    
                        if math.random(100) <= 50 then  --30%概率掉落
                            self:SpawnLootPrefab("sjy_youyuxu")
                            -- self:SpawnLootPrefab("fwd_in_pdt_food_pig_liver")
                        end
    
                    return old_DropLoot(self,...)
                end
                
            end
    
        end)



AddPrefabPostInit(
        "crabking",   --疯猪
        function(inst)
            if not TheWorld.ismastersim then
                return
            end
    
    
            if inst.components.lootdropper then
    
                local old_DropLoot = inst.components.lootdropper.DropLoot
                inst.components.lootdropper.DropLoot = function(self,...)
                        self:SpawnLootPrefab("sjy_xiehuangjiang") 
                        self:SpawnLootPrefab("sjy_xiehuangjiang")
                        self:SpawnLootPrefab("sjy_xiehuangjiang")
                        self:SpawnLootPrefab("sjy_xiehuangjiang")
                        self:SpawnLootPrefab("sjy_xiehuangjiang")
                        self:SpawnLootPrefab("sjy_xiehuangjiang")
                        self:SpawnLootPrefab("sjy_xiehuangjiang")
                        self:SpawnLootPrefab("sjy_xiehuangjiang")--掉落材料1
                        -- self:SpawnLootPrefab("fwd_in_pdt_food_pig_liver")    --掉落材料2
    
                        if math.random(100) <= 50 then  --30%概率掉落
                            self:SpawnLootPrefab("sjy_xiehuangjiang")
                            -- self:SpawnLootPrefab("fwd_in_pdt_food_pig_liver")
                        end
    
                    return old_DropLoot(self,...)
                end
                
            end
    
        end)


AddPrefabPostInit(
        "crabking_mob",  --疯猪
        function(inst)
            if not TheWorld.ismastersim then
                return
            end
    
    
            if inst.components.lootdropper then
    
                local old_DropLoot = inst.components.lootdropper.DropLoot
                inst.components.lootdropper.DropLoot = function(self,...)
                        -- self:SpawnLootPrefab("sjy_xiehuangjiang") 
                        -- self:SpawnLootPrefab("fwd_in_pdt_food_pig_liver")    --掉落材料2
    
                        if math.random(100) <= 50 then  --30%概率掉落
                            self:SpawnLootPrefab("sjy_xiehuangjiang")
                            -- self:SpawnLootPrefab("fwd_in_pdt_food_pig_liver")
                        end
    
                    return old_DropLoot(self,...)
                end
                
            end
    
        end)       
        



AddPrefabPostInit(
        "crabking_mob_knight",  --疯猪
        function(inst)
            if not TheWorld.ismastersim then
                return
            end
    
    
            if inst.components.lootdropper then
    
                local old_DropLoot = inst.components.lootdropper.DropLoot
                inst.components.lootdropper.DropLoot = function(self,...)
                        -- self:SpawnLootPrefab("sjy_xiehuangjiang") 
                        -- self:SpawnLootPrefab("fwd_in_pdt_food_pig_liver")    --掉落材料2
    
                        if math.random(100) <= 50 then  --30%概率掉落
                            self:SpawnLootPrefab("sjy_xiehuangjiang")
                            -- self:SpawnLootPrefab("fwd_in_pdt_food_pig_liver")
                        end
    
                    return old_DropLoot(self,...)
                end
                
            end
    
        end)   


AddPrefabPostInit(
        "krampus",  --疯猪
        function(inst)
            if not TheWorld.ismastersim then
                return
            end
    
    
            if inst.components.lootdropper then
    
                local old_DropLoot = inst.components.lootdropper.DropLoot
                inst.components.lootdropper.DropLoot = function(self,...)
                        -- self:SpawnLootPrefab("barnacle") 
                        -- self:SpawnLootPrefab("fwd_in_pdt_food_pig_liver")    --掉落材料2
    
                        if math.random(100) <= 10 then  --30%概率掉落
                            self:SpawnLootPrefab("krampus_sack")
                            -- self:SpawnLootPrefab("fwd_in_pdt_food_pig_liver")
                        end
    
                    return old_DropLoot(self,...)
                end
                
            end
    
        end)  



AddPrefabPostInit(
        "penguin",  --疯猪
        function(inst)
            if not TheWorld.ismastersim then
                return
            end
    
    
            if inst.components.lootdropper then
    
                local old_DropLoot = inst.components.lootdropper.DropLoot
                inst.components.lootdropper.DropLoot = function(self,...)
                        self:SpawnLootPrefab("drumstick") 
                        self:SpawnLootPrefab("smallmeat")    --掉落材料2
                        self:SpawnLootPrefab("feather_crow")
                        self:SpawnLootPrefab("bird_egg")
                        -- if math.random(100) <= 10 then  --30%概率掉落
                        --     self:SpawnLootPrefab("krampus_sack")
                        --     -- self:SpawnLootPrefab("fwd_in_pdt_food_pig_liver")
                        -- end
    
                    return old_DropLoot(self,...)
                end
                
            end
    
        end) 

AddPrefabPostInit(
        "little_walrus",  --疯猪
        function(inst)
            if not TheWorld.ismastersim then
                return
            end
    
    
            if inst.components.lootdropper then
    
                local old_DropLoot = inst.components.lootdropper.DropLoot
                inst.components.lootdropper.DropLoot = function(self,...)
                        -- self:SpawnLootPrefab("plantmeat") 
                        -- self:SpawnLootPrefab("smallmeat")    --掉落材料2
                        -- self:SpawnLootPrefab("feather_crow")
                        -- self:SpawnLootPrefab("bird_egg")
                        if math.random(100) <= 10 then  --30%概率掉落
                            self:SpawnLootPrefab("walrus_tusk")
                            -- self:SpawnLootPrefab("fwd_in_pdt_food_pig_liver")
                        end
    
                    return old_DropLoot(self,...)
                end
                
            end
    
        end) 


AddPrefabPostInit(
        "tallbird",  --疯猪
        function(inst)
            if not TheWorld.ismastersim then
                return
            end
    
    
            if inst.components.lootdropper then
    
                local old_DropLoot = inst.components.lootdropper.DropLoot
                inst.components.lootdropper.DropLoot = function(self,...)
                        self:SpawnLootPrefab("tallbirdegg") 
                        -- self:SpawnLootPrefab("smallmeat")    --掉落材料2
                        -- self:SpawnLootPrefab("feather_crow")
                        -- self:SpawnLootPrefab("bird_egg")
                        -- if math.random(100) <= 10 then  --30%概率掉落
                        --     self:SpawnLootPrefab("krampus_sack")
                        --     -- self:SpawnLootPrefab("fwd_in_pdt_food_pig_liver")
                        -- end
    
                    return old_DropLoot(self,...)
                end
                
            end
    
        end) 


        AddPrefabPostInit(
        "pigman",  --疯猪
        function(inst)
            if not TheWorld.ismastersim then
                return
            end
    
    
            if inst.components.lootdropper then
    
                local old_DropLoot = inst.components.lootdropper.DropLoot
                inst.components.lootdropper.DropLoot = function(self,...)
                        -- self:SpawnLootPrefab("sjy_zhudachang") 
                        -- self:SpawnLootPrefab("smallmeat")    --掉落材料2
                        -- self:SpawnLootPrefab("feather_crow")
                        -- self:SpawnLootPrefab("bird_egg")
                        if math.random(100) <= 50 then  --30%概率掉落
                            self:SpawnLootPrefab("sjy_zhudachang")
                            -- self:SpawnLootPrefab("fwd_in_pdt_food_pig_liver")
                        end
    
                    return old_DropLoot(self,...)
                end
                
            end
    
        end) 



