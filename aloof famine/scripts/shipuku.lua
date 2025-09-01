GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})

-- 定义食谱汉堡包
GLOBAL.STRINGS.NAMES["HANBAOBAO"]="致命汉堡包"
local hanbaobao = {
    test = function(cooker, names, tags)
        -- 番茄 肉 草莓/熟草莓 噩梦燃料
        return (names.tomato or names.tomato_cooked) and names.meat and (names.caomeibean or names.caomeibean_cooked) and names.nightmarefuel
    end,
    name = "hanbaobao", -- 料理名
    weight = 1, -- 食谱权重
    priority = 1, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.MEAT, --料理的食物类型，比如这里定义的是肉类
    health = -75, --吃后回血值
    hunger = 150, --吃后回饥饿值
    sanity = 150, --吃后回精神值
    perishtime = 400, --腐烂时间
    cooktime = 15, --烹饪时间
    potlevel = "high",
    cookbook_tex = "hanbaobao.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/hanbaobao.xml",
    -- temperature = TUNING.HOT_FOOD_BONUS_TEMP, --某些食物吃了之后有温度变化，则是在这地方定义的
    -- temperatureduration = TUNING.FOOD_TEMP_BRIEF,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",hanbaobao) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",hanbaobao) -- 将食谱添加进便携锅



-- --定义食谱彩虹糖
-- GLOBAL.STRINGS.NAMES["CAIHONGTANG"]="彩虹糖"
-- local caihongtang = {
--     test = function(cooker, names, tags)
--         -- 草莓/熟草莓 蓝莓/熟蓝莓 西瓜 蜂蜜
--         return (names.lanmeibean or names.lanmeibean_cooked) and (names.caomeibean or names.caomeibean_cooked) and names.watermelon and names.honey
--     end,
--     name = "caihongtang", -- 料理名
--     weight = 1, -- 食谱权重
--     priority = 1, -- 食谱优先级
--     foodtype = GLOBAL.FOODTYPE.VEGGIE, --料理的食物类型，比如这里定义的是肉类
--     health = 300, --吃后回血值
--     hunger = 300, --吃后回饥饿值
--     sanity = 300, --吃后回精神值
--     perishtime = 400, --腐烂时间
--     cooktime = 24, --烹饪时间
--     potlevel = "high",
--     cookbook_tex = "caihongtang.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
--     cookbook_atlas = "images/caihongtang.xml",
--     -- temperature = TUNING.HOT_FOOD_BONUS_TEMP, --某些食物吃了之后有温度变化，则是在这地方定义的
--     -- temperatureduration = TUNING.FOOD_TEMP_BRIEF,
    
--     -- AddPlayerPostInit(function(inst)
--     --     if not TheWorld.ismastersim then
--     --         return inst
--     --     end
    
--     --     if not inst.components.timer then
--     --         inst:AddComponent("timer")
--     --     end
--     --     inst:DoTaskInTime(0, function(inst)
--     --         if inst.components.timer:TimerExists("dragoonheartattack_timer") then
--     --             if inst.components.combat ~= nil then
--     --                 inst.components.combat.externaldamagemultipliers:SetModifier("dragoonheartattack", 10)
--     --             end
--     --         end
--     --     end)
--     --     inst:ListenForEvent("timerdone", function(inst, data)
--     --         if data.name == "dragoonheartattack_timer" then
--     --             if inst.components.combat ~= nil then
--     --                 inst.components.combat.externaldamagemultipliers:RemoveModifier("dragoonheartattack")
--     --             end
--     --         end
--     --     end)
--     -- end),
--     floater = {"med", nil, 0.55},
--     cookbook_category = "cookpot"
-- }

-- AddCookerRecipe("cookpot",caihongtang) -- 将食谱添加进普通锅
-- AddCookerRecipe("portablecookpot",caihongtang) -- 将食谱添加进便携锅


-- 定义食谱红伞伞炒饭
GLOBAL.STRINGS.NAMES["HSSCF"]="红伞伞炒饭"
local hsscf = {
    test = function(cooker, names, tags)
        -- 红蘑菇 熟红蘑菇 荧光果 荧光果
        return names.red_cap == 2 and names.lightbulb and names.sjy_baimifan 
    end,
    name = "hsscf", -- 料理名
    weight = 1, -- 食谱权重
    priority = 50, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.VEGGIE, --料理的食物类型，比如这里定义的是肉类
    health = -125, --吃后回血值
    hunger = 90, --吃后回饥饿值
    sanity = 15, --吃后回精神值
    perishtime = 400, --腐烂时间
    cooktime = 1.5, --烹饪时间
    potlevel = "high",
    cookbook_tex = "hsscf.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/hsscf.xml",
    -- temperature = TUNING.HOT_FOOD_BONUS_TEMP, --某些食物吃了之后有温度变化，则是在这地方定义的
    -- temperatureduration = TUNING.FOOD_TEMP_BRIEF,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",hsscf) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",hsscf) -- 将食谱添加进便携锅


-- 定义食谱压缩饼干
GLOBAL.STRINGS.NAMES["YSBG"]="压缩饼干"
local ysbg = {
    test = function(cooker, names, tags)
        -- 黄油 蜂蜜 花瓣 树枝
        return names.honey and names.butter and names.petals and names.twigs
    end,
    name = "ysbg", -- 料理名
    weight = 1, -- 食谱权重
    priority = 50, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.VEGGIE, --料理的食物类型，比如这里定义的是肉类
    health = 20, --吃后回血值
    hunger = 75, --吃后回饥饿值
    sanity = 5, --吃后回精神值
    perishtime = 400, --腐烂时间
    cooktime = 0.5, --烹饪时间
    potlevel = "high",
    cookbook_tex = "ysbg.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/ysbg.xml",
    temperature = 60, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 10,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",ysbg) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",ysbg) -- 将食谱添加进便携锅


-- 定义食谱糖果篮
GLOBAL.STRINGS.NAMES["TGL"]="糖果篮"
local tgl = {
    test = function(cooker, names, tags)
        -- 蜂蜜 浆果 花瓣 荧光果
        return names.honey and names.berries and names.lightbulb and names.petals
    end,
    name = "tgl", -- 料理名
    weight = 1, -- 食谱权重
    priority = 50, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.VEGGIE, --料理的食物类型，比如这里定义的是肉类
    health = 20, --吃后回血值
    hunger = 75, --吃后回饥饿值
    sanity = 5, --吃后回精神值
    perishtime = 400, --腐烂时间
    cooktime = 0.5, --烹饪时间
    potlevel = "high",
    cookbook_tex = "tgl.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/tgl.xml",
    temperature = 60, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 10,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",tgl) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",tgl) -- 将食谱添加进便携锅

-- 定义食谱热狗
GLOBAL.STRINGS.NAMES["RG"]="热狗"
local rg = {
    test = function(cooker, names, tags)
        -- 大肉/熟大肉 小肉/熟小肉 海带 土豆/烤土豆
        return (names.meat or names.cookedmeat) and (names.smallmeat or names.cookedsmallmeat) and names.kelp and (names.potato or names.potato_cooked)
    end,
    name = "rg", -- 料理名
    weight = 1, -- 食谱权重
    priority = 50, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.VEGGIE, --料理的食物类型，比如这里定义的是肉类
    health = 150, --吃后回血值
    hunger = 66, --吃后回饥饿值
    sanity = 20, --吃后回精神值
    perishtime = 400, --腐烂时间
    cooktime = 0.5, --烹饪时间
    potlevel = "high",
    cookbook_tex = "rg.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/rg.xml",
    temperature = 60, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 10,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",rg) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",rg) -- 将食谱添加进便携锅

-- 定义食谱火锅
GLOBAL.STRINGS.NAMES["HG"]="火锅"
local hg = {
    test = function(cooker, names, tags)
        -- 火腿棒 生鱼肉/熟鱼肉/小鱼肉/熟小鱼肉 肉/烤肉 海带
        return names.hambat and (names.fishmeat or names.fishmeat_cooked or names.fishmeat_small or names.fishmeat_small_cooked) and (names.meat or names.cookedmeat) and names.kelp
    end,
    name = "hg", -- 料理名
    weight = 1, -- 食谱权重
    priority = 50, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.VEGGIE, --料理的食物类型，比如这里定义的是肉类
    health = 75, --吃后回血值
    hunger = 250, --吃后回饥饿值
    sanity = 100, --吃后回精神值
    perishtime = 400, --腐烂时间
    cooktime = 0.5, --烹饪时间
    potlevel = "high",
    cookbook_tex = "hg.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/hg.xml",
    temperature = 80, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",hg) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",hg) -- 将食谱添加进便携锅

-- 定义食谱火锅
GLOBAL.STRINGS.NAMES["CDF"]="臭豆腐"
local cdf = {
    test = function(cooker, names, tags)
        -- 鸟蛋/煎蛋 辣椒 腐烂物 种子
        return (names.bird_egg or names.bird_egg_cooked )and names.pepper and names.sjy_choudoufu and names.seeds
    end,
    name = "cdf", -- 料理名
    weight = 1, -- 食谱权重
    priority = 50, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.VEGGIE, --料理的食物类型，比如这里定义的是肉类
    health = 10, --吃后回血值
    hunger = 150, --吃后回饥饿值
    sanity = 20, --吃后回精神值
    perishtime = 400, --腐烂时间
    cooktime = 0.5, --烹饪时间
    potlevel = "high",
    cookbook_tex = "cdf.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/cdf.xml",
    temperature = 80, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",cdf) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",cdf) -- 将食谱添加进便携锅


-- 定义食谱石头汤
GLOBAL.STRINGS.NAMES["STT"]="石头汤"
local stt = {
    test = function(cooker, names, tags)
        return names.marblebean and names.rocks and names.flint and names.marble
    end,
    name = "stt", -- 料理名
    weight = 1, -- 食谱权重
    priority = 50, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.VEGGIE, --料理的食物类型，比如这里定义的是肉类
    health = -4, --吃后回血值
    hunger = 150, --吃后回饥饿值
    sanity = -40, --吃后回精神值
    perishtime = 400, --腐烂时间
    cooktime = 0.5, --烹饪时间
    potlevel = "high",
    cookbook_tex = "stt.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/stt.xml",
    temperature = 80, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",stt) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",stt) -- 将食谱添加进便携锅


-- 定义食谱石头汤
GLOBAL.STRINGS.NAMES["KC"]="烤串"
local kc = {
    test = function(cooker, names, tags)
        -- 树枝 小肉/熟小肉 辣椒 浆果
        return names.twigs and (names.smallmeat or names.cookedsmallmeat )and names.pepper and names.berries
    end,
    name = "kc", -- 料理名
    weight = 1, -- 食谱权重
    priority = 50, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.VEGGIE, --料理的食物类型，比如这里定义的是肉类
    health = 10, --吃后回血值
    hunger = 40, --吃后回饥饿值
    sanity = 10, --吃后回精神值
    perishtime = 400, --腐烂时间
    cooktime = 0.2, --烹饪时间
    potlevel = "high",
    cookbook_tex = "kc.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/kc.xml",
    temperature = 80, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",kc) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",kc) -- 将食谱添加进便携锅



-- 定义食谱石头汤
GLOBAL.STRINGS.NAMES["NAINAO"]="奶酪"
local nainao = {
    test = function(cooker, names, tags)
        return names.bird_egg and names.butter and (names.goatmilk or names.sjy_shouchongyangnai) and names.ice
    end,
    name = "nainao", -- 料理名
    weight = 1, -- 食谱权重
    priority = 50, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 20, --吃后回血值
    hunger = 40, --吃后回饥饿值
    sanity = 60, --吃后回精神值
    perishtime = 400, --腐烂时间
    cooktime = 0.2, --烹饪时间
    potlevel = "high",
    cookbook_tex = "nainao.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/nainao.xml",
    temperature = 80, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",nainao) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",nainao) -- 将食谱添加进便携锅




GLOBAL.STRINGS.NAMES["TILAMISU"]="提拉米苏"
local tilamisu = {
    test = function(cooker, names, tags)
        return names.bird_egg == 2 and names.butter and names.butterflywings 
    end,
    name = "tilamisu", -- 料理名
    weight = 1, -- 食谱权重
    priority = 50, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 60, --吃后回血值
    hunger = 120, --吃后回饥饿值
    sanity = 60, --吃后回精神值
    perishtime = 400, --腐烂时间
    cooktime = 1.5, --烹饪时间
    potlevel = "high",
    cookbook_tex = "tilamisu.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/tilamisu.xml",
    temperature = 80, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",tilamisu) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",tilamisu) -- 将食谱添加进便携锅



GLOBAL.STRINGS.NAMES["BANGBANGTANG"]="棒棒糖"
local bangbangtang = {
    test = function(cooker, names, tags)
        return names.honey and names.twigs and names.pomegranate and names.watermelon
    end,
    name = "bangbangtang", -- 料理名
    weight = 1, -- 食谱权重
    priority = 50, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 25, --吃后回血值
    hunger = 33.3, --吃后回饥饿值
    sanity = 30, --吃后回精神值
    perishtime = 400, --腐烂时间
    cooktime = 1.5, --烹饪时间
    potlevel = "high",
    cookbook_tex = "bangbangtang.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/bangbangtang.xml",
    temperature = 80, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",bangbangtang) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",bangbangtang) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["DHYB"]="蛋黄月饼"
local dhyb = {
    test = function(cooker, names, tags)
        return names.butter and names.bird_egg and names.boards and names.butterflywings
    end,
    name = "dhyb", -- 料理名
    weight = 1, -- 食谱权重
    priority = 50, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 20, --吃后回血值
    hunger = 75, --吃后回饥饿值
    sanity = 15, --吃后回精神值
    perishtime = 400, --腐烂时间
    cooktime = 0.2, --烹饪时间
    potlevel = "high",
    cookbook_tex = "dhyb.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/dhyb.xml",
    temperature = 80, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",dhyb) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",dhyb) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["YJSP"]="应急食品·派蒙"
local yjsp = {
    test = function(cooker, names, tags)
        return names.butter and names.bird_egg and names.drumstick == 2
    end,
    name = "yjsp", -- 料理名
    weight = 1, -- 食谱权重
    priority = 50, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 20, --吃后回血值
    hunger = 75, --吃后回饥饿值
    sanity = 15, --吃后回精神值
    perishtime = 400, --腐烂时间
    cooktime = 6, --烹饪时间
    potlevel = "high",
    cookbook_tex = "yjsp.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/yjsp.xml",
    temperature = 80, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",yjsp) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",yjsp) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["CZSCDR"]="稠汁蔬菜炖肉"
local czscdr = {
    test = function(cooker, names, tags)
        return names.meat and names.carrot and names.tomato and names.ice
    end,
    name = "czscdr", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 20, --吃后回血值
    hunger = 65, --吃后回饥饿值
    sanity = 15, --吃后回精神值
    perishtime = 400, --腐烂时间
    cooktime = 1.5, --烹饪时间
    potlevel = "high",
    cookbook_tex = "czscdr.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/czscdr.xml",
    temperature = 80000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",czscdr) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",czscdr) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["LZQDG"]="莲子禽蛋羹"
local lzqdg = {
    test = function(cooker, names, tags)
        return names.seeds and names.bird_egg and names.tallbirdegg and names.ice
    end,
    name = "lzqdg", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 60, --吃后回血值
    hunger = 65, --吃后回饥饿值
    sanity = 0, --吃后回精神值
    perishtime = 400, --腐烂时间
    cooktime = 1.5, --烹饪时间
    potlevel = "high",
    cookbook_tex = "lzqdg.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/lzqdg.xml",
    temperature = -80000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",lzqdg) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",lzqdg) -- 将食谱添加进便携锅



GLOBAL.STRINGS.NAMES["LWSSHR"]="辣味时蔬烩肉"
local lwsshr = {
    test = function(cooker, names, tags)
        return names.pepper and names.meat and names.honey and names.carrot
    end,
    name = "lwsshr", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 20, --吃后回血值
    hunger = 75, --吃后回饥饿值
    sanity = 15, --吃后回精神值
    perishtime = 400, --腐烂时间
    cooktime = 1.5, --烹饪时间
    potlevel = "high",
    cookbook_tex = "lwsshr.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/lwsshr.xml",
    temperature = 80000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",lwsshr) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",lwsshr) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["JSXQ"]="金丝虾球"
local jsxq = {
    test = function(cooker, names, tags)
        return names.wobster_sheller_land and names.potato and names.bird_egg and names.butter
    end,
    name = "jsxq", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 0, --吃后回血值
    hunger = 80, --吃后回饥饿值
    sanity = 33, --吃后回精神值
    perishtime = 400, --腐烂时间
    cooktime = 1.5, --烹饪时间
    potlevel = "high",
    cookbook_tex = "jsxq.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/jsxq.xml",
    temperature = 80000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}
 
AddCookerRecipe("cookpot",jsxq) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",jsxq) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["XJYY"]="夏祭游鱼"
local xjyy = {
    test = function(cooker, names, tags)
        return names.fishmeat == 2 and names.fishmeat_small==2 
    end,
    name = "xjyy", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 66.6, --吃后回血值
    hunger = 99.9, --吃后回饥饿值
    sanity = 33.3, --吃后回精神值
    perishtime = 400, --腐烂时间
    cooktime = 1.5, --烹饪时间
    potlevel = "high",
    cookbook_tex = "xjyy.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/xjyy.xml",
    temperature = 2*TUNING.HOT_FOOD_BONUS_TEMP, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 10*TUNING.BUFF_FOOD_TEMP_DURATION,
    nochill = true,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",xjyy) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",xjyy) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["DBFYWQ"]="蛋包饭圆舞曲"
local dbfywq = {
    test = function(cooker, names, tags)
        return names.bird_egg and names.tomato and names.sjy_baimifan and names.honey
    end,
    name = "dbfywq", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 30, --吃后回血值
    hunger = 75, --吃后回饥饿值
    sanity = 33.3, --吃后回精神值
    perishtime = 400, --腐烂时间
    cooktime = 1.5, --烹饪时间
    potlevel = "high",
    cookbook_tex = "dbfywq.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/dbfywq.xml",
    temperature = 800000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",dbfywq) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",dbfywq) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SRBHJ"]="怪物海带卷"
local srbhj = {
    test = function(cooker, names, tags)
        return names.bird_egg and names.monstermeat and names.pepper and names.kelp
    end,
    name = "srbhj", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 35, --吃后回血值
    hunger = 66, --吃后回饥饿值
    sanity = 0, --吃后回精神值
    perishtime = 400, --腐烂时间
    cooktime = 1.5, --烹饪时间
    potlevel = "high",
    cookbook_tex = "srbhj.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/srbhj.xml",
    temperature = 800000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",srbhj) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",srbhj) -- 将食谱添加进便携锅



GLOBAL.STRINGS.NAMES["MJHLBJR"]="蜜浆胡萝卜煎肉"
local mjhlbjr = {
    test = function(cooker, names, tags)
        return names.carrot and names.meat and names.honey and names.ice
    end,
    name = "mjhlbjr", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 20, --吃后回血值
    hunger = 37.5, --吃后回饥饿值
    sanity = 5, --吃后回精神值
    perishtime = 600, --腐烂时间
    cooktime = 1.5, --烹饪时间
    potlevel = "high",
    cookbook_tex = "mjhlbjr.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/mjhlbjr.xml",
    temperature = 800000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",mjhlbjr) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",mjhlbjr) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["XXYBM"]="鲜虾鱼板面"
local xxybm = {
    test = function(cooker, names, tags)
        return names.fishmeat and names.wobster_sheller_land and names.onion and names.carrot
    end,
    name = "xxybm", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 10, --吃后回血值
    hunger = 75, --吃后回饥饿值
    sanity = 20, --吃后回精神值
    perishtime = 600, --腐烂时间
    cooktime = 1.5, --烹饪时间
    potlevel = "high",
    cookbook_tex = "xxybm.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/xxybm.xml",
    temperature = 800000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",xxybm) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",xxybm) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["FYSJD"]="翡玉什锦袋"
local fysjd = {
    test = function(cooker, names, tags)
        return names.meat and names.potato and names.kelp and names.rock_avocado_fruit_ripe
    end,
    name = "fysjd", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 20, --吃后回血值
    hunger = 66, --吃后回饥饿值
    sanity = 5, --吃后回精神值
    perishtime = 600, --腐烂时间
    cooktime = 1.5, --烹饪时间
    potlevel = "high",
    cookbook_tex = "fysjd.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/fysjd.xml",
    temperature = 800000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",fysjd) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",fysjd) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["YYFQHXZH"]="鱿鱼番茄海鲜浓汤"
local yyfqhxzh = {
    test = function(cooker, names, tags)
        return (names.sjy_youyuxu or names.sjy_youyuxu_cooked) and names.carrot and names.wobster_sheller_dead_cooked and names.tomato
    end,
    name = "yyfqhxzh", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 0, --吃后回血值
    hunger = 75, --吃后回饥饿值
    sanity = 20, --吃后回精神值
    perishtime = 600, --腐烂时间
    cooktime = 1.5, --烹饪时间
    potlevel = "high",
    cookbook_tex = "yyfqhxzh.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/yyfqhxzh.xml",
    temperature = 800000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",yyfqhxzh) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",yyfqhxzh) -- 将食谱添加进便携锅



GLOBAL.STRINGS.NAMES["LWWWT"]="辣味窝窝头"
local lwwwt = {
    test = function(cooker, names, tags)
        return names.meat and names.sjy_miantuan and names.green_cap and names.pepper
    end,
    name = "lwwwt", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = -50, --吃后回血值
    hunger = 60, --吃后回饥饿值
    sanity = 5, --吃后回精神值
    perishtime = 600, --腐烂时间
    cooktime = 1.5, --烹饪时间
    potlevel = "high",
    cookbook_tex = "lwwwt.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/lwwwt.xml",
    temperature = 800000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",lwwwt) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",lwwwt) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["MGKR"]="蘑菇扣肉"
local mgkr = {
    test = function(cooker, names, tags)
        return names.meat and names.blue_cap and names.honey and names.butter
    end,
    name = "mgkr", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 0, --吃后回血值
    hunger = 200, --吃后回饥饿值
    sanity = 5, --吃后回精神值
    perishtime = 600, --腐烂时间
    cooktime = 1.5, --烹饪时间
    potlevel = "high",
    cookbook_tex = "mgkr.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/mgkr.xml",
    temperature = 800000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",mgkr) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",mgkr) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJX"]="水晶虾"
local sjx = {
    test = function(cooker, names, tags)
        return names.wobster_sheller_land and names.carrot and names.ice and names.red_cap
    end,
    name = "sjx", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 60, --吃后回血值
    hunger = 45, --吃后回饥饿值
    sanity = 10, --吃后回精神值
    perishtime = 600, --腐烂时间
    cooktime = 1.5, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjx.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjx.xml",
    temperature = -800000*100, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjx) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjx) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["HLMF"]="活力猫饭"
local hlmf = {
    test = function(cooker, names, tags)
        return names.fishmeat and names.fishmeat_small and names.sjy_baimifan and names.meat
    end,
    name = "hlmf", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 40, --吃后回血值
    hunger = 75, --吃后回饥饿值
    sanity = 5, --吃后回精神值
    perishtime = 600, --腐烂时间
    cooktime = 1.5, --烹饪时间
    potlevel = "high",
    cookbook_tex = "hlmf.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/hlmf.xml",
    temperature = 800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",hlmf) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",hlmf) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["XNTDN"]="香浓土豆泥"
local xntdn = {
    test = function(cooker, names, tags)
        return names.potato and names.butter and names.honey and names.bird_egg
    end,
    name = "xntdn", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 40, --吃后回血值
    hunger = 37.5, --吃后回饥饿值
    sanity = 1.5, --吃后回精神值
    perishtime = 600, --腐烂时间
    cooktime = 1.5, --烹饪时间
    potlevel = "high",
    cookbook_tex = "xntdn.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/xntdn.xml",
    temperature = 800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",xntdn) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",xntdn) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["QRJHT"]="清热解暑汤"
local qrjht = {
    test = function(cooker, names, tags)
        return names.fig and names.ice and names.honey and names.berries
    end,
    name = "qrjht", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 75, --吃后回血值
    hunger = 37.5, --吃后回饥饿值
    sanity = 1.5, --吃后回精神值
    perishtime = 6000, --腐烂时间
    cooktime = 1.5, --烹饪时间
    potlevel = "high",
    cookbook_tex = "qrjht.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/qrjht.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",qrjht) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",qrjht) -- 将食谱添加进便携锅



GLOBAL.STRINGS.NAMES["CBFT"]="脆饼法提"
local cbft = {
    test = function(cooker, names, tags)
        return names.pumpkin and names.corn_cooked and names.honey and names.berries
    end,
    name = "cbft", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 0, --吃后回血值
    hunger = 75, --吃后回饥饿值
    sanity = 20, --吃后回精神值
    perishtime = 6000, --腐烂时间
    cooktime = 1.5, --烹饪时间
    potlevel = "high",
    cookbook_tex = "cbft.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/cbft.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",cbft) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",cbft) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["MYD"]="明月蛋"
local myd = {
    test = function(cooker, names, tags)
        return names.potato and names.wobster_sheller_land and names.bird_egg and names.fishmeat
    end,
    name = "myd", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 30, --吃后回血值
    hunger = 37.5, --吃后回饥饿值
    sanity = 0.25, --吃后回精神值
    perishtime = 6000, --腐烂时间
    cooktime = 1.5, --烹饪时间
    potlevel = "high",
    cookbook_tex = "myd.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/myd.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",myd) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",myd) -- 将食谱添加进便携锅



GLOBAL.STRINGS.NAMES["ZYST"]="炸鱼薯条"
local zyst = {
    test = function(cooker, names, tags)
        return names.potato and names.butter and names.tomato and names.fishmeat
    end,
    name = "zyst", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 60, --吃后回血值
    hunger = 37.5, --吃后回饥饿值
    sanity = 0.25, --吃后回精神值
    perishtime = 6000, --腐烂时间
    cooktime = 1.5, --烹饪时间
    potlevel = "high",
    cookbook_tex = "zyst.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/zyst.xml",
    temperature = 800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",zyst) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",zyst) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["YFYT"]="油封鸭腿"
local yfyt = {
    test = function(cooker, names, tags)
        return names.potato and names.drumstick and names.butter and names.honey
    end,
    name = "yfyt", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 20, --吃后回血值
    hunger = 75, --吃后回饥饿值
    sanity = 5, --吃后回精神值
    perishtime = 6000, --腐烂时间
    cooktime = 1.5, --烹饪时间
    potlevel = "high",
    cookbook_tex = "yfyt.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/yfyt.xml",
    temperature = 800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",yfyt) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",yfyt) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["BWWNJ"]="必忘我酿鸡"
local bwwnj = {
    test = function(cooker, names, tags)
        return names.forgetmelots and names.drumstick and names.batwing_cooked and names.honey
    end,
    name = "bwwnj", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 40, --吃后回血值
    hunger = 75, --吃后回饥饿值
    sanity = 15, --吃后回精神值
    perishtime = 6000, --腐烂时间
    cooktime = 1.5, --烹饪时间
    potlevel = "high",
    cookbook_tex = "bwwnj.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/bwwnj.xml",
    temperature = 800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",bwwnj) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",bwwnj) -- 将食谱添加进便携锅



GLOBAL.STRINGS.NAMES["NXJGCT"]="奶香菌菇脆塔"
local nxjgct = {
    test = function(cooker, names, tags)
        return names.honey and names.butter and names.moon_cap and (names.goatmilk or names.sjy_shouchongyangnai)
    end,
    name = "nxjgct", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 40, --吃后回血值
    hunger = 66, --吃后回饥饿值
    sanity = -33, --吃后回精神值
    perishtime = 6000, --腐烂时间
    cooktime = 1.5, --烹饪时间
    potlevel = "high",
    cookbook_tex = "nxjgct.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/nxjgct.xml",
    temperature = 800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",nxjgct) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",nxjgct) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["CCJTB"]="脆脆鸡腿堡"
local ccjtb = {
    test = function(cooker, names, tags)
        return names.kelp and names.tomato and names.meat and names.butter
    end,
    name = "ccjtb", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 30, --吃后回血值
    hunger = 37.5, --吃后回饥饿值
    sanity = 33, --吃后回精神值
    perishtime = 6000, --腐烂时间
    cooktime = 1.5, --烹饪时间
    potlevel = "high",
    cookbook_tex = "ccjtb.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/ccjtb.xml",
    temperature = 800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",ccjtb) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",ccjtb) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SSY"]="松鼠鱼"
local ssy = {
    test = function(cooker, names, tags)
        return names.ice and names.tomato and names.fishmeat and names.honey
    end,
    name = "ssy", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 20, --吃后回血值
    hunger = 75, --吃后回饥饿值
    sanity = 5, --吃后回精神值
    perishtime = 6000, --腐烂时间
    cooktime = 1.5, --烹饪时间
    potlevel = "high",
    cookbook_tex = "ssy.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/ssy.xml",
    temperature = 800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",ssy) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",ssy) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SZY"]="水煮鱼"
local szy = {
    test = function(cooker, names, tags)
        return names.pepper and names.kelp and names.fishmeat and names.potato
    end,
    name = "szy", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 40, --吃后回血值
    hunger = 57.5, --吃后回饥饿值
    sanity = -20, --吃后回精神值
    perishtime = 6000, --腐烂时间
    cooktime = 1.5, --烹饪时间
    potlevel = "high",
    cookbook_tex = "szy.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/szy.xml",
    temperature = 800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",szy) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",szy) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["TDC"]="土豆船"
local tdc = {
    test = function(cooker, names, tags)
        return names.potato and names.butter and names.forgetmelots and names.blue_cap
    end,
    name = "tdc", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 60, --吃后回血值
    hunger = 37.5, --吃后回饥饿值
    sanity = -20, --吃后回精神值
    perishtime = 6000, --腐烂时间
    cooktime = 1.5, --烹饪时间
    potlevel = "high",
    cookbook_tex = "tdc.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/tdc.xml",
    temperature = 800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",tdc) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",tdc) -- 将食谱添加进便携锅



GLOBAL.STRINGS.NAMES["LZCQ"]="绿茶脆球"
local lzcq = {
    test = function(cooker, names, tags)
        return names.potato and names.butter and names.forgetmelots and names.wobster_sheller_land
    end,
    name = "lzcq", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 80, --吃后回血值
    hunger = 60, --吃后回饥饿值
    sanity = 20, --吃后回精神值
    perishtime = 6000, --腐烂时间
    cooktime = 1.5, --烹饪时间
    potlevel = "high",
    cookbook_tex = "lzcq.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/lzcq.xml",
    temperature = 800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",lzcq) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",lzcq) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["TSSZH"]="塔塞斯杂烩"
local tsszh = {
    test = function(cooker, names, tags)
        return names.potato and names.tomato and names.carrot and names.onion
    end,
    name = "tsszh", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 45, --吃后回血值
    hunger = 59.3, --吃后回饥饿值
    sanity = 5, --吃后回精神值
    perishtime = 6000, --腐烂时间
    cooktime = 1.5, --烹饪时间
    potlevel = "high",
    cookbook_tex = "tsszh.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/tsszh.xml",
    temperature = 800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",tsszh) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",tsszh) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["MJGP"]="下午茶"
local mjgp = {
    test = function(cooker, names, tags)
        return names.forgetmelots and names.honey and names.potato and names.ice
    end,
    name = "mjgp", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 20, --吃后回血值
    hunger = 35.7, --吃后回饥饿值
    sanity = 30, --吃后回精神值
    perishtime = 6000, --腐烂时间
    cooktime = 1.5, --烹饪时间
    potlevel = "high",
    cookbook_tex = "mjgp.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/mjgp.xml",
    temperature = 800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",mjgp) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",mjgp) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["GGXL"]="晴空万里"
local ggxl = {
    test = function(cooker, names, tags)
        return names.forgetmelots and names.royal_jelly and names.wormlight_lesser and names.ice
    end,
    name = "ggxl", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 120, --吃后回血值
    hunger = 25, --吃后回饥饿值
    sanity = 5, --吃后回精神值
    perishtime = 6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "ggxl.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/ggxl.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",ggxl) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",ggxl) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["ZYYN"]="紫苑云霓"
local zyyn = {
    test = function(cooker, names, tags)
        return names.forgetmelots and names.fig and (names.goatmilk or names.sjy_shouchongyangnai) and names.ice
    end,
    name = "zyyn", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 20, --吃后回血值
    hunger = 25, --吃后回饥饿值
    sanity = 50, --吃后回精神值
    perishtime = 6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "zyyn.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/zyyn.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",zyyn) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",zyyn) -- 将食谱添加进便携锅



GLOBAL.STRINGS.NAMES["TSZW"]="天使之吻"
local tszw = {
    test = function(cooker, names, tags)
        return names.forgetmelots and names.berries and names.honey and names.ice
    end,
    name = "tszw", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 3, --吃后回血值
    hunger = 25, --吃后回饥饿值
    sanity = 33, --吃后回精神值
    perishtime = 6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "tszw.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/tszw.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",tszw) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",tszw) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["QCZG"]="清晨之光"
local qczg = {
    test = function(cooker, names, tags)
        return names.forgetmelots and names.lightbulb and names.honey and names.ice
    end,
    name = "qczg", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 10, --吃后回血值
    hunger = 25, --吃后回饥饿值
    sanity = 10, --吃后回精神值
    perishtime = 6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "qczg.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/qczg.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",qczg) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",qczg) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["FMXCZ"]="蜂蜜鲜橙汁"
local fmxcz = {
    test = function(cooker, names, tags)
        return names.forgetmelots and names.acorn and names.honey and names.ice
    end,
    name = "fmxcz", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 5, --吃后回血值
    hunger = 25, --吃后回饥饿值
    sanity = 0, --吃后回精神值
    perishtime = 6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "fmxcz.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/fmxcz.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",fmxcz) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",fmxcz) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SGQL"]="双果清露"
local sgql = {
    test = function(cooker, names, tags)
        return names.forgetmelots and names.berries and names.fig and names.ice
    end,
    name = "sgql", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 15, --吃后回血值
    hunger = 35, --吃后回饥饿值
    sanity = 10, --吃后回精神值
    perishtime = 6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sgql.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sgql.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sgql) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sgql) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["ZQDL"]="紫汽东来"
local zqdl = {
    test = function(cooker, names, tags)
        return names.forgetmelots and names.berries and names.wormlight_lesser and names.ice
    end,
    name = "zqdl", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 12, --吃后回血值
    hunger = 25, --吃后回饥饿值
    sanity = 5, --吃后回精神值
    perishtime = 6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "zqdl.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/zqdl.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",zqdl) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",zqdl) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["BZYNZG"]="杯中遥吟之歌"
local bzynzg = {
    test = function(cooker, names, tags)
        return names.forgetmelots and names.berries and names.wormlight and names.ice
    end,
    name = "bzynzg", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 20, --吃后回血值
    hunger = 25, --吃后回饥饿值
    sanity = 20, --吃后回精神值
    perishtime = 6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "bzynzg.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/bzynzg.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",bzynzg) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",bzynzg) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["LBZSN"]="榴不住思念"
local lbzsn = {
    test = function(cooker, names, tags)
        return names.forgetmelots and names.pomegranate and names.honey and names.ice
    end,
    name = "lbzsn", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 23.3, --吃后回血值
    hunger = 13.14, --吃后回饥饿值
    sanity = 5.20, --吃后回精神值
    perishtime = 6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "lbzsn.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/lbzsn.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",lbzsn) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",lbzsn) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["JGBD"]="浆果慕斯"
local jgbd = {
    test = function(cooker, names, tags)
        return names.butter and names.berries and names.honey and names.ice
    end,
    name = "jgbd", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 30, --吃后回血值
    hunger = 45, --吃后回饥饿值
    sanity = 15, --吃后回精神值
    perishtime = 6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "jgbd.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/jgbd.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",jgbd) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",jgbd) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["YWZM"]="遗忘之梦"
local ywzm = {
    test = function(cooker, names, tags)
        return names.butter and names.berries and names.honey and names.forgetmelots
    end,
    name = "ywzm", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 30, --吃后回血值
    hunger = 45, --吃后回饥饿值
    sanity = 15, --吃后回精神值
    perishtime = 6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "ywzm.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/ywzm.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",ywzm) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",ywzm) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["WHXC"]="午后闲茶"
local whxc = {
    test = function(cooker, names, tags)
        return names.butter and names.potato and names.honey and names.ice
    end,
    name = "whxc", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 20, --吃后回血值
    hunger = 45, --吃后回饥饿值
    sanity = 15, --吃后回精神值
    perishtime = 6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "whxc.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/whxc.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",whxc) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",whxc) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["WYSF"]="午夜时分"
local wysf = {
    test = function(cooker, names, tags)
        return names.forgetmelots and names.wormlight_lesser and names.lightbulb and names.ice
    end,
    name = "wysf", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 20, --吃后回血值
    hunger = 25, --吃后回饥饿值
    sanity = 0, --吃后回精神值
    perishtime = 6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "wysf.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/wysf.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",wysf) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",wysf) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["FHSJ"]="绯红世界"
local fhsj = {
    test = function(cooker, names, tags)
        return names.forgetmelots and names.watermelon and names.berries and names.ice
    end,
    name = "fhsj", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 15, --吃后回血值
    hunger = 25, --吃后回饥饿值
    sanity = 15, --吃后回精神值
    perishtime = 6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "fhsj.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/fhsj.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",fhsj) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",fhsj) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["XJNF"]="香蕉奶芙"
local xjnf = {
    test = function(cooker, names, tags)
        return names.forgetmelots and names.cave_banana and names.butter and names.ice
    end,
    name = "xjnf", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 30, --吃后回血值
    hunger = 25, --吃后回饥饿值
    sanity = 33, --吃后回精神值
    perishtime = 6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "xjnf.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/xjnf.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",xjnf) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",xjnf) -- 将食谱添加进便携锅



GLOBAL.STRINGS.NAMES["XCHG"]="香草花糕"
local xchg = {
    test = function(cooker, names, tags)
        return names.petals == 2 and names.honey == 2
    end,
    name = "xchg", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 10, --吃后回血值
    hunger = 33, --吃后回饥饿值
    sanity = 33, --吃后回精神值
    perishtime = 6000, --腐烂时间
    cooktime = 1.2, --烹饪时间
    potlevel = "high",
    cookbook_tex = "xchg.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/xchg.xml",
    -- temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",xchg) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",xchg) -- 将食谱添加进便携锅



GLOBAL.STRINGS.NAMES["CMXBL"]="草莓星冰乐"
local cmxbl = {
    test = function(cooker, names, tags)
        return (names.caomeibean or names.caomeibean_cooked) and names.lightbulb and names.honey and names.ice
    end,
    name = "cmxbl", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 12, --吃后回血值
    hunger = 25, --吃后回饥饿值
    sanity = 33, --吃后回精神值
    perishtime = 6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "cmxbl.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/cmxbl.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",cmxbl) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",cmxbl) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["CMSD"]="草莓圣代"
local cmsd = {
    test = function(cooker, names, tags)
        return (names.caomeibean or names.caomeibean_cooked) and names.milkywhites and names.honey and names.ice
    end,
    name = "cmsd", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是肉类
    health = 5, --吃后回血值
    hunger = 5, --吃后回饥饿值
    sanity = 50, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "cmsd.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/cmsd.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",cmsd) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",cmsd) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["ZSHD"]="杂食混炖"
local zshd = {
    test = function(cooker, names, tags)
        return (names.cactus_meat or names.cactus_meat_cooked) and (names.carrot or names.carrot_cooked )and (names.berries or names.berries_cooked )and  (names.acorn or names.acorn_cooked)
    end,
    name = "zshd", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = FOODTYPE.ROUGHAGE,
    secondaryfoodtype = FOODTYPE.WOOD,
    health = 1000, --吃后回血值
    hunger = 300, --吃后回饥饿值
    sanity = 0, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "zshd.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/zshd.xml",
    -- temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",zshd) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",zshd) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["HYPF"]="黄油泡芙"
local hypf = {
    test = function(cooker, names, tags)
        return names.butter and (names.berries or names.berries_cooked ) and  names.bird_egg and names.honey
    end,
    name = "hypf", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 55, --吃后回血值
    hunger = 35, --吃后回饥饿值
    sanity = 25, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "hypf.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/hypf.xml",
    -- temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",hypf) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",hypf) -- 将食谱添加进便携锅



GLOBAL.STRINGS.NAMES["MXMF"]="迷心魔方"
local mxmf = {
    test = function(cooker, names, tags)
        return names.caomeibean and names.lanmeibean and  names.ice and names.honey
    end,
    name = "mxmf", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 5, --吃后回血值
    hunger = 25, --吃后回饥饿值
    sanity = 75, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "mxmf.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/mxmf.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",mxmf) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",mxmf) -- 将食谱添加进便携锅



GLOBAL.STRINGS.NAMES["JDHTJ"]="鸟蛋海带卷"
local jdhtj = {
    test = function(cooker, names, tags)
        return (names.bird_egg or names.bird_egg_cooked)and (names.kelp or names.kelp_cooked) and  names.lightbulb and (names.fishmeat or names.fishmeat_cooked or names.fishmeat_small or names.fishmeat_small_cooked or names.pondfish)
    end,
    name = "jdhtj", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 25, --吃后回血值
    hunger = 95, --吃后回饥饿值
    sanity = 5, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "jdhtj.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/jdhtj.xml",
    temperature = 800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",jdhtj) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",jdhtj) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["XZBD"]="星之布丁"
local xzbd = {
    test = function(cooker, names, tags)
        return names.butter and (names.goatmilk or names.sjy_shouchongyangnai) and names.bird_egg and names.honey
    end,
    name = "xzbd", -- 料理名
    weight = 100, -- 食谱权重
    priority = 550, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 50, --吃后回血值
    hunger = 33, --吃后回饥饿值
    sanity = 50, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "xzbd.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/xzbd.xml",
    temperature = 800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",xzbd) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",xzbd) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_SHUTIAO"]="油炸薯条"
local sjy_shutiao = {
    test = function(cooker, names, tags)
        return names.butter and names.potato == 3 
    end,
    name = "sjy_shutiao", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 5, --吃后回血值
    hunger = 33, --吃后回饥饿值
    sanity = 150, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_shutiao.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_shutiao.xml",
    temperature = 800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_shutiao) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_shutiao) -- 将食谱添加进便携锅\


GLOBAL.STRINGS.NAMES["SJY_PAIGU"]="碳烤排骨"
local sjy_paigu = {
    test = function(cooker, names, tags)
        return names.meat==2 and names.pepper and names.twigs
    end,
    name = "sjy_paigu", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 40, --吃后回血值
    hunger = 95, --吃后回饥饿值
    sanity = -5, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_paigu.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_paigu.xml",
    temperature = 800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_paigu) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_paigu) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_YUDOUFU"]="糖醋鱼豆腐"
local sjy_yudoufu = {
    test = function(cooker, names, tags)
        return (names.fishmeat_cooked or names.fishmeat_small or names.fishmeat_small_cooked) and names.honey and names.tomato and names.ice
    end,
    name = "sjy_yudoufu", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 75, --吃后回血值
    hunger = 62, --吃后回饥饿值
    sanity = 5, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_yudoufu.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_yudoufu.xml",
    temperature = 800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_yudoufu) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_yudoufu) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SWYSS"]="三文鱼寿司"
local swyss = {
    test = function(cooker, names, tags)
        return (names.fishmeat or names.fishmeat_cooked or names.fishmeat_small or names.fishmeat_small_cooked)==2 and names.kelp and names.ice
    end,
    name = "swyss", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 60, --吃后回血值
    hunger = 37.5, --吃后回饥饿值
    sanity = 33, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "swyss.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/swyss.xml",
    temperature = 800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",swyss) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",swyss) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["TSDKZ"]="天使的馈赠"
local tsdkz = {
    test = function(cooker, names, tags)
        return names.lightbulb and names.wormlight and names.forgetmelots and names.ice
    end,
    name = "tsdkz", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 17, --吃后回血值
    hunger = 18, --吃后回饥饿值
    sanity = 19, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "tsdkz.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/tsdkz.xml",
    temperature = 800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",tsdkz) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",tsdkz) -- 将食谱添加进便携锅



GLOBAL.STRINGS.NAMES["SJY_BAIQIESHENGDAI"]="白茄圣代"
local sjy_baiqieshengdai = {
    test = function(cooker, names, tags)
        return names.eggplant == 2 and  names.ice == 2
    end,
    name = "sjy_baiqieshengdai", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 40, --吃后回血值
    hunger = 20, --吃后回饥饿值
    sanity = 5, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_baiqieshengdai.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_baiqieshengdai.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_baiqieshengdai) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_baiqieshengdai) -- 将食谱添加进便携锅



GLOBAL.STRINGS.NAMES["SJY_BIWANGWOBINGJILING"]="必忘我冰激凌"
local sjy_biwangwobingjiling = {
    test = function(cooker, names, tags)
        return names.forgetmelots  and names.ice == 2 and names.honey
    end,
    name = "sjy_biwangwobingjiling", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 5, --吃后回血值
    hunger = 20, --吃后回饥饿值
    sanity = 60, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_biwangwobingjiling.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_biwangwobingjiling.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_biwangwobingjiling) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_biwangwobingjiling) -- 将食谱添加进便携锅



GLOBAL.STRINGS.NAMES["SJY_BIWANGWOSHENGDAI"]="必忘我圣代"
local sjy_biwangwoshengdai = {
    test = function(cooker, names, tags)
        return names.forgetmelots == 2  and names.ice == 2 
    end,
    name = "sjy_biwangwoshengdai", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 5, --吃后回血值
    hunger = 10, --吃后回饥饿值
    sanity = 120, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_biwangwoshengdai.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_biwangwoshengdai.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_biwangwoshengdai) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_biwangwoshengdai) -- 将食谱添加进便携锅



GLOBAL.STRINGS.NAMES["SJY_FANQIEBINGJILING"]="番茄冰激凌"
local sjy_fanqiebingjiling = {
    test = function(cooker, names, tags)
        return names.tomato == 2  and names.ice == 2 
    end,
    name = "sjy_fanqiebingjiling", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 30, --吃后回血值
    hunger = 20, --吃后回饥饿值
    sanity = 5, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_fanqiebingjiling.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_fanqiebingjiling.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_fanqiebingjiling) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_fanqiebingjiling) -- 将食谱添加进便携锅



GLOBAL.STRINGS.NAMES["SJY_FANQIEQIAOKELITONG"]="番茄巧克力冰激凌桶"
local sjy_fanqieqiaokelitong = {
    test = function(cooker, names, tags)
        return names.tomato == 3  and names.ice == 1 
    end,
    name = "sjy_fanqieqiaokelitong", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 90, --吃后回血值
    hunger = 30, --吃后回饥饿值
    sanity = 10, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_fanqieqiaokelitong.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_fanqieqiaokelitong.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_fanqieqiaokelitong) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_fanqieqiaokelitong) -- 将食谱添加进便携锅



GLOBAL.STRINGS.NAMES["SJY_HULUOBOBINGJILING"]="胡萝卜冰激凌"
local sjy_huluobobingjiling = {
    test = function(cooker, names, tags)
        return names.carrot == 2  and names.ice == 2 
    end,
    name = "sjy_huluobobingjiling", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 20, --吃后回血值
    hunger = 120, --吃后回饥饿值
    sanity = 5, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_huluobobingjiling.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_huluobobingjiling.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_huluobobingjiling) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_huluobobingjiling) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_JIUCAIBINGJILING"]="韭菜冰激凌"
local sjy_jiucaibingjiling = {
    test = function(cooker, names, tags)
        return names.jiucaibean == 3  and names.ice == 1 
    end,
    name = "sjy_jiucaibingjiling", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 60, --吃后回血值
    hunger = 60, --吃后回饥饿值
    sanity = 15, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_jiucaibingjiling.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_jiucaibingjiling.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_jiucaibingjiling) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_jiucaibingjiling) -- 将食谱添加进便携锅



GLOBAL.STRINGS.NAMES["SJY_LAJIAOBINGJILING"]="辣椒冰激凌"
local sjy_lajiaobingjiling = {
    test = function(cooker, names, tags)
        return names.pepper == 2  and names.ice == 2 
    end,
    name = "sjy_lajiaobingjiling", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = -25, --吃后回血值
    hunger = 15, --吃后回饥饿值
    sanity = 150, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_lajiaobingjiling.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_lajiaobingjiling.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_lajiaobingjiling) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_lajiaobingjiling) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_LIDICAOBINGJILING"]="犁地草冰激凌"
local sjy_lidicaobingjiling = {
    test = function(cooker, names, tags)
        return names.tillweed == 2  and names.ice == 2 
    end,
    name = "sjy_lidicaobingjiling", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 25, --吃后回血值
    hunger = 25, --吃后回饥饿值
    sanity = 25, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_lidicaobingjiling.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_lidicaobingjiling.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_lidicaobingjiling) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_lidicaobingjiling) -- 将食谱添加进便携锅



GLOBAL.STRINGS.NAMES["SJY_LUSUNBINGJILING"]="芦笋冰激凌"
local sjy_lusunbingjiling = {
    test = function(cooker, names, tags)
        return names.asparagus == 2  and names.ice == 2 
    end,
    name = "sjy_lusunbingjiling", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 20, --吃后回血值
    hunger = 66.6, --吃后回饥饿值
    sanity = 5, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_lusunbingjiling.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_lusunbingjiling.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_lusunbingjiling) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_lusunbingjiling) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_NANGUABINGJILING"]="南瓜冰激凌"
local sjy_nanguabingjiling = {
    test = function(cooker, names, tags)
        return names.pumpkin == 3  and names.ice == 1
    end,
    name = "sjy_nanguabingjiling", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 60, --吃后回血值
    hunger = 200, --吃后回饥饿值
    sanity = 15, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_nanguabingjiling.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_nanguabingjiling.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_nanguabingjiling) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_nanguabingjiling) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_NANGUASHENGDAI"]="南瓜圣代"
local sjy_nanguashengdai = {
    test = function(cooker, names, tags)
        return names.pumpkin == 2  and names.ice == 2
    end,
    name = "sjy_nanguashengdai", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 40, --吃后回血值
    hunger = 75, --吃后回饥饿值
    sanity = 10, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_nanguashengdai.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_nanguashengdai.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_nanguashengdai) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_nanguashengdai) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_QIEZIBINGJILING"]="茄子冰激凌"
local sjy_qiezibingjiling = {
    test = function(cooker, names, tags)
        return names.eggplant == 3  and names.ice == 1
    end,
    name = "sjy_qiezibingjiling", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 60, --吃后回血值
    hunger = 66, --吃后回饥饿值
    sanity = 6, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_qiezibingjiling.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_qiezibingjiling.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_qiezibingjiling) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_qiezibingjiling) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_SUANRONGBINGJILING"]="蒜蓉冰激凌"
local sjy_suanrongbingjiling = {
    test = function(cooker, names, tags)
        return names.garlic == 2  and names.ice == 2
    end,
    name = "sjy_suanrongbingjiling", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 10, --吃后回血值
    hunger = 20, --吃后回饥饿值
    sanity = 100, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_suanrongbingjiling.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_suanrongbingjiling.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_suanrongbingjiling) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_suanrongbingjiling) -- 将食谱添加进便携锅



GLOBAL.STRINGS.NAMES["SJY_TUDOUBINGJILING"]="土豆冰激凌"
local sjy_tudoubingjiling = {
    test = function(cooker, names, tags)
        return names.potato == 3  and names.ice == 1
    end,
    name = "sjy_tudoubingjiling", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 60, --吃后回血值
    hunger = 75, --吃后回饥饿值
    sanity = 33, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_tudoubingjiling.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_tudoubingjiling.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_tudoubingjiling) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_tudoubingjiling) -- 将食谱添加进便携锅



GLOBAL.STRINGS.NAMES["SJY_YANGCHONGBINGJILING"]="洋葱冰激凌"
local sjy_yangchongbingjiling = {
    test = function(cooker, names, tags)
        return names.onion == 2  and names.ice == 2
    end,
    name = "sjy_yangchongbingjiling", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 30, --吃后回血值
    hunger = 15, --吃后回饥饿值
    sanity = 5, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_yangchongbingjiling.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_yangchongbingjiling.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_yangchongbingjiling) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_yangchongbingjiling) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_YANGCHONGSHENGDAI"]="洋葱圣代"
local sjy_yangchongshengdai = {
    test = function(cooker, names, tags)
        return names.onion == 3  and names.ice == 1
    end,
    name = "sjy_yangchongshengdai", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 45, --吃后回血值
    hunger = 55, --吃后回饥饿值
    sanity = 15, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_yangchongshengdai.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_yangchongshengdai.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_yangchongshengdai) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_yangchongshengdai) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_YUMIBINGJILING"]="玉米冰激凌"
local sjy_yumibingjiling = {
    test = function(cooker, names, tags)
        return names.corn == 3  and names.ice == 1
    end,
    name = "sjy_yumibingjiling", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 60, --吃后回血值
    hunger = 75, --吃后回饥饿值
    sanity = 0, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_yumibingjiling.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_yumibingjiling.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_yumibingjiling) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_yumibingjiling) -- 将食谱添加进便携锅



GLOBAL.STRINGS.NAMES["SJY_ZIQIESHENGDAI"]="紫茄圣代"
local sjy_ziqieshengdai = {
    test = function(cooker, names, tags)
        return names.eggplant == 1  and names.ice == 1 and names.honey == 2
    end,
    name = "sjy_ziqieshengdai", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 20, --吃后回血值
    hunger = 5, --吃后回饥饿值
    sanity = 40, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 0.4, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_ziqieshengdai.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_ziqieshengdai.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_ziqieshengdai) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_ziqieshengdai) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_HUOLONGGUOBINGJILING"]="火龙果冰激凌"
local sjy_huolongguobingjiling = {
    test = function(cooker, names, tags)
        return names.dragonfruit == 2  and names.ice == 2 
    end,
    name = "sjy_huolongguobingjiling", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 60, --吃后回血值
    hunger = 15, --吃后回饥饿值
    sanity = 5, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_huolongguobingjiling.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_huolongguobingjiling.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_huolongguobingjiling) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_huolongguobingjiling) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_LANMEIBINGJILING"]="蓝莓冰激凌"
local sjy_lanmeibingjiling = {
    test = function(cooker, names, tags)
        return names.lanmeibean == 2  and names.ice == 2 
    end,
    name = "sjy_lanmeibingjiling", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 20, --吃后回血值
    hunger = 15, --吃后回饥饿值
    sanity = 5, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_lanmeibingjiling.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_lanmeibingjiling.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_lanmeibingjiling) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_lanmeibingjiling) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_LANMEISHENGDAI"]="蓝莓圣代"
local sjy_lanmeishengdai = {
    test = function(cooker, names, tags)
        return names.lanmeibean == 3  and names.ice == 1 
    end,
    name = "sjy_lanmeishengdai", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 60, --吃后回血值
    hunger = 5, --吃后回饥饿值
    sanity = 15, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_lanmeishengdai.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_lanmeishengdai.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_lanmeishengdai) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_lanmeishengdai) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_LIULIANBINGJILING"]="榴莲冰激凌"
local sjy_liulianbingjiling = {
    test = function(cooker, names, tags)
        return names.durian == 3  and names.ice == 1 
    end,
    name = "sjy_liulianbingjiling", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 80, --吃后回血值
    hunger = 80, --吃后回饥饿值
    sanity = 80, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_liulianbingjiling.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_liulianbingjiling.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_liulianbingjiling) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_liulianbingjiling) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_SHILIUBINGJLING"]="石榴冰激凌"
local sjy_shiliubingjling = {
    test = function(cooker, names, tags)
        return names.pomegranate == 2  and names.ice == 2 
    end,
    name = "sjy_shiliubingjling", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 30, --吃后回血值
    hunger = 25, --吃后回饥饿值
    sanity = 20, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_shiliubingjling.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_shiliubingjling.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_shiliubingjling) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_shiliubingjling) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_SHILIUSHENGDAI"]="石榴圣代"
local sjy_shiliushengdai = {
    test = function(cooker, names, tags)
        return names.pomegranate == 3  and names.ice == 1 
    end,
    name = "sjy_shiliushengdai", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 60, --吃后回血值
    hunger = 35, --吃后回饥饿值
    sanity = 0, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_shiliushengdai.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_shiliushengdai.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_shiliushengdai) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_shiliushengdai) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_SUANGQIUHUOLONGGUOBINGJILING"]="双球火龙果冰激凌"
local sjy_suangqiuhuolongguobingjiling = {
    test = function(cooker, names, tags)
        return names.dragonfruit == 3  and names.ice == 1 
    end,
    name = "sjy_suangqiuhuolongguobingjiling", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 100, --吃后回血值
    hunger = 50, --吃后回饥饿值
    sanity = 0, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_suangqiuhuolongguobingjiling.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_suangqiuhuolongguobingjiling.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_suangqiuhuolongguobingjiling) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_suangqiuhuolongguobingjiling) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_XIGUABINGJILING"]="西瓜冰激凌"
local sjy_xiguabingjiling = {
    test = function(cooker, names, tags)
        return names.watermelon == 2  and names.ice == 2 
    end,
    name = "sjy_xiguabingjiling", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 20, --吃后回血值
    hunger = 75, --吃后回饥饿值
    sanity = 66, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_xiguabingjiling.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_xiguabingjiling.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_xiguabingjiling) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_xiguabingjiling) -- 将食谱添加进便携锅



GLOBAL.STRINGS.NAMES["SJY_XIGUASHENGDAI"]="西瓜圣代"
local sjy_xiguashengdai = {
    test = function(cooker, names, tags)
        return names.watermelon == 3  and names.ice == 1 
    end,
    name = "sjy_xiguashengdai", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 5, --吃后回血值
    hunger = 25, --吃后回饥饿值
    sanity = 100, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_xiguashengdai.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_xiguashengdai.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_xiguashengdai) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_xiguashengdai) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_ABIGAIERDEZHUFU"]="阿比盖尔的祝福"
local sjy_abigaierdezhufu = {
    test = function(cooker, names, tags)
        return names.ghostflower == 2  and names.ice == 1 and names.petals ==1
    end,
    name = "sjy_abigaierdezhufu", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 5, --吃后回血值
    hunger = 25, --吃后回饥饿值
    sanity = 5, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_abigaierdezhufu.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_abigaierdezhufu.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_abigaierdezhufu) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_abigaierdezhufu) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_ABIGAIERZHIYI"]="阿比盖尔之遗"
local sjy_abigaierzhiyi = {
    test = function(cooker, names, tags)
        return names.ghostflower == 1  and names.ice == 1 and names.petals ==1 and names.honey ==1
    end,
    name = "sjy_abigaierzhiyi", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 15, --吃后回血值
    hunger = 5, --吃后回饥饿值
    sanity = 30, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_abigaierzhiyi.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_abigaierzhiyi.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_abigaierzhiyi) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_abigaierzhiyi) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_CHALIDEZHUFU"]="查理的祝福"
local sjy_chalidezhufu = {
    test = function(cooker, names, tags)
        return names.petals_evil == 2  and names.ice == 1 and names.petals ==1 
    end,
    name = "sjy_chalidezhufu", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = -5, --吃后回血值
    hunger = 15, --吃后回饥饿值
    sanity = -10, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_chalidezhufu.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_chalidezhufu.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_chalidezhufu) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_chalidezhufu) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_JINIANCHALI"]="纪念查理"
local sjy_jinianchali = {
    test = function(cooker, names, tags)
        return names.nightmarefuel == 2  and names.ice == 1 and names.petals ==1 
    end,
    name = "sjy_jinianchali", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 0, --吃后回血值
    hunger = 20, --吃后回饥饿值
    sanity = 0, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_jinianchali.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_jinianchali.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_jinianchali) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_jinianchali) -- 将食谱添加进便携锅



GLOBAL.STRINGS.NAMES["SJY_HUIYIZHONGDEMEIGUI"]="回忆中的玫瑰"
local sjy_huiyizhongdemeigui = {
    test = function(cooker, names, tags)
        return names.honey == 1  and names.ice == 1 and names.petals ==2 
    end,
    name = "sjy_huiyizhongdemeigui", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 20, --吃后回血值
    hunger = 20, --吃后回饥饿值
    sanity = 40, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_huiyizhongdemeigui.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_huiyizhongdemeigui.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_huiyizhongdemeigui) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_huiyizhongdemeigui) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_MEIGUIZHIYUE"]="玫瑰之约"
local sjy_meiguizhiyue = {
    test = function(cooker, names, tags)
        return names.petals_evil == 1  and names.ice == 1 and names.petals ==2 
    end,
    name = "sjy_meiguizhiyue", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = -20, --吃后回血值
    hunger = 5, --吃后回饥饿值
    sanity = -5, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_meiguizhiyue.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_meiguizhiyue.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_meiguizhiyue) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_meiguizhiyue) -- 将食谱添加进便携锅
-- AddCookerRecipe("sjy_wanshengjieguo", sjy_meiguizhiyue) -- 将食谱添加进便携锅

-------------------------------警钟长鸣联动
local shadowtaffy = {
    test = function(cooker, names, tags)
        return names.taffy and names.nightmarefuel and names.nightmarefuel==3
    end,
    name = "shadowtaffy", -- 料理名(阴影太妃糖)
    weight = 1, -- 食谱权重
    priority = 100, -- 食谱优先级
    -- overridebuild = "cook_pot_food_wanda",
    foodtype = GLOBAL.FOODTYPE.SHADOW, --料理的食物类型，比如这里定义的是肉类
    health = 0, --吃后回血值
    hunger = 0, --吃后回饥饿值
    sanity = -80, --吃后回精神值
    perishtime = nil, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "mid",	
    cookbook_tex = "shadowtaffy.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/inventoryimages/shadowtaffy.xml",
    -- temperature = TUNING.HOT_FOOD_BONUS_TEMP, --某些食物吃了之后有温度变化，则是在这地方定义的
    -- temperatureduration = TUNING.FOOD_TEMP_BRIEF,
    oneatenfn = function(inst, eater)
        eater:AddDebuff("shadowtaffybuff", "shadowtaffybuff")
    end,
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot",
    overridebuild="shadowtaffy",
    overridesymbolname="food"

}
AddCookerRecipe("cookpot", shadowtaffy) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot", shadowtaffy) -- 将食谱添加进便携锅
-- AddCookerRecipe("sjy_wanshengjieguo", shadowtaffy) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_YITONGTUDOUNI"]="一桶土豆泥"
local sjy_yitongtudouni = {
    test = function(cooker, names, tags)
        return names.potato == 2  and names.butter == 1 and names.garlic ==1 
    end,
    name = "sjy_yitongtudouni", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 60, --吃后回血值
    hunger = 12.5, --吃后回饥饿值
    sanity = 33, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_yitongtudouni.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_yitongtudouni.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_yitongtudouni) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_yitongtudouni) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_BANLIYINGGUANGGUOPAOFU"]="板栗荧光果泡芙-万圣节"
local sjy_banliyingguangguopaofu = {
    test = function(cooker, names, tags)
        return names.lightbulb == 2  and names.butter == 1 and (names.banlibean1 ==1 or names.cookbanli )
    end,
    name = "sjy_banliyingguangguopaofu", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 40, --吃后回血值
    hunger = 25, --吃后回饥饿值
    sanity = 40, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_banliyingguangguopaofu.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_banliyingguangguopaofu.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("sjy_wanshengjieguo",sjy_banliyingguangguopaofu) -- 将食谱添加进普通锅
-- AddCookerRecipe("portablecookpot",sjy_banliyingguangguopaofu) -- 将食谱添加进便携锅



GLOBAL.STRINGS.NAMES["SJY_NANGUANAINAO"]="南瓜奶酪-万圣节"
local sjy_nanguanainao = {
    test = function(cooker, names, tags)
        return names.pumpkin == 2  and (names.goatmilk==1 or names.sjy_shouchongyangnai==1) and names.honey ==1 
    end,
    name = "sjy_nanguanainao", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 25, --吃后回血值
    hunger = 12.5, --吃后回饥饿值
    sanity = 40, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_nanguanainao.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_nanguanainao.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("sjy_wanshengjieguo",sjy_nanguanainao) -- 将食谱添加进普通锅
-- AddCookerRecipe("portablecookpot",sjy_nanguanainao) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_YOUYUYINGGUANGGUONONGTAN"]="鱿鱼荧光果浓汤-万圣节"
local sjy_youyuyingguangguonongtan = {
    test = function(cooker, names, tags)
        return (names.sjy_youyuxu_cooked == 2 or names.sjy_youyuxu == 2)  and names.lightbulb == 1 and names.ice ==1 
    end,
    name = "sjy_youyuyingguangguonongtan", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 40, --吃后回血值
    hunger = 33, --吃后回饥饿值
    sanity = 15, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_youyuyingguangguonongtan.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_youyuyingguangguonongtan.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

-- AddCookerRecipe("cookpot",sjy_youyuyingguangguonongtan) -- 将食谱添加进普通锅
AddCookerRecipe("sjy_wanshengjieguo",sjy_youyuyingguangguonongtan) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_YINGGUANGUOXIANRENGZHANGSHALA"]="荧光果仙人掌沙拉-万圣节"
local sjy_yingguanguoxianrengzhangshala = {
    test = function(cooker, names, tags)
        return names.lightbulb == 1 and names.cactus_meat == 1  and names.petals == 1 and names.fig ==1 
    end,
    name = "sjy_yingguanguoxianrengzhangshala", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 20, --吃后回血值
    hunger = 35, --吃后回饥饿值
    sanity = -5, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_yingguanguoxianrengzhangshala.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_yingguanguoxianrengzhangshala.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

-- AddCookerRecipe("cookpot",sjy_yingguanguoxianrengzhangshala) -- 将食谱添加进普通锅
AddCookerRecipe("sjy_wanshengjieguo",sjy_yingguanguoxianrengzhangshala) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_ZHITUODANGAO"]="纸托蛋糕-万圣节"
local sjy_zhituodangao = {
    test = function(cooker, names, tags)
        return names.lightbulb == 2 and names.sjy_miantuan == 1  and (names.goatmilk==1 or names.sjy_shouchongyangnai==1)
    end,
    name = "sjy_zhituodangao", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 80, --吃后回血值
    hunger = 66, --吃后回饥饿值
    sanity = 20, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_zhituodangao.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_zhituodangao.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("sjy_wanshengjieguo",sjy_zhituodangao) -- 将食谱添加进普通锅
-- AddCookerRecipe("portablecookpot",sjy_zhituodangao) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_YOULINGGUODONG"]="幽灵果冻-万圣节"
local sjy_youlingguodong = {
    test = function(cooker, names, tags)
        return names.glommerfuel == 2 and names.berries == 1  and names.ice == 1 
    end,
    name = "sjy_youlingguodong", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 100, --吃后回血值
    hunger = 10, --吃后回饥饿值
    sanity = -100, --吃后回精神值
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_youlingguodong.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_youlingguodong.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("sjy_wanshengjieguo",sjy_youlingguodong) -- 将食谱添加进普通锅
-- AddCookerRecipe("portablecookpot",sjy_youlingguodong) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_YIBEIZHENGLIUSHUI"]="一杯纯净水"
local sjy_yibeizhengliushui = {
    test = function(cooker, names, tags)
        return  names.ice == 4
    end,
    name = "sjy_yibeizhengliushui", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 1, --吃后回血值
    hunger = 1, --吃后回饥饿值
    sanity = 5, --吃后回精神值
    stacksize = 4,
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_yibeizhengliushui.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_yibeizhengliushui.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_yibeizhengliushui) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_yibeizhengliushui) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_MIANTUAN"]="发酵好的面团"
local sjy_miantuan = {
    test = function(cooker, names, tags)
        return  names.sjy_yibeizhengliushui == 2 and names.sjy_mianfen ==2
    end,
    -- names.xxx == 1 and (names.xxx ==3 or names.xxx ==3 or names.xxx ==3 or names.xxx ==3)
    -- names.xxx == 1 and (names.xxx  or names.xxx or names.xxx  or names.xxx ) and (names.xxx  or names.xxx or names.xxx  or names.xxx ) and (names.xxx  or names.xxx or names.xxx  or names.xxx )
    name = "sjy_miantuan", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = -5, --吃后回血值
    hunger = 66, --吃后回饥饿值
    sanity = -50, --吃后回精神值
    stacksize = 2,
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_miantuan.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_miantuan.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_miantuan) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_miantuan) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_YOULINGMANTOU"]="幽灵馒头-万圣节"
local sjy_youlingmantou = {
    test = function(cooker, names, tags)
        return names.nightmarefuel == 1 and names.sjy_miantuan == 1  and names.lightbulb == 1 and names.honey == 1 
    end,
    name = "sjy_youlingmantou", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 20, --吃后回血值
    hunger = 75, --吃后回饥饿值
    sanity = -5, --吃后回精神值
    stacksize = 1,
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_youlingmantou.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_youlingmantou.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

-- AddCookerRecipe("cookpot",sjy_youlingmantou) -- 将食谱添加进普通锅
AddCookerRecipe("sjy_wanshengjieguo",sjy_youlingmantou) -- 将食谱添加进便携锅



GLOBAL.STRINGS.NAMES["SJY_NANGUAQIAOKELIDANGAO"]="板栗南瓜巧克力蛋糕-万圣节"
local sjy_nanguaqiaokelidangao = {
    test = function(cooker, names, tags)
        return names.pumpkin == 1 and names.sjy_miantuan == 1  and names.banlibean1 == 1 and names.honey == 1 
    end,
    name = "sjy_nanguaqiaokelidangao", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 25, --吃后回血值
    hunger = 150, --吃后回饥饿值
    sanity = 10, --吃后回精神值
    stacksize = 1,
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_nanguaqiaokelidangao.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_nanguaqiaokelidangao.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

-- AddCookerRecipe("cookpot",sjy_nanguaqiaokelidangao) -- 将食谱添加进普通锅
AddCookerRecipe("sjy_wanshengjieguo",sjy_nanguaqiaokelidangao) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_NIUNAITUANZHIGUAI"]="牛奶团子怪-万圣节"
local sjy_niunaituanzhiguai = {
    test = function(cooker, names, tags)
        return (names.goatmilk==1 or names.sjy_shouchongyangnai==1) and names.sjy_miantuan == 1  and names.lightbulb == 1 and names.honey == 1 
    end,
    name = "sjy_niunaituanzhiguai", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 20, --吃后回血值
    hunger = 75, --吃后回饥饿值
    sanity = 55, --吃后回精神值
    stacksize = 1,
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_niunaituanzhiguai.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_niunaituanzhiguai.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("sjy_wanshengjieguo",sjy_niunaituanzhiguai) -- 将食谱添加进普通锅
-- AddCookerRecipe("portablecookpot",sjy_niunaituanzhiguai) -- 将食谱添加进便携锅



GLOBAL.STRINGS.NAMES["SJY_NANGUAQIUQIBING"]="南瓜曲奇饼-万圣节"
local sjy_nanguaqiuqibing = {
    test = function(cooker, names, tags)
        return names.pumpkin == 2 and names.sjy_miantuan == 1  and names.honey == 1 
    end,
    name = "sjy_nanguaqiuqibing", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 33, --吃后回血值
    hunger = 33, --吃后回饥饿值
    sanity = 33, --吃后回精神值
    stacksize = 1,
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_nanguaqiuqibing.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_nanguaqiuqibing.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("sjy_wanshengjieguo",sjy_nanguaqiuqibing) -- 将食谱添加进普通锅
-- AddCookerRecipe("portablecookpot",sjy_nanguaqiuqibing) -- 将食谱添加进便携锅



GLOBAL.STRINGS.NAMES["SJY_BINGPINIUNAIXUEGAO"]="幽灵冰皮牛奶雪糕-万圣节"
local sjy_bingpiniunaixuegao = {
    test = function(cooker, names, tags)
        return (names.goatmilk==1 or names.sjy_shouchongyangnai==1) and names.ice == 2  and names.honey == 1 
    end,
    name = "sjy_bingpiniunaixuegao", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 60, --吃后回血值
    hunger = 15, --吃后回饥饿值
    sanity = 50, --吃后回精神值
    stacksize = 1,
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_bingpiniunaixuegao.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_bingpiniunaixuegao.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("sjy_wanshengjieguo",sjy_bingpiniunaixuegao) -- 将食谱添加进普通锅
-- AddCookerRecipe("portablecookpot",sjy_bingpiniunaixuegao) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_BANLIBUDIN"]="捣蛋鬼板栗布丁-万圣节"
local sjy_banlibudin = {
    test = function(cooker, names, tags)
        return names.glommerfuel == 1 and names.banlibean1 == 1  and names.sjy_yibeizhengliushui == 1 and names.ice == 1 
    end,
    name = "sjy_banlibudin", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 60, --吃后回血值
    hunger = 15, --吃后回饥饿值
    sanity = -5, --吃后回精神值
    stacksize = 1,
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_banlibudin.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_banlibudin.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}
AddCookerRecipe("sjy_wanshengjieguo",sjy_banlibudin ) -- 将食谱添加进万圣节锅
-- AddCookerRecipe("cookpot",sjy_banlibudin) -- 将食谱添加进普通锅
-- AddCookerRecipe("portablecookpot",sjy_banlibudin) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_GUAIWUTIANTIANQUAN"]="怪物甜甜圈-万圣节"
local sjy_guaiwutiantianquan = {
    test = function(cooker, names, tags)
        return names.pumpkin == 1 and names.banlibean1 == 1  and names.lightbulb == 1 and names.honey == 1 
    end,
    name = "sjy_guaiwutiantianquan", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 15, --吃后回血值
    hunger = 33, --吃后回饥饿值
    sanity = 33, --吃后回精神值
    stacksize = 1,
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_guaiwutiantianquan.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_guaiwutiantianquan.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}
AddCookerRecipe("sjy_wanshengjieguo",sjy_guaiwutiantianquan ) -- 将食谱添加进万圣节锅
-- AddCookerRecipe("cookpot",sjy_guaiwutiantianquan) -- 将食谱添加进普通锅
-- AddCookerRecipe("portablecookpot",sjy_guaiwutiantianquan) -- 将食谱添加进便携锅



GLOBAL.STRINGS.NAMES["SJY_BINGPIMEIQIUTUANZI"]="冰皮霉球团子-万圣节"
local sjy_bingpimeiqiutuanzi = {
    test = function(cooker, names, tags)
        return names.sjy_yibeizhengliushui == 1 and names.ice == 1  and names.lightbulb == 1 and names.honey == 1 
    end,
    name = "sjy_bingpimeiqiutuanzi", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 20, --吃后回血值
    hunger = 40, --吃后回饥饿值
    sanity = 20, --吃后回精神值
    stacksize = 1,
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_bingpimeiqiutuanzi.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_bingpimeiqiutuanzi.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}
AddCookerRecipe("sjy_wanshengjieguo",sjy_bingpimeiqiutuanzi ) -- 将食谱添加进万圣节锅
-- AddCookerRecipe("cookpot",sjy_bingpimeiqiutuanzi) -- 将食谱添加进普通锅
-- AddCookerRecipe("portablecookpot",sjy_bingpimeiqiutuanzi) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_JIUCAICAODAN"]="韭菜炒蛋"
local sjy_jiucaicaodan = {
    test = function(cooker, names, tags)
        return names.jiucaibean == 2 and names.bird_egg == 2
    end,
    name = "sjy_jiucaicaodan", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 5, --吃后回血值
    hunger = 66, --吃后回饥饿值
    sanity = 20, --吃后回精神值
    stacksize = 1,
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_jiucaicaodan.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_jiucaicaodan.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_jiucaicaodan) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_jiucaicaodan) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_HUANGGUACHAOROU"]="黄瓜炒肉"
local sjy_huangguachaorou = {
    test = function(cooker, names, tags)
        return (names.sjy_huangguabean == 2 or names.sjy_huangguabean_cooked == 2 ) and names.meat==2
    end,
    name = "sjy_huangguachaorou", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 30, --吃后回血值
    hunger = 50, --吃后回饥饿值
    sanity = 10, --吃后回精神值
    stacksize = 1,
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_huangguachaorou.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_huangguachaorou.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_huangguachaorou) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_huangguachaorou) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_LANSENIANCHOU"]="蓝色粘稠物"
local sjy_lansenianchou = {
    test = function(cooker, names, tags)
        return true
    end,
    name = "sjy_lansenianchou", -- 料理名
    weight = 0.0001, -- 食谱权重
    priority = 0.0001, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = -100, --吃后回血值
    hunger = -100, --吃后回饥饿值
    sanity = -100, --吃后回精神值
    stacksize = 1,
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_lansenianchou.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_lansenianchou.xml",
    temperature = -800000*10000, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot",
    spice=""
}   
AddCookerRecipe("sjy_wanshengjieguo",sjy_lansenianchou ) -- 将食谱添加进万圣节锅


GLOBAL.STRINGS.NAMES["SJY_BABAOZHOU"]="八宝粥"
local sjy_babaozhou = {
    test = function(cooker, names, tags)
        return names.sjy_lvdoubean  and names.sjy_huangdoubean  and names.sjy_hongdoubean and names.sjy_heidoubean
    end,
    name = "sjy_babaozhou", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 30, --吃后回血值
    hunger = 75, --吃后回饥饿值
    sanity = 5, --吃后回精神值
    stacksize = 1,
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_babaozhou.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_babaozhou.xml",
    temperature = 0, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_babaozhou) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_babaozhou) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_DONGGUADUNROU"]="冬瓜片炖肉"
local sjy_dongguadunrou = {
    test = function(cooker, names, tags)
        return names.sjy_dongguapian == 2  and (names.meat or names.cookedmeat or names.smallmeat or names.cookedsmallmeat ) and (names.meat or names.cookedmeat or names.smallmeat or names.cookedsmallmeat )-- and names.sjy_hongdoubean and names.sjy_heidoubean
    end,
    name = "sjy_dongguadunrou", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 20, --吃后回血值
    hunger = 66, --吃后回饥饿值
    sanity = 5, --吃后回精神值
    stacksize = 1,
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_dongguadunrou.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_dongguadunrou.xml",
    temperature = 0, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_dongguadunrou) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_dongguadunrou) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_FANQIENONGTANG"]="番茄浓汤"
local sjy_fanqienongtang = {
    test = function(cooker, names, tags)
        return names.tomato == 2  and names.bird_egg  and (names.ice or names.sjy_yibeizhengliushui )-- and names.sjy_hongdoubean and names.sjy_heidoubean
    end,
    name = "sjy_fanqienongtang", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 60, --吃后回血值
    hunger = 25, --吃后回饥饿值
    sanity = 5, --吃后回精神值
    stacksize = 1,
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_fanqienongtang.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_fanqienongtang.xml",
    temperature = 0, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_fanqienongtang) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_fanqienongtang) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_HEIDOUZHOU"]="黑豆粥"
local sjy_heidouzhou = {
    test = function(cooker, names, tags)
        return names.sjy_heidoubean == 2  and (names.ice or names.sjy_yibeizhengliushui ) and (names.ice or names.sjy_yibeizhengliushui )-- and names.sjy_hongdoubean and names.sjy_heidoubean
    end,
    name = "sjy_heidouzhou", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 5, --吃后回血值
    hunger = 20, --吃后回饥饿值
    sanity = 80, --吃后回精神值
    stacksize = 1,
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_heidouzhou.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_heidouzhou.xml",
    temperature = 0, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_heidouzhou) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_heidouzhou) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_HONGDOUZHOU"]="红豆粥"
local sjy_hongdouzhou = {
    test = function(cooker, names, tags)
        return names.sjy_hongdoubean == 2  and (names.ice or names.sjy_yibeizhengliushui ) and (names.ice or names.sjy_yibeizhengliushui )-- and names.sjy_hongdoubean and names.sjy_heidoubean
    end,
    name = "sjy_hongdouzhou", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 80, --吃后回血值
    hunger = 20, --吃后回饥饿值
    sanity = 5, --吃后回精神值
    stacksize = 1,
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_hongdouzhou.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_hongdouzhou.xml",
    temperature = 0, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_hongdouzhou) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_hongdouzhou) -- 将食谱添加进便携锅

GLOBAL.STRINGS.NAMES["SJY_LVDOUZHOU"]="绿豆粥"
local sjy_lvdouzhou = {
    test = function(cooker, names, tags)
        return names.sjy_lvdoubean == 2  and (names.ice or names.sjy_yibeizhengliushui ) and (names.ice or names.sjy_yibeizhengliushui )-- and names.sjy_hongdoubean and names.sjy_heidoubean
    end,
    name = "sjy_lvdouzhou", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 20, --吃后回血值
    hunger = 80, --吃后回饥饿值
    sanity = 5, --吃后回精神值
    stacksize = 1,
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_lvdouzhou.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_lvdouzhou.xml",
    temperature = 0, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_lvdouzhou) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_lvdouzhou) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_QINCAODOUJIAO"]="清炒豆角"
local sjy_qincaodoujiao = {
    test = function(cooker, names, tags)
        return names.sjy_dadoubean == 4  -- and (names.ice or names.sjy_yibeizhengliushui ) and (names.ice or names.sjy_yibeizhengliushui )-- and names.sjy_hongdoubean and names.sjy_heidoubean
    end,
    name = "sjy_qincaodoujiao", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 20, --吃后回血值
    hunger = 35, --吃后回饥饿值
    sanity = 5, --吃后回精神值
    stacksize = 1,
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_qincaodoujiao.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_qincaodoujiao.xml",
    temperature = 0, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_qincaodoujiao) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_qincaodoujiao) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_SUANXIANGQIYIDOU"]="香辣毛豆"
local sjy_suanxiangqiyidou = {
    test = function(cooker, names, tags)
        return names.sjy_dadoubean == 2  and  names.pepper == 1 and  names.garlic == 1  -- and (names.ice or names.sjy_yibeizhengliushui ) and (names.ice or names.sjy_yibeizhengliushui )-- and names.sjy_hongdoubean and names.sjy_heidoubean
    end,
    name = "sjy_suanxiangqiyidou", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 20, --吃后回血值
    hunger = 35, --吃后回饥饿值
    sanity = 66, --吃后回精神值
    stacksize = 1,
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_suanxiangqiyidou.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_suanxiangqiyidou.xml",
    temperature = 0, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_suanxiangqiyidou) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_suanxiangqiyidou) -- 将食谱添加进便携锅



GLOBAL.STRINGS.NAMES["SJY_SHUIZHUROUPIAN"]="水煮肉片"
local sjy_shuizhuroupian = {
    test = function(cooker, names, tags)
        return (names.cookedmeat or names.meat or names.meat_dried or names.smallmeat_dried or names.cookedsmallmeat or names.monstermeat or names.cookedmonstermeat or names.monstermeat_dried ) and names.ice == 3
    end,
    name = "sjy_shuizhuroupian", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 3, --吃后回血值
    hunger = 25, --吃后回饥饿值
    sanity = 5, --吃后回精神值
    stacksize = 1,
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_shuizhuroupian.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_shuizhuroupian.xml",
    temperature = 0, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_shuizhuroupian) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_shuizhuroupian) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_ZHUSHUDEDOUZI"]="泡熟的黄豆"
local sjy_zhushudedouzi = {
    test = function(cooker, names, tags)
        return names.sjy_huangdoubean == 3 and names.sjy_yibeizhengliushui == 1
    end,
    name = "sjy_zhushudedouzi", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 0, --吃后回血值
    hunger = 9, --吃后回饥饿值
    sanity = 3, --吃后回精神值
    stacksize = 4,
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_zhushudedouzi.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_zhushudedouzi.xml",
    temperature = 0, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_zhushudedouzi) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_zhushudedouzi) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_DOUJIANG"]="豆浆"
local sjy_doujiang = {
    test = function(cooker, names, tags)
        return names.sjy_zhushudedouzi == 3 and names.sjy_yibeizhengliushui == 1
    end,
    name = "sjy_doujiang", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 30, --吃后回血值
    hunger = 9, --吃后回饥饿值
    sanity = 3, --吃后回精神值
    stacksize = 4,
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_doujiang.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_doujiang.xml",
    temperature = 0, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_doujiang) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_doujiang) -- 将食谱添加进便携锅



GLOBAL.STRINGS.NAMES["SJY_SHUIDOUFU"]="水豆腐"
local sjy_shuidoufu = {
    test = function(cooker, names, tags)
        return names.sjy_doujiang == 2 and names.sjy_shigaofen == 2
    end,
    name = "sjy_shuidoufu", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 10, --吃后回血值
    hunger = 5, --吃后回饥饿值
    sanity = 12, --吃后回精神值
    stacksize = 4,
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "images/inventoryimages/sjy_shuidoufu.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/inventoryimages/sjy_shuidoufu.xml",
    temperature = 0, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_shuidoufu) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_shuidoufu) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_YANGNAIFEN"]="一包羊奶粉"
local sjy_yangnaifen = {
    test = function(cooker, names, tags)
        return names.goatmilk==4
    end,
    name = "sjy_yangnaifen", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 40, --吃后回血值
    hunger = 12.5, --吃后回饥饿值
    sanity = 20, --吃后回精神值
    stacksize = 1,
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_yangnaifen.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_yangnaifen.xml",
    temperature = 0, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_yangnaifen) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_yangnaifen) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_MAPODOUFU"]="麻婆豆腐"
local sjy_mapodoufu = {
    test = function(cooker, names, tags)
        return names.sjy_shuidoufu==1 and names.pepper == 1 and names.seeds == 1 and (names.sjy_yibeizhengliushui == 1 or names.ice == 1)
    end,
    name = "sjy_mapodoufu", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 30, --吃后回血值
    hunger = 66, --吃后回饥饿值
    sanity = 5, --吃后回精神值
    stacksize = 1,
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_mapodoufu.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_mapodoufu.xml",
    temperature = 0, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_mapodoufu) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_mapodoufu) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_JIANGXIANGDOUFU"]="酱香豆腐"
local sjy_jiangxiangdoufu = {
    test = function(cooker, names, tags)
        return names.sjy_shuidoufu==1 and names.tomato == 1 and names.honey == 1 and (names.sjy_yibeizhengliushui == 1 or names.ice == 1)
    end,
    name = "sjy_jiangxiangdoufu", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 60, --吃后回血值
    hunger = 30, --吃后回饥饿值
    sanity = 15, --吃后回精神值
    stacksize = 1,
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_jiangxiangdoufu.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/sjy_jiangxiangdoufu.xml",
    temperature = 0, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_jiangxiangdoufu) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_jiangxiangdoufu) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_BOLUOFAN"]="菠萝饭"
local sjy_boluofan = {
    test = function(cooker, names, tags)
        return names.sjy_boluobean==1 and names.sjy_dami == 1 and names.honey == 1 and (names.sjy_yibeizhengliushui == 1 or names.ice == 1)
    end,
    name = "sjy_boluofan", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 15, --吃后回血值
    hunger = 80, --吃后回饥饿值
    sanity = 20, --吃后回精神值
    stacksize = 1,
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_boluofan.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/inventoryimages/sjy_boluofan.xml",
    temperature = 0, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_boluofan) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_boluofan) -- 将食谱添加进便携锅

GLOBAL.STRINGS.NAMES["SJY_XIEHUANGJIANGBANFAN"]="蟹黄酱拌饭"
local sjy_xiehuangjiangbanfan = {
    test = function(cooker, names, tags)
        return names.sjy_xiehuangjiang==1 and names.sjy_dami == 2  and (names.sjy_yibeizhengliushui == 1 or names.ice == 1)
    end,
    name = "sjy_xiehuangjiangbanfan", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 15, --吃后回血值
    hunger = 80, --吃后回饥饿值
    sanity = 20, --吃后回精神值
    stacksize = 1,
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_xiehuangjiangbanfan.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/inventoryimages/sjy_xiehuangjiangbanfan.xml",
    temperature = 0, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_xiehuangjiangbanfan) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_xiehuangjiangbanfan) -- 将食谱添加进便携锅

GLOBAL.STRINGS.NAMES["SJY_YOUZHAMIHUA"]="油炸米花"
local sjy_youzhamihua = {
    test = function(cooker, names, tags)
        return names.sjy_zhiwushiyongyou==1 and names.sjy_dami == 3  
    end,
    name = "sjy_youzhamihua", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 15, --吃后回血值
    hunger = 80, --吃后回饥饿值
    sanity = 20, --吃后回精神值
    stacksize = 1,
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_youzhamihua.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/inventoryimages/sjy_youzhamihua.xml",
    temperature = 0, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_youzhamihua) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_youzhamihua) -- 将食谱添加进便携锅

GLOBAL.STRINGS.NAMES["SJY_BAIMIFAN"]="白米饭"
local sjy_baimifan = {
    test = function(cooker, names, tags)
        return (names.sjy_yibeizhengliushui==2 or names.ice==2 )and names.sjy_dami == 2  
    end,
    name = "sjy_baimifan", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 15, --吃后回血值
    hunger = 80, --吃后回饥饿值
    sanity = 20, --吃后回精神值
    stacksize = 1,
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_baimifan.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/inventoryimages/sjy_baimifan.xml",
    temperature = 0, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_baimifan) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_baimifan) -- 将食谱添加进便携锅




GLOBAL.STRINGS.NAMES["SJY_MAODOUJIANGXIANGCHAOFAN"]="毛豆酱香炒饭"
local sjy_maodoujiangxiangchaofan = {
    test = function(cooker, names, tags)
        return names.sjy_baimifan==1 and names.sjy_jiangyou==1 and names.sjy_zhiwushiyongyou == 1 and names.sjy_dadoubean == 1  
    end,
    name = "sjy_maodoujiangxiangchaofan", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 15, --吃后回血值
    hunger = 80, --吃后回饥饿值
    sanity = 20, --吃后回精神值
    stacksize = 1,
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_maodoujiangxiangchaofan.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/inventoryimages/sjy_maodoujiangxiangchaofan.xml",
    temperature = 0, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_maodoujiangxiangchaofan) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_maodoujiangxiangchaofan) -- 将食谱添加进便携锅




GLOBAL.STRINGS.NAMES["SJY_LAJIAOMAODOUCHAOFAN"]="香辣毛豆炒饭"
local sjy_lajiaomaodouchaofan = {
    test = function(cooker, names, tags)
        return names.sjy_baimifan==1 and names.pepper==1 and names.sjy_zhiwushiyongyou == 1 and names.sjy_dadoubean == 1  
    end,
    name = "sjy_lajiaomaodouchaofan", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 15, --吃后回血值
    hunger = 80, --吃后回饥饿值
    sanity = 20, --吃后回精神值
    stacksize = 1,
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_lajiaomaodouchaofan.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/inventoryimages/sjy_lajiaomaodouchaofan.xml",
    temperature = 0, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_lajiaomaodouchaofan) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_lajiaomaodouchaofan) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_XIANGLACHAOFAN"]="香辣炒饭"
local sjy_xianglachaofan = {
    test = function(cooker, names, tags)
        return names.sjy_baimifan==1 and names.pepper==1 and names.sjy_zhiwushiyongyou == 1 and names.sjy_jiangyou == 1  
    end,
    name = "sjy_xianglachaofan", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 15, --吃后回血值
    hunger = 80, --吃后回饥饿值
    sanity = 20, --吃后回精神值
    stacksize = 1,
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_xianglachaofan.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/inventoryimages/sjy_xianglachaofan.xml",
    temperature = 0, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_xianglachaofan) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_xianglachaofan) -- 将食谱添加进便携锅
-- AddCookerRecipe("sjy_chaoguo",sjy_xianglachaofan) -- 将食谱添加进便携锅
-- AddCookerRecipe("sjy_wanshengjieguo",sjy_xianglachaofan) -- 将食谱添加进便携锅


GLOBAL.STRINGS.NAMES["SJY_JIUZHUANDACHANG"]="九转大肠"
local sjy_jiuzhuandachang = {
    test = function(cooker, names, tags)
        return names.sjy_zhudachang==1 and names.sjy_jiangyou==1 and names.sjy_zhiwushiyongyou == 1 and names.poop == 1  
    end,
    name = "sjy_jiuzhuandachang", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 30, --吃后回血值
    hunger = 66, --吃后回饥饿值
    sanity = -20, --吃后回精神值
    stacksize = 1,
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_jiuzhuandachang.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/inventoryimages/sjy_jiuzhuandachang.xml",
    temperature = 0, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_jiuzhuandachang) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_jiuzhuandachang) -- 将食谱添加进便携锅
-- AddCookerRecipe("sjy_chaoguo",sjy_jiuzhuandachang) -- 将食谱添加进便携锅
-- AddCookerRecipe("sjy_wanshengjieguo",sjy_jiuzhuandachang) -- 将食谱添加进便携锅



GLOBAL.STRINGS.NAMES["SJY_GANXIEYOUWAN"]="擀蟹油丸"
local sjy_ganxieyouwan = {
    test = function(cooker, names, tags)
        return names.sjy_xiehuangjiang==1 and names.bird_egg==1 and names.sjy_zhiwushiyongyou == 1 and names.meat == 1  
    end,
    name = "sjy_ganxieyouwan", -- 料理名
    weight = 100, -- 食谱权重
    priority = 999, -- 食谱优先级
    foodtype = FOODTYPE.GOODIES,
    secondaryfoodtype = FOODTYPE.GOODIES,
    health = 66.6, --吃后回血值
    hunger = 99.9, --吃后回饥饿值
    sanity = 88.8, --吃后回精神值
    stacksize = 1,
    perishtime = -6000, --腐烂时间
    cooktime = 1, --烹饪时间
    potlevel = "high",
    cookbook_tex = "sjy_ganxieyouwan.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
    cookbook_atlas = "images/inventoryimages/sjy_ganxieyouwan.xml",
    temperature = 0, --某些食物吃了之后有温度变化，则是在这地方定义的
    oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFALO,
    temperatureduration = 15,
    prefabs = { "wormlight_light_greater" },--预制件                                                                                                ，比如你一把武器有特效，特效是预制物对吧，那么你的特效就可以不在main注册，在武器的这里写就行
	-- oneat_desc = GLOBAL.STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,--字符串。用户界面。食谱。食物效果发光
    floater = {"med", nil, 0.55},
    cookbook_category = "cookpot"
}

AddCookerRecipe("cookpot",sjy_ganxieyouwan) -- 将食谱添加进普通锅
AddCookerRecipe("portablecookpot",sjy_ganxieyouwan) -- 将食谱添加进便携锅
-- AddCookerRecipe("sjy_chaoguo",sjy_ganxieyouwan) -- 将食谱添加进便携锅
-- AddCookerRecipe("sjy_wanshengjieguo",sjy_ganxieyouwan) -- 将食谱添加进便携锅