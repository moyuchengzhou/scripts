GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})

AddIngredientValues({"boards"}, { -- 木板
    inedible = 1 -- inedible：不可食用的
})

AddIngredientValues({"seeds"}, { -- 种子
    veggie = 1 -- inedible：甜味剂
})

AddIngredientValues({"lightbulb"}, { -- 荧光果
    fruit = 1 -- inedible：蔬菜
})

AddIngredientValues({"hambat"}, { -- 火腿棒
    meat = 5 -- inedible：肉类
})

AddIngredientValues({"wobster_sheller_dead_cooked"}, { -- 熟龙虾
    fish = 0.5 -- inedible：鱼类
})

AddIngredientValues({"caomeibean"}, { -- 草莓
    fruit = 1 -- inedible：水果
})

AddIngredientValues({"caomeibean_cooked"}, { -- 烤熟草莓
    fruit = 0.5 -- inedible：水果
})

AddIngredientValues({"lanmeibean_cooked"}, { -- 烤熟蓝莓
    fruit = 0.5 -- inedible：水果
})

AddIngredientValues({"lanmeibean"}, { -- 蓝莓
    fruit = 1 -- inedible：水果
})
AddIngredientValues({"petals"}, { -- 花瓣
    veggie = 0.5 -- inedible：鱼类
})

AddIngredientValues({"spoiled_food"}, { -- 腐烂物
    inedible = 1 -- inedible：不可食用的
})

AddIngredientValues({"marblebean"}, { -- 猪皮
    inedible = 1 -- inedible：鱼类
})

AddIngredientValues({"rocks"}, { -- 猪皮
    inedible = 1 -- inedible：鱼类
})

AddIngredientValues({"flint"}, { -- 猪皮
    inedible = 1 -- inedible：鱼类
})

AddIngredientValues({"marble"}, { -- 猪皮
    inedible = 1 -- inedible：鱼类
})

AddIngredientValues({"rottenegg"}, { -- 猪皮
    inedible = 1 -- inedible：鱼类
})
-- 触手皮：tentaclespots

-- AddIngredientValues({"tentaclespots"}, { -- 猪皮
--     inedible = 1 -- inedible：鱼类
-- })


AddIngredientValues({"jiucaibean"}, { -- 猪皮
    veggie = 1 -- inedible：鱼类
})

AddIngredientValues({"kaojiucai"}, { -- 猪皮
    veggie = 1 -- inedible：鱼类
})

AddIngredientValues({"jiucaihua"}, { -- 猪皮
    veggie = 1,sweetener=1 -- inedible：鱼类
})

AddIngredientValues({"banlibean1"}, { -- 猪皮
    fruit = 1,sweetener=1 -- inedible：鱼类
})

AddIngredientValues({"cookbanli"}, { -- 猪皮
    fruit = 1,sweetener=1 -- inedible：鱼类
})
-- tillweed
AddIngredientValues({"tillweed"}, { -- 猪皮
    veggie = 1,inedible=1 -- inedible：鱼类
})

AddIngredientValues({"caomeixie"}, { -- 猪皮
    fruit = 1,sweetener=1 -- inedible：鱼类
})

AddIngredientValues({"ghostflower"}, { -- 猪皮
    elemental = .1 -- inedible：鱼类
})

AddIngredientValues({"petals_evil"}, { -- 猪皮
    veggie = .1 -- inedible：鱼类
})

AddIngredientValues({"sjy_xiehuangjiang"}, { -- 猪皮
    fish = .1,fat=.1 ,dairy=.1-- inedible：鱼类
})
AddIngredientValues({"taffy"}, {sweetener=30}, true )--太妃糖  
-- AddIngredientValues({"jiucaihua"}, { -- 猪皮
--     veggie = 1,sweetener=1 -- inedible：鱼类
-- })


AddIngredientValues({"sjy_youyuxu"}, { -- 猪皮
    fish = 1,meat = 0.5
})

AddIngredientValues({"sjy_youyuxu_cooked"}, { -- 猪皮
    fish = 1,meat = 0.5
})

AddIngredientValues({"glommerfuel"}, { -- 猪皮
    fat = 1,fruit = 0.5,sweetener = 1
})


AddIngredientValues({"sjy_mianfen"}, { -- 猪皮
    decoration=2 ,inedible = 1
})

AddIngredientValues({"sjy_miantuan"}, { -- 猪皮
    decoration=2 
})

AddIngredientValues({"sjy_yibeizhengliushui"}, { -- 猪皮
    frozenn=1
})


AddIngredientValues({"sjy_huangguabean"}, { -- 猪皮
    veggie = 1 , fruit = 1
})

AddIngredientValues({"sjy_huangguabean_cooked"}, { -- 猪皮
    veggie = 1 , fruit = 1
})

AddIngredientValues({"sjy_dadoubean"}, { -- 猪皮
    veggie = 1 
})

AddIngredientValues({"sjy_lvdoubean"}, { -- 猪皮
    veggie = 1 
})

AddIngredientValues({"sjy_huangdoubean"}, { -- 猪皮
    veggie = 1 
})

AddIngredientValues({"sjy_hongdoubean"}, { -- 猪皮
    veggie = 1 
})

AddIngredientValues({"sjy_heidoubean"}, { -- 猪皮
    veggie = 1 
})

AddIngredientValues({"sjy_dongguabean"}, { -- 猪皮
    veggie = 5 
})

AddIngredientValues({"sjy_dongguapian"}, { -- 猪皮
    veggie = 1 
})

AddIngredientValues({"sjy_zhushudedouzi"}, { -- 猪皮
    veggie = 1 
})

AddIngredientValues({"sjy_shigaofen"}, { -- 猪皮
    inedible = 1 
})

AddIngredientValues({"sjy_doujiang"}, { -- 猪皮
    sweetener = 1 
})

AddIngredientValues({"sjy_choudoufu"}, { -- 猪皮
    magic = 1 ,veggie =1
})


AddIngredientValues({"sjy_shouchongyangnai"}, { -- 猪皮
    dairy = 1
})

AddIngredientValues({"sjy_shuidoufu"}, { -- 猪皮
    magic = 1 ,veggie =1
})

AddIngredientValues({"sjy_boluobean"}, { -- 猪皮
    sweetener = 4 ,fruit =1
})

AddIngredientValues({"sjy_dami"}, { -- 猪皮
    seed = 1
})

AddIngredientValues({"sjy_jiangyou"}, { -- 猪皮
    fat = 1
})

AddIngredientValues({"sjy_zhiwushiyongyou"}, { -- 猪皮
    fat = 1
})

-- AddIngredientValues({"sjy_zhiwushiyongyou"}, { -- 猪皮
--     magic = 1
-- })

AddIngredientValues({"sjy_baimifan"}, { -- 猪皮
    magic = 1
})

AddIngredientValues({"sjy_zhudachang"}, { -- 猪皮
    meat = 0.5
})


AddIngredientValues({"poop"}, { -- 猪皮
    inedible = 1
})