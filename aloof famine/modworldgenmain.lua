GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})
-- AddRoom("NewRoom", {
--     colour={r=.1,g=.8,b=.1,a=.50}, -- colour不用管，不重要
--     value = GLOBAL.GROUND.GRASS, -- value那个是定义地皮类型
--     contents =  { --contents是设置具体有什么东西再你设置的这个区域里
--         countprefabs = { --countprefabs适用于你想添加几个东西，按个数计算
--             touxiang = 1, --暂时测试使用，酒架  
        
--         },
--     },
-- })

-- local function AddNewRoom(task)
--     task.room_choices["NewRoom"] = 1
-- end
-- AddTaskPreInit("Squeltch", AddNewRoom)
AddRoomPreInit(
"MandrakeHome",function (room)
        if room.contents ~= nil and room.contents.distributeprefabs ~= nil then
            room.contents.distributeprefabs.caomeibush = 0.00001
            
        end
    end
)

AddRoomPreInit("BeefalowPlain",function (room)
    if room.contents ~= nil and room.contents.distributeprefabs ~= nil then
        room.contents.distributeprefabs.lanmeibush = 0.015
        room.contents.distributeprefabs.sjy_xiaomai = 0.015
        -- room.contents.distributeprefabs.caomeibush = 0.001
    end
end)

-- room.contents.countprefabs.packim_fishbone = 1



-- AddRoomPreInit(
-- "MandrakeHome",function (room)
--         if room.contents ~= nil  then
--             -- room.contents.distributeprefabs.caomeibush = 0.00001
--             room.contents.countprefabs.packim_fishbone = 1
--         end
--     end
-- )

AddRoomPreInit(
"BeeQueenBee",function (room)
        if room.contents ~= nil and room.contents.distributeprefabs ~= nil then
            room.contents.distributeprefabs.jiucai = 0.25
        end
    end
)
-- PigKingdom
AddRoomPreInit("FlowerPatch",function (room)
    if room.contents ~= nil and room.contents.distributeprefabs ~= nil then
        room.contents.distributeprefabs.sjy_huangguabush = 0.5
    end
end)

-- DeepDeciduous

-- LightningBluffOasis 绿洲
AddRoomPreInit(
"BGLightningBluff",function (room)
        if room.contents ~= nil and room.contents.distributeprefabs ~= nil then
            room.contents.distributeprefabs.banlibush = 0.25
            
        end
    end
)