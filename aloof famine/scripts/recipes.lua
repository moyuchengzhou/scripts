-- 
local championtab = 
{
	"dug_caomeibush",
	"dug_lanmeibush",
	"jinhuafazhang",
	"changpianji",
	"xlg_changpian",--星露谷唱片
	"crsjbb_changpian",
	"fen_changpian",
	"myjmdqt_1_changpian",
	"myjmdqt_2_changpian",
	"myjmdqt_3_changpian",
	"qby_changpian",
	"smsnjlb_changpian",
	"srkl_changpian",
	"wwhls_changpian",
	"wwhmbyhb_changpian",
	"wwhmgqb_changpian",
	"xhbkj_changpian",
	"xl_changpian",
	"xrfl_changpian",
	"xrwhj_changpian",
	"zhyw_changpian",
	"jian",
	"dug_jiucai",
	"packim_fishbone",
	"dug_banlibush",
	"sjy_milufazhang",
	"sjy_zrzn",
	"sjy_wlcj",
	"sjy_wsj_meiqiuguai2",
	"sjy_bianfuzhutai",
	"sjy_daodangui",
	"sjy_huangsenanguadeng",
	"sjy_wsj_lazhunangua",
	"sjy_wsj_lvsenanguadeng",
	"sjy_wsj_meiqiuguai",
	"sjy_wsj_meiqiutuanzi",
	"sjy_wsj_nangualazhu",
	"sjy_wsj_putongzhutai",
	"sjy_wsj_youling",
	"sjy_wsj_youlings",
	"sjy_mianfen",
	"dug_sjy_xiaomai",
	"sjy_zhuozi_table",
	"dug_sjy_huangguabush",
	"sjy_wsj_limao",
	"dug_sjy_biwangwo",
	"sjy_guangzhu",
	"dug_sjy_dadoubush",
	"dug_sjy_dongguabush",
	"sjy_dongguapian",
	"sjy_huangjiamengwei",
	"sjy_lvdoubean",
	"sjy_huangdoubean",
	"sjy_hongdoubean",
	"sjy_heidoubean",
	"sjy_jiangbingxiang1",
	"sjy_wanshengjieguo",
	"sjy_mogu_table",
	"sjy_mogu2_table",
	"sjy_mogu3_table",
	"sjy_mogu4_table",
	"sjy_shigaofen",
	"sjy_heilushui",
	"sjy_choudoufu",
	"sjy_shuidoufu",
	"sjy_shouchongyangnai",
	"sjy_jiangbingxiang2",
	"sjy_jiangbingxiang3",
	"sjy_gudongbi",
	"sjy_gudongbi1",
	"sjy_gudongbi2",
	"sjy_gudongbi3",
	"sjy_kekoukele",
	"sjy_chengzhiweifenda",
	"sjy_caomeiweimeinianda",
	"sjy_xuebi",
	"sjy_boluopi",
	"sjy_yuanweishupian",
	"sjy_huangguaweishupian",
	"sjy_fanqieweishupian",
	"sjy_ningmengweishupian",
	"sjy_molihuacha",
	"sjy_lvcha",
	"sjy_cocokele",
	"sjy_xbi",
	"sjy_chengzhiweimeinianda",
	"sjy_putaoweimeinianda",
	"sjy_pingguoweimeinianda",
	"sjy_putongpijiu",
	"sjy_yanjinpijiu",
	"sjy_hongjiu",
	"dug_sjy_shuidaobush",
	"dug_sjy_boluobush",
	"sjy_ningmengweifenda",
	"sjy_jiangyou",
	"sjy_zhiwushiyongyou",
	"sjy_shuiqiuji",
	"sjy_chitang",
	"sjy_book_birds",
	"sjy_book_devour",
	"sjy_book_ikea_guidebook",
	"sjy_book_gemstone",

	

	
	
	
	
}

for k,v in pairs(championtab) do
	RegisterInventoryItemAtlas("images/inventoryimages/"..v..".xml", v..".tex")
end
--二本头
AddRecipe2("dug_caomeibush1",--要制作的物品名称？
				-- 材料名称					数量				图片路径
 {Ingredient("seeds", 5),
				-- 材料名称     	  数量
 Ingredient("acorn", 5)},
	-- 科技
 TECH.SCIENCE_TWO ,{
	-- atlas = "images/inventoryimages/sjy_book_gemstone.xml",
	-- image = "sjy_book_gemstone.tex",
	product = "dug_caomeibush",
	numtogive = 1,
})


AddRecipe2("changpianji",--要制作的物品名称？
 -- 材料名称					数量				图片路径
{Ingredient("goldnugget", 10),
 -- 材料名称     	  数量
Ingredient("transistor", 2)},
-- 科技
TECH.SCIENCE_TWO )

AddRecipe2("dug_lanmeibush1",--要制作的物品名称？
				-- 材料名称					数量				图片路径
 {Ingredient("seeds", 5),
				-- 材料名称     	  数量
 Ingredient("acorn", 5)},
	-- 科技
 TECH.SCIENCE_TWO ,{
	-- atlas = "images/inventoryimages/sjy_book_gemstone.xml",
	-- image = "sjy_book_gemstone.tex",
	product = "dug_lanmeibush",
	numtogive = 1,
})


AddRecipe2("jinhuafazhang",--要制作的物品名称？
 -- 材料名称					数量				图片路径
{Ingredient("lightbulb", 20),
 -- 材料名称     	  数量 horrorfuel
-- Ingredient("purebrilliance", 10),

-- Ingredient("horrorfuel", 10),

Ingredient("twigs", 1)},
-- 科技
TECH.MAGIC_THREE )

-- 黄油
AddRecipe2("butter",--要制作的物品名称？
 -- 材料名称					数量				图片路径
{Ingredient("butterflywings", 10),--蝴蝶翅膀
 -- 材料名称     	  数量 horrorfuel
},
-- 科技
TECH.SCIENCE_TWO )

--四本头
-- TECH.MAGIC_THREE, )

-- --祭坛头
--  TECH.MOON_ALTAR_TWO, )

-- --远古头
-- TECH.ANCIENT_FOUR, )


--星露谷唱片 xlg_changpian
AddRecipe2("xlg_changpian",--要制作的物品名称？
				-- 材料名称					数量				图片路径
 {Ingredient("petals", 5),
				-- 材料名称     	  数量
 Ingredient("transistor", 1)},
	-- 科技
 TECH.SCIENCE_TWO )


-- 星露谷春日
AddRecipe2("crsjbb_changpian",--要制作的物品名称？
				-- 材料名称					数量				图片路径
 {Ingredient("petals", 5),
				-- 材料名称     	  数量
 Ingredient("transistor", 1)},
	-- 科技
 TECH.SCIENCE_TWO )


 -- 皇家萌卫
AddRecipe2("sjy_huangjiamengwei",--要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("petals", 5),
-- 材料名称     	  数量
Ingredient("transistor", 1)},
-- 科技
TECH.SCIENCE_TWO )

-- 风
 AddRecipe2("fen_changpian",--要制作的物品名称？
 -- 材料名称					数量				图片路径
{Ingredient("petals", 5),
 -- 材料名称     	  数量
Ingredient("transistor", 1)},
-- 科技
TECH.SCIENCE_TWO )


-- 姐妹离去的秋天1
AddRecipe2("myjmdqt_1_changpian",--要制作的物品名称？
				-- 材料名称					数量				图片路径
 {Ingredient("petals", 5),
				-- 材料名称     	  数量
 Ingredient("transistor", 1)},
	-- 科技
 TECH.SCIENCE_TWO)


--  姐妹离去的秋天2
 AddRecipe2("myjmdqt_2_changpian",--要制作的物品名称？
 -- 材料名称					数量				图片路径
{Ingredient("petals", 5),
 -- 材料名称     	  数量
Ingredient("transistor", 1)},
-- 科技
TECH.SCIENCE_TWO )


-- 姐妹离去的秋天3
AddRecipe2("myjmdqt_3_changpian",--要制作的物品名称？
				-- 材料名称					数量				图片路径
 {Ingredient("petals", 5),
				-- 材料名称     	  数量
 Ingredient("transistor", 1)},
	-- 科技
 TECH.SCIENCE_TWO )

-- 千本樱
 AddRecipe2("qby_changpian",--要制作的物品名称？
 -- 材料名称					数量				图片路径
{Ingredient("petals", 5),
 -- 材料名称     	  数量
Ingredient("transistor", 1)},
-- 科技
TECH.SCIENCE_TWO )


-- 神秘少女
AddRecipe2("smsnjlb_changpian",--要制作的物品名称？
				-- 材料名称					数量				图片路径
 {Ingredient("petals", 5),
				-- 材料名称     	  数量
 Ingredient("transistor", 1)},
	-- 科技
 TECH.SCIENCE_TWO )

-- 生日快乐

 AddRecipe2("srkl_changpian",--要制作的物品名称？
 -- 材料名称					数量				图片路径
{Ingredient("petals", 5),
 -- 材料名称     	  数量
Ingredient("transistor", 1)},
-- 科技
TECH.SCIENCE_TWO )


-- 汪汪欢乐颂
AddRecipe2("wwhls_changpian",--要制作的物品名称？
				-- 材料名称					数量				图片路径
 {Ingredient("petals", 5),
				-- 材料名称     	  数量
 Ingredient("transistor", 1)},
	-- 科技
 TECH.SCIENCE_TWO )


-- 未闻花名八音盒
 AddRecipe2("wwhmbyhb_changpian",--要制作的物品名称？
 -- 材料名称					数量				图片路径
{Ingredient("petals", 5),
 -- 材料名称     	  数量
Ingredient("transistor", 1)},
-- 科技
TECH.SCIENCE_TWO )


-- 未闻花名钢琴版
AddRecipe2("wwhmgqb_changpian",--要制作的物品名称？
				-- 材料名称					数量				图片路径
 {Ingredient("petals", 5),
				-- 材料名称     	  数量
 Ingredient("transistor", 1)},
	-- 科技
 TECH.SCIENCE_TWO )

 
-- 星河不可及
 AddRecipe2("xhbkj_changpian",--要制作的物品名称？
 -- 材料名称					数量				图片路径
{Ingredient("petals", 5),
 -- 材料名称     	  数量
Ingredient("transistor", 1)},
-- 科技
TECH.SCIENCE_TWO )


-- 夏恋
AddRecipe2("xl_changpian",--要制作的物品名称？
				-- 材料名称					数量				图片路径
 {Ingredient("petals", 5),
				-- 材料名称     	  数量
 Ingredient("transistor", 1)},
	-- 科技
 TECH.SCIENCE_TWO )

-- 夏日风铃
 AddRecipe2("xrfl_changpian",--要制作的物品名称？
 -- 材料名称					数量				图片路径
{Ingredient("petals", 5),
 -- 材料名称     	  数量
Ingredient("transistor", 1)},
-- 科技
TECH.SCIENCE_TWO)


-- 夏日文化祭
AddRecipe2("xrwhj_changpian",--要制作的物品名称？
				-- 材料名称					数量				图片路径
 {Ingredient("petals", 5),
				-- 材料名称     	  数量
 Ingredient("transistor", 1)},
	-- 科技
 TECH.SCIENCE_TWO )


-- 最后一吻
 AddRecipe2("zhyw_changpian",--要制作的物品名称？
				-- 材料名称					数量				图片路径
 {Ingredient("petals", 5),
				-- 材料名称     	  数量
 Ingredient("transistor", 1)},
	-- 科技
 TECH.SCIENCE_TWO )


-- jian

 AddRecipe2("jian",--要制作的物品名称？
 -- 材料名称					数量				图片路径
{Ingredient("purplegem", 5),
 -- 材料名称     	  数量
Ingredient("yellowgem", 1),

Ingredient("boards", 2),
},
-- 科技
TECH.SCIENCE_TWO )

-- 韭菜
AddRecipe2("dug_jiucai1",--要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("seeds", 5),
-- 材料名称     	  数量
Ingredient("spoiled_food", 5),

Ingredient("turf_grass", 1),
},
-- 科技
TECH.SCIENCE_TWO,{
	-- atlas = "images/inventoryimages/sjy_book_gemstone.xml",
	-- image = "sjy_book_gemstone.tex",
	product = "dug_jiucai",
	numtogive = 1,
} )



-- 鱼骨
AddRecipe2("packim_fishbone", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("pondfish", 1),
-- 材料名称     	  数量
Ingredient("spoiled_fish_small", 1)},
-- 科技
TECH.SCIENCE_TWO,
{
atlas = "images/inventoryimages/yugu.xml",
image = "yugu.tex"
}
 )


-- 板栗树根
AddRecipe2("dug_banlibush1", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("acorn", 5),
-- 材料名称     	  数量
Ingredient("seeds", 5)},
-- 科技
TECH.SCIENCE_TWO ,{
	-- atlas = "images/inventoryimages/sjy_book_gemstone.xml",
	-- image = "sjy_book_gemstone.tex",
	product = "dug_banlibush",
	numtogive = 1,
})





-- 麋鹿法杖
AddRecipe2("sjy_milufazhang", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("deerclops_eyeball", 1),
-- 材料名称     	  数量
Ingredient("blueamulet", 1),
Ingredient("amulet", 1)},
-- 科技
TECH.MAGIC_THREE )


-- 自然之怒
AddRecipe2("sjy_zrzn", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("goldnugget", 5),
Ingredient("livinglog", 2),
-- 材料名称     	  数量
Ingredient("yellowgem", 5)},
-- 科技
TECH.SCIENCE_TWO )


-- 蔓绿翠剑
AddRecipe2("sjy_wlcj", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("greengem", 2),
Ingredient("livinglog", 2),
-- 材料名称     	  数量
Ingredient("greenamulet", 1)},
-- 科技
TECH.SCIENCE_TWO )


AddRecipe2("sjy_wsj_meiqiuguai2", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("spoiled_food", 2),
Ingredient("silk", 2)},
-- 科技
TECH.SCIENCE_TWO,
{
	placer = "sjy_wsj_meiqiuguai2_placer",
	atlas = "images/inventoryimages/sjy_wsj_meiqiuguai2.xml",
	image = "sjy_wsj_meiqiuguai2.tex",
	min_spacing = 1,
}
 
)


AddRecipe2("sjy_bianfuzhutai", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("batwing", 2),
Ingredient("charcoal", 5),
Ingredient("torch", 1)
},
-- 科技
TECH.SCIENCE_TWO,
{
	placer = "sjy_bianfuzhutai_placer",
	atlas = "images/inventoryimages/sjy_bianfuzhutai.xml",
	image = "sjy_bianfuzhutai.tex",
	min_spacing = 1,
}
 
)


AddRecipe2("sjy_daodangui", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("boards", 2),
Ingredient("cutgrass", 5),
Ingredient("rope", 3),
Ingredient("silk", 2)
},
-- 科技
TECH.SCIENCE_TWO,
{
	placer = "sjy_daodangui_placer",
	atlas = "images/inventoryimages/sjy_daodangui.xml",
	image = "sjy_daodangui.tex",
	min_spacing = 1,
}
 
)


AddRecipe2("sjy_huangsenanguadeng", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("pumpkin", 1),
Ingredient("torch", 1),
Ingredient("charcoal", 3),
-- Ingredient("silk", 2),
},
-- 科技
TECH.SCIENCE_TWO,
{
	placer = "sjy_huangsenanguadeng_placer",
	atlas = "images/inventoryimages/sjy_huangsenanguadeng.xml",
	image = "sjy_huangsenanguadeng.tex",
	min_spacing = 1,
}
 
)


AddRecipe2("sjy_wsj_lazhunangua", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("pumpkin", 3),
Ingredient("torch", 3),
Ingredient("charcoal", 3),
-- Ingredient("silk", 2),
},
-- 科技
TECH.SCIENCE_TWO,
{
	placer = "sjy_wsj_lazhunangua_placer",
	atlas = "images/inventoryimages/sjy_wsj_lazhunangua.xml",
	image = "sjy_wsj_lazhunangua.tex",
	min_spacing = 1,
}
 
)


AddRecipe2("sjy_wsj_lvsenanguadeng", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("pumpkin", 1),
Ingredient("fireflies", 1),
-- Ingredient("charcoal", 3),
-- Ingredient("silk", 2),
},
-- 科技
TECH.SCIENCE_TWO,
{
	placer = "sjy_wsj_lvsenanguadeng_placer",
	atlas = "images/inventoryimages/sjy_wsj_lvsenanguadeng.xml",
	image = "sjy_wsj_lvsenanguadeng.tex",
	min_spacing = 1,
}
 
)

AddRecipe2("sjy_wsj_meiqiuguai", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("spoiled_food", 2),
Ingredient("silk", 2)},
-- 科技
TECH.SCIENCE_TWO,
{
	placer = "sjy_wsj_meiqiuguai_placer",
	atlas = "images/inventoryimages/sjy_wsj_meiqiuguai.xml",
	image = "sjy_wsj_meiqiuguai.tex",
	min_spacing = 1,
}

)


AddRecipe2("sjy_wsj_meiqiutuanzi", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("spoiled_food", 2),
Ingredient("silk", 2)},
-- 科技
TECH.SCIENCE_TWO,
{
	placer = "sjy_wsj_meiqiutuanzi_placer",
	atlas = "images/inventoryimages/sjy_wsj_meiqiutuanzi.xml",
	image = "sjy_wsj_meiqiutuanzi.tex",
	min_spacing = 1,
}
 
)

AddRecipe2("sjy_wsj_nangualazhu", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("pumpkin", 3),
Ingredient("torch", 3),
Ingredient("charcoal", 3),
},
-- 科技
TECH.SCIENCE_TWO,
{
	placer = "sjy_wsj_nangualazhu_placer",
	atlas = "images/inventoryimages/sjy_wsj_nangualazhu.xml",
	image = "sjy_wsj_nangualazhu.tex",
	min_spacing = 1,
}
 
)


AddRecipe2("sjy_wsj_putongzhutai", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("cutstone", 2),
Ingredient("torch", 3),
Ingredient("charcoal", 3),
},
-- 科技
TECH.SCIENCE_TWO,
{
	placer = "sjy_wsj_putongzhutai_placer",
	atlas = "images/inventoryimages/sjy_wsj_putongzhutai.xml",
	image = "sjy_wsj_putongzhutai.tex",
	min_spacing = 1,
}
 
)


AddRecipe2("sjy_wsj_youling", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("silk", 8),
Ingredient("log", 2),
Ingredient("rope", 1),
},
-- 科技
TECH.SCIENCE_TWO,
{
	placer = "sjy_wsj_youling_placer",
	atlas = "images/inventoryimages/sjy_wsj_youling.xml",
	image = "sjy_wsj_youling.tex",
	min_spacing = 1,
}
 
)

AddRecipe2("sjy_wsj_youlings", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("silk", 8),
Ingredient("log", 2),
Ingredient("rope", 1),
},
-- 科技
TECH.SCIENCE_TWO,
{
	placer = "sjy_wsj_youlings_placer",
	atlas = "images/inventoryimages/sjy_wsj_youlings.xml",
	image = "sjy_wsj_youlings.tex",
	min_spacing = 1,
}
 
)

AddRecipe2("sjy_mianfen", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("sjy_xiaomaibean", 2,"images/inventoryimages/sjy_xiaomaibean.xml"),
},
-- 科技
TECH.SCIENCE_TWO )


-- 蔓绿翠剑
AddRecipe2("dug_sjy_xiaomai1", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("seeds", 2),
Ingredient("dug_grass", 1),
},
-- 科技
TECH.SCIENCE_TWO ,{
	-- atlas = "images/inventoryimages/sjy_book_gemstone.xml",
	-- image = "sjy_book_gemstone.tex",
	product = "dug_sjy_xiaomai",
	numtogive = 1,
})



AddRecipe2("sjy_zhuozi_table", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("boards", 10),
},
-- 科技
TECH.SCIENCE_TWO,
{
	placer = "sjy_zhuozi_table_placer",
	atlas = "images/inventoryimages/sjy_zhuozi_table.xml",
	image = "sjy_zhuozi_table.tex",
	min_spacing = 1,
}
 
)


AddRecipe2("dug_sjy_huangguabush1", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("seeds", 2),
Ingredient("berries", 5),
},
-- 科技
TECH.SCIENCE_TWO ,{
	-- atlas = "images/inventoryimages/sjy_book_gemstone.xml",
	-- image = "sjy_book_gemstone.tex",
	product = "dug_sjy_huangguabush",
	numtogive = 1,
})


AddRecipe2("sjy_wsj_limao", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("pumpkin", 1),
Ingredient("tophat", 1),
Ingredient("blueamulet", 1),
Ingredient("silk", 8),
Ingredient("purpleamulet", 1),
Ingredient("fireflies", 1),
},
-- 科技
TECH.SCIENCE_TWO )


AddRecipe2("dug_sjy_biwangwo", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("seeds", 3),
Ingredient("forgetmelots", 3),
},
-- 科技
TECH.SCIENCE_TWO)


AddRecipe2("sjy_guangzhu", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("opalpreciousgem", 5),-- 彩虹宝石
Ingredient("lightbulb", 80),-- 荧光果
Ingredient("fireflies", 40),-- 萤火虫
Ingredient("yellowamulet", 2),-- 魔光护符
Ingredient("yellowstaff", 2), --唤星魔杖
Ingredient("opalstaff", 2), --唤月魔杖
Ingredient("moonglass", 20), --月亮碎片
},
-- 科技
TECH.MAGIC_THREE )


AddRecipe2("dug_sjy_dadoubush1", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("seeds", 1),
Ingredient("acorn", 2),
},
-- 科技
TECH.SCIENCE_TWO,{
	-- atlas = "images/inventoryimages/sjy_book_gemstone.xml",
	-- image = "sjy_book_gemstone.tex",
	product = "dug_sjy_dadoubush",
	numtogive = 1,
} )

AddRecipe2("dug_sjy_dongguabush1", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("seeds", 1),
Ingredient("watermelon", 2),
},
-- 科技
TECH.SCIENCE_TWOSCIENCE_TWO,{
	-- atlas = "images/inventoryimages/sjy_book_gemstone.xml",
	-- image = "sjy_book_gemstone.tex",
	product = "dug_sjy_dongguabush",
	numtogive = 1,
} )


AddRecipe2("sjy_dongguapian", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("sjy_dongguabean", 1,"images/inventoryimages/sjy_dongguabean.xml"),
-- Ingredient("watermelon", 2),
},
-- 科技
TECH.SCIENCE_TWO,
{
	numtogive = 5,
}
 )


AddRecipe2("sjy_lvdoubean", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("sjy_dadoubean", 10,"images/inventoryimages/sjy_dadoubean.xml"),
-- Ingredient("watermelon", 2),
},
-- 科技
TECH.SCIENCE_TWO,
{
	numtogive = 10,
}
 )


AddRecipe2("sjy_huangdoubean", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("sjy_lvdoubean", 10,"images/inventoryimages/sjy_lvdoubean.xml"),
-- Ingredient("watermelon", 2),
},
-- 科技
TECH.SCIENCE_TWO,
{
	numtogive = 10,
}
 )


AddRecipe2("sjy_hongdoubean", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("sjy_huangdoubean", 10,"images/inventoryimages/sjy_huangdoubean.xml"),
-- Ingredient("watermelon", 2),
},
-- 科技
TECH.SCIENCE_TWO,
{
	numtogive = 10,
}
 )


AddRecipe2("sjy_heidoubean", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("sjy_hongdoubean", 10,"images/inventoryimages/sjy_hongdoubean.xml"),
-- Ingredient("watermelon", 2),
},
-- 科技
TECH.SCIENCE_TWO,
{
	numtogive = 10,
}
 )


AddRecipe2("sjy_jiangbingxiang1", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("boards", 3),
},
-- 科技
TECH.SCIENCE_TWO,
{
	placer = "sjy_jiangbingxiang1_placer",
	atlas = "images/inventoryimages/sjy_jiangbingxiang1.xml",
	image = "sjy_jiangbingxiang1.tex",
	min_spacing = 1,
}
 
)



AddRecipe2("sjy_wanshengjieguo", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("log", 3),
Ingredient("charcoal", 6),
Ingredient("cutstone", 3),
},
-- 科技
TECH.SCIENCE_TWO,
{
	placer = "sjy_wanshengjieguo_placer",
	atlas = "images/inventoryimages/sjy_wanshengjieguo.xml",
	image = "sjy_wanshengjieguo.tex",
	min_spacing = 1,
}
 
)

AddRecipe2("sjy_mogu_table", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("boards", 5),
Ingredient("red_cap", 3),
-- Ingredient("cutstone", 3),
},
-- 科技
TECH.SCIENCE_TWO,
{
	placer = "sjy_mogu_table_placer",
	atlas = "images/inventoryimages/sjy_mogu_table.xml",
	image = "sjy_mogu_table.tex",
	min_spacing = 1,
}
 
)


AddRecipe2("sjy_mogu2_table", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("boards", 5),
Ingredient("green_cap", 3),
-- Ingredient("cutstone", 3),
},
-- 科技
TECH.SCIENCE_TWO,
{
	placer = "sjy_mogu2_table_placer",
	atlas = "images/inventoryimages/sjy_mogu2_table.xml",
	image = "sjy_mogu2_table.tex",
	min_spacing = 1,
}
 
)



AddRecipe2("sjy_mogu3_table", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("boards", 5),
Ingredient("kelp", 3),
-- Ingredient("cutstone", 3),
},
-- 科技
TECH.SCIENCE_TWO,
{
	placer = "sjy_mogu3_table_placer",
	atlas = "images/inventoryimages/sjy_mogu3_table.xml",
	image = "sjy_mogu3_table.tex",
	min_spacing = 1,
}
 
)



AddRecipe2("sjy_mogu4_table", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("boards", 5),
Ingredient("kelp", 3),
-- Ingredient("cutstone", 3),
},
-- 科技
TECH.SCIENCE_TWO,
{
	placer = "sjy_mogu4_table_placer",
	atlas = "images/inventoryimages/sjy_mogu4_table.xml",
	image = "sjy_mogu4_table.tex",
	min_spacing = 1,
}
 
)


AddRecipe2("sjy_shigaofen", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("marble", 1),
-- Ingredient("watermelon", 2),
},
-- 科技
TECH.SCIENCE_TWO,
{
	numtogive = 3,
}
 )


AddRecipe2("sjy_heilushui", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("sjy_heidoubean", 5,"images/inventoryimages/sjy_heidoubean.xml"),
 Ingredient("spoiled_food", 1),
 Ingredient("nitre", 1),
},
-- 科技
TECH.SCIENCE_TWO,
{
	atlas = "images/inventoryimages/sjy_heilushui.xml",
	image = "sjy_heilushui.tex",
	numtogive = 5,
}
 )



AddRecipe2("sjy_choudoufu", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("sjy_shuidoufu", 2,"images/inventoryimages/sjy_shuidoufu.xml"),
 Ingredient("sjy_heilushui", 1,"images/inventoryimages/sjy_heilushui.xml"),
},
-- 科技
TECH.SCIENCE_TWO,
{
	atlas = "images/inventoryimages/sjy_choudoufu.xml",
	image = "sjy_choudoufu.tex",
	numtogive = 2,
}
 )



AddRecipe2("sjy_shouchongyangnai", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("sjy_yangnaifen", 1,"images/inventoryimages/sjy_yangnaifen.xml"),
 Ingredient("sjy_yibeizhengliushui", 15,"images/sjy_yibeizhengliushui.xml"),
},
-- 科技
TECH.SCIENCE_TWO,
{
	atlas = "images/inventoryimages/sjy_shouchongyangnai.xml",
	image = "sjy_shouchongyangnai.tex",
	numtogive = 15,
}
 )

AddRecipe2("sjy_jiangbingxiang2", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("boards", 3),
},
-- 科技
TECH.SCIENCE_TWO,
{
	placer = "sjy_jiangbingxiang2_placer",
	atlas = "images/inventoryimages/sjy_jiangbingxiang2.xml",
	image = "sjy_jiangbingxiang2.tex",
	min_spacing = 1,
}
 
)

AddRecipe2("sjy_jiangbingxiang3", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("boards", 3),
},
-- 科技
TECH.SCIENCE_TWO,
{
	placer = "sjy_jiangbingxiang3_placer",
	atlas = "images/inventoryimages/sjy_jiangbingxiang3.xml",
	image = "sjy_jiangbingxiang3.tex",
	min_spacing = 1,
}
)



AddRecipe2("sjy_gudongbi1", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("goldnugget", 4),
},
-- 科技
TECH.NONE,
{
	
	atlas = "images/inventoryimages/sjy_gudongbi.xml",
	image = "sjy_gudongbi.tex",
	product = "sjy_gudongbi",
	numtogive = 1,
}
,{"SJY_CHAOSHI"}
)


AddRecipe2("sjy_gudongbi2", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("goldnugget", 15),
},
-- 科技
TECH.NONE,
{
	
	atlas = "images/inventoryimages/sjy_gudongbi.xml",
	image = "sjy_gudongbi.tex",
	product = "sjy_gudongbi",
	numtogive = 5,
	
},
{"SJY_CHAOSHI"}
)

AddRecipe2("sjy_gudongbi3", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("goldnugget", 28),
},
-- 科技
TECH.NONE,
{
	
	atlas = "images/inventoryimages/sjy_gudongbi.xml",
	image = "sjy_gudongbi.tex",
	product = "sjy_gudongbi",
	numtogive = 10,
	
},
{"SJY_CHAOSHI"}
)



AddRecipe2("sjy_kekoukele", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("sjy_gudongbi", 2,"images/inventoryimages/sjy_gudongbi.xml"),
},
-- 科技
TECH.NONE,
{
	
	atlas = "images/inventoryimages/sjy_kekoukele.xml",
	image = "sjy_kekoukele.tex",
	product = "sjy_kekoukele",
	numtogive = 1,
	
},
{"SJY_CHAOSHI"}
)


AddRecipe2("sjy_chengzhiweifenda", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("sjy_gudongbi", 2,"images/inventoryimages/sjy_gudongbi.xml"),
},
-- 科技
TECH.NONE,
{
	
	atlas = "images/inventoryimages/sjy_chengzhiweifenda.xml",
	image = "sjy_chengzhiweifenda.tex",
	product = "sjy_chengzhiweifenda",
	numtogive = 1,
	
},
{"SJY_CHAOSHI"}
)

AddRecipe2("sjy_caomeiweimeinianda", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("sjy_gudongbi", 2,"images/inventoryimages/sjy_gudongbi.xml"),
},
-- 科技
TECH.NONE,
{
	
	atlas = "images/inventoryimages/sjy_caomeiweimeinianda.xml",
	image = "sjy_caomeiweimeinianda.tex",
	product = "sjy_caomeiweimeinianda",
	numtogive = 1,
	
},
{"SJY_CHAOSHI"}
)

AddRecipe2("sjy_xuebi", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("sjy_gudongbi", 2,"images/inventoryimages/sjy_gudongbi.xml"),
},
-- 科技
TECH.NONE,
{
	
	atlas = "images/inventoryimages/sjy_xuebi.xml",
	image = "sjy_xuebi.tex",
	product = "sjy_xuebi",
	numtogive = 1,
	
},
{"SJY_CHAOSHI"}
)

AddRecipe2("sjy_boluopi", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("sjy_gudongbi", 2,"images/inventoryimages/sjy_gudongbi.xml"),
},
-- 科技
TECH.NONE,
{
	
	atlas = "images/inventoryimages/sjy_boluopi.xml",
	image = "sjy_boluopi.tex",
	product = "sjy_boluopi",
	numtogive = 1,
	
},
{"SJY_CHAOSHI"}
)


AddRecipe2("sjy_yuanweishupian", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("sjy_gudongbi", 2,"images/inventoryimages/sjy_gudongbi.xml"),
},
-- 科技
TECH.NONE,
{
	
	atlas = "images/inventoryimages/sjy_yuanweishupian.xml",
	image = "sjy_yuanweishupian.tex",
	product = "sjy_yuanweishupian",
	numtogive = 1,
	
},
{"SJY_CHAOSHI"}
)


AddRecipe2("sjy_huangguaweishupian", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("sjy_gudongbi", 2,"images/inventoryimages/sjy_gudongbi.xml"),
},
-- 科技
TECH.NONE,
{
	
	atlas = "images/inventoryimages/sjy_huangguaweishupian.xml",
	image = "sjy_huangguaweishupian.tex",
	product = "sjy_huangguaweishupian",
	numtogive = 1,
	
},
{"SJY_CHAOSHI"}
)

AddRecipe2("sjy_fanqieweishupian", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("sjy_gudongbi", 2,"images/inventoryimages/sjy_gudongbi.xml"),
},
-- 科技
TECH.NONE,
{
	
	atlas = "images/inventoryimages/sjy_fanqieweishupian.xml",
	image = "sjy_fanqieweishupian.tex",
	product = "sjy_fanqieweishupian",
	numtogive = 1,
	
},
{"SJY_CHAOSHI"}
)


AddRecipe2("sjy_ningmengweishupian", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("sjy_gudongbi", 2,"images/inventoryimages/sjy_gudongbi.xml"),
},
-- 科技
TECH.NONE,
{
	
	atlas = "images/inventoryimages/sjy_ningmengweishupian.xml",
	image = "sjy_ningmengweishupian.tex",
	product = "sjy_ningmengweishupian",
	numtogive = 1,
	
},
{"SJY_CHAOSHI"}
)

AddRecipe2("sjy_molihuacha", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("sjy_gudongbi", 2,"images/inventoryimages/sjy_gudongbi.xml"),
},
-- 科技
TECH.NONE,
{
	
	atlas = "images/inventoryimages/sjy_molihuacha.xml",
	image = "sjy_molihuacha.tex",
	product = "sjy_molihuacha",
	numtogive = 1,
	
},
{"SJY_CHAOSHI"}
)

AddRecipe2("sjy_lvcha", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("sjy_gudongbi", 2,"images/inventoryimages/sjy_gudongbi.xml"),
},
-- 科技
TECH.NONE,
{
	
	atlas = "images/inventoryimages/sjy_lvcha.xml",
	image = "sjy_lvcha.tex",
	product = "sjy_lvcha",
	numtogive = 1,
	
},
{"SJY_CHAOSHI"}
)


AddRecipe2("sjy_cocokele", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("sjy_gudongbi", 2,"images/inventoryimages/sjy_gudongbi.xml"),
},
-- 科技
TECH.NONE,
{
	
	atlas = "images/inventoryimages/sjy_cocokele.xml",
	image = "sjy_cocokele.tex",
	product = "sjy_cocokele",
	numtogive = 1,
	
},
{"SJY_CHAOSHI"}
)


AddRecipe2("sjy_xbi", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("sjy_gudongbi", 2,"images/inventoryimages/sjy_gudongbi.xml"),
},
-- 科技
TECH.NONE,
{
	
	atlas = "images/inventoryimages/sjy_xbi.xml",
	image = "sjy_xbi.tex",
	product = "sjy_xbi",
	numtogive = 1,
	
},
{"SJY_CHAOSHI"}
)

AddRecipe2("sjy_chengzhiweimeinianda", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("sjy_gudongbi", 2,"images/inventoryimages/sjy_gudongbi.xml"),
},
-- 科技
TECH.NONE,
{
	
	atlas = "images/inventoryimages/sjy_chengzhiweimeinianda.xml",
	image = "sjy_chengzhiweimeinianda.tex",
	product = "sjy_chengzhiweimeinianda",
	numtogive = 1,
	
},
{"SJY_CHAOSHI"}
)

AddRecipe2("sjy_putaoweimeinianda", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("sjy_gudongbi", 2,"images/inventoryimages/sjy_gudongbi.xml"),
},
-- 科技
TECH.NONE,
{
	
	atlas = "images/inventoryimages/sjy_putaoweimeinianda.xml",
	image = "sjy_putaoweimeinianda.tex",
	product = "sjy_putaoweimeinianda",
	numtogive = 1,
	
},
{"SJY_CHAOSHI"}
)


AddRecipe2("sjy_pingguoweimeinianda", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("sjy_gudongbi", 2,"images/inventoryimages/sjy_gudongbi.xml"),
},
-- 科技
TECH.NONE,
{
	
	atlas = "images/inventoryimages/sjy_pingguoweimeinianda.xml",
	image = "sjy_pingguoweimeinianda.tex",
	product = "sjy_pingguoweimeinianda",
	numtogive = 1,
	
},
{"SJY_CHAOSHI"}
)


AddRecipe2("sjy_ningmengweifenda", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("sjy_gudongbi", 2,"images/inventoryimages/sjy_gudongbi.xml"),
},
-- 科技
TECH.NONE,
{
	
	atlas = "images/inventoryimages/sjy_ningmengweifenda.xml",
	image = "sjy_ningmengweifenda.tex",
	product = "sjy_ningmengweifenda",
	numtogive = 1,
	
},
{"SJY_CHAOSHI"}
)


AddRecipe2("sjy_putongpijiu", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("sjy_gudongbi", 3,"images/inventoryimages/sjy_gudongbi.xml"),
},
-- 科技
TECH.NONE,
{
	
	atlas = "images/inventoryimages/sjy_putongpijiu.xml",
	image = "sjy_putongpijiu.tex",
	product = "sjy_putongpijiu",
	numtogive = 1,
	
},
{"SJY_CHAOSHI"}
)


AddRecipe2("sjy_yanjinpijiu", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("sjy_gudongbi", 4,"images/inventoryimages/sjy_gudongbi.xml"),
},
-- 科技
TECH.NONE,
{
	
	atlas = "images/inventoryimages/sjy_yanjinpijiu.xml",
	image = "sjy_yanjinpijiu.tex",
	product = "sjy_yanjinpijiu",
	numtogive = 1,
	
},
{"SJY_CHAOSHI"}
)

AddRecipe2("sjy_hongjiu", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("sjy_gudongbi", 5,"images/inventoryimages/sjy_gudongbi.xml"),
},
-- 科技
TECH.NONE,
{
	
	atlas = "images/inventoryimages/sjy_hongjiu.xml",
	image = "sjy_hongjiu.tex",
	product = "sjy_hongjiu",
	numtogive = 1,
	
},
{"SJY_CHAOSHI"}
)

AddRecipe2("sjy_jiangyou", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("sjy_gudongbi", 1,"images/inventoryimages/sjy_gudongbi.xml"),
},
-- 科技
TECH.NONE,
{
	
	atlas = "images/inventoryimages/sjy_jiangyou.xml",
	image = "sjy_jiangyou.tex",
	product = "sjy_jiangyou",
	numtogive = 1,
	
},
{"SJY_CHAOSHI"}
)

AddRecipe2("sjy_zhiwushiyongyou", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("sjy_gudongbi", 1,"images/inventoryimages/sjy_gudongbi.xml"),
},
-- 科技
TECH.NONE,
{
	
	atlas = "images/inventoryimages/sjy_zhiwushiyongyou.xml",
	image = "sjy_zhiwushiyongyou.tex",
	product = "sjy_zhiwushiyongyou",
	numtogive = 1,
	
},
{"SJY_CHAOSHI"}
)


AddRecipe2("sjy_linzhus", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("sjy_gudongbi", 1000,"images/inventoryimages/sjy_gudongbi.xml"),
},
-- 科技
TECH.NONE,
{
	
	atlas = "images/inventoryimages/sjy_linzhus.xml",
	image = "sjy_linzhus.tex",
	product = "sjy_linzhus",
	numtogive = 1,
	
},
{"SJY_CHAOSHI"}
)


AddRecipe2("sjy_dami", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("sjy_guzi", 5,"images/inventoryimages/sjy_guzi.xml"),
},
-- 科技
TECH.NONE,
{
	
	atlas = "images/inventoryimages/sjy_dami.xml",
	image = "sjy_dami.tex",
	product = "sjy_dami",
	numtogive = 5,
	
}
)


AddRecipe2("dug_sjy_shuidaobush1", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("seeds", 5),
},
-- 科技
TECH.NONE,
{
	
	atlas = "images/inventoryimages/dug_sjy_shuidaobush.xml",
	image = "dug_sjy_shuidaobush.tex",
	product = "dug_sjy_shuidaobush",
	numtogive = 2,
	
}
)


AddRecipe2("dug_sjy_boluobush1", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("seeds", 5),
Ingredient("acorn", 2),
},
-- 科技
TECH.NONE,
{
	
	atlas = "images/inventoryimages/dug_sjy_boluobush.xml",
	image = "dug_sjy_boluobush.tex",
	product = "dug_sjy_boluobush",
	numtogive = 2,
	
}
)


AddRecipe2("sjy_shuiqiuji", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("gears", 1),
Ingredient("waterballoon", 5),
Ingredient("transistor", 2),
-- Ingredient("charcoal", 3),
-- Ingredient("silk", 2),
},
-- 科技
TECH.SCIENCE_TWO,
{
	placer = "sjy_shuiqiuji_placer",
	atlas = "images/inventoryimages/sjy_shuiqiuji.xml",
	image = "sjy_shuiqiuji.tex",
	min_spacing = 1,
}
 
)

AddRecipe2("sjy_chitang", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("pondeel", 5),
Ingredient("wobster_sheller_land", 3),
Ingredient("shovel", 1),
},
-- 科技
TECH.SCIENCE_TWO,
{
	placer = "sjy_chitang_placer",
	atlas = "images/inventoryimages/sjy_chitang.xml",
	image = "sjy_chitang.tex",
	-- product = "dug_sjy_boluobush",
	numtogive = 1,
	
}
)


AddRecipe2("sjy_book_birds", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("papyrus", 2),
 Ingredient("bird_egg", 2),
 Ingredient("book_birds", 1),
},
-- 科技
TECH.SCIENCE_TWO,
{
	atlas = "images/inventoryimages/sjy_book_birds.xml",
	image = "sjy_book_birds.tex",
	numtogive = 1,
}
 )



 AddRecipe2("sjy_book_devour", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("papyrus", 2),
 Ingredient("nightmarefuel", 2),
 Ingredient("waxwelljournal", 1),
},
-- 科技
TECH.SCIENCE_TWO,
{
	atlas = "images/inventoryimages/sjy_book_devour.xml",
	image = "sjy_book_devour.tex",
	numtogive = 1,
}
 )



  AddRecipe2("sjy_book_ikea_guidebook", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("papyrus", 2),
 Ingredient("livinglog", 2),
 Ingredient("telestaff", 1),
},
-- 科技
TECH.SCIENCE_TWO,
{
	atlas = "images/inventoryimages/sjy_book_ikea_guidebook.xml",
	image = "sjy_book_ikea_guidebook.tex",
	numtogive = 1,
}
 )



   AddRecipe2("sjy_book_gemstone", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("papyrus", 2),
 Ingredient("rocks", 2),
 Ingredient("opalpreciousgem", 1),
},
-- 科技
TECH.SCIENCE_TWO,
{
	atlas = "images/inventoryimages/sjy_book_gemstone.xml",
	image = "sjy_book_gemstone.tex",
	numtogive = 1,
}
 )





    AddRecipe2("seeds1", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("poop", 5),
--  Ingredient("rocks", 2),
--  Ingredient("opalpreciousgem", 1),
},
-- 科技
TECH.SCIENCE_TWO,
{
	-- atlas = "images/inventoryimages/sjy_book_gemstone.xml",
	-- image = "sjy_book_gemstone.tex",
	product = "seeds",
	numtogive = 1,
}
 )




     AddRecipe2("seeds2", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("guano", 1),
--  Ingredient("rocks", 2),
--  Ingredient("opalpreciousgem", 1),
},
-- 科技
TECH.SCIENCE_TWO,
{
	-- atlas = "images/inventoryimages/sjy_book_gemstone.xml",
	-- image = "sjy_book_gemstone.tex",
	product = "seeds",
	numtogive = 1,
}
 )


 
      AddRecipe2("gears", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("wagpunk_bits", 1),
 Ingredient("transistor", 2),
--  Ingredient("opalpreciousgem", 1),
},
-- 科技
TECH.SCIENCE_TWO,
{
	-- atlas = "images/inventoryimages/sjy_book_gemstone.xml",
	-- image = "sjy_book_gemstone.tex",
	numtogive = 1,
}
 )



 AddRecipe2("dug_sjy_dadoubush", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("sjy_dadoubean", 1,"images/inventoryimages/sjy_dadoubean.xml"),
Ingredient("seeds", 1),
},
-- 科技
TECH.NONE,
{
	
	atlas = "images/inventoryimages/dug_sjy_dadoubush.xml",
	image = "dug_sjy_dadoubush.tex",
	product = "dug_sjy_dadoubush",
	numtogive = 1,
	
}
)


 AddRecipe2("dug_sjy_dongguabush", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("sjy_dongguabean", 1,"images/inventoryimages/sjy_dongguabean.xml"),
Ingredient("seeds", 1),
},
-- 科技
TECH.NONE,
{
	
	atlas = "images/inventoryimages/dug_sjy_dongguabush.xml",
	image = "dug_sjy_dongguabush.tex",
	product = "dug_sjy_dongguabush",
	numtogive = 1,
	
}
)

 AddRecipe2("dug_caomeibush", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("caomeibean", 1,"images/inventoryimages/caomeibean.xml"),
Ingredient("seeds", 1),
},
-- 科技
TECH.NONE,
{
	
	atlas = "images/inventoryimages/dug_caomeibush.xml",
	image = "dug_caomeibush.tex",
	product = "dug_caomeibush",
	numtogive = 1,
	
}
)



 AddRecipe2("dug_lanmeibush", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("lanmeibean", 1,"images/inventoryimages/lanmeibean.xml"),
Ingredient("seeds", 1),
},
-- 科技
TECH.NONE,
{
	
	atlas = "images/inventoryimages/dug_lanmeibush.xml",
	image = "dug_lanmeibush.tex",
	product = "dug_lanmeibush",
	numtogive = 1,
	
}
)



 AddRecipe2("dug_jiucai", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("jiucaihua", 1,"images/inventoryimages/jiucaihua.xml"),
Ingredient("seeds", 1),
},
-- 科技
TECH.NONE,
{
	
	atlas = "images/inventoryimages/dug_jiucai.xml",
	image = "dug_jiucai.tex",
	product = "dug_jiucai",
	numtogive = 1,
	
}
)



 AddRecipe2("dug_banlibush", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("banlibean1", 1,"images/inventoryimages/banlibean1.xml"),
Ingredient("seeds", 1),
},
-- 科技
TECH.NONE,
{
	
	atlas = "images/inventoryimages/dug_banlibush.xml",
	image = "dug_banlibush.tex",
	product = "dug_banlibush",
	numtogive = 1,
	
}
)



 AddRecipe2("dug_sjy_xiaomai", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("sjy_xiaomaibean", 1,"images/inventoryimages/sjy_xiaomaibean.xml"),
Ingredient("seeds", 1),
},
-- 科技
TECH.NONE,
{
	
	atlas = "images/inventoryimages/dug_sjy_xiaomai.xml",
	image = "dug_sjy_xiaomai.tex",
	product = "dug_sjy_xiaomai",
	numtogive = 1,
	
}
)



 AddRecipe2("dug_sjy_huangguabush", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("sjy_huangguabean", 1,"images/inventoryimages/sjy_huangguabean.xml"),
Ingredient("seeds", 1),
},
-- 科技
TECH.NONE,
{
	
	atlas = "images/inventoryimages/dug_sjy_huangguabush.xml",
	image = "dug_sjy_huangguabush.tex",
	product = "dug_sjy_huangguabush",
	numtogive = 1,
	
}
)


 AddRecipe2("dug_sjy_boluobush", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("sjy_boluobean", 1,"images/inventoryimages/sjy_boluobean.xml"),
Ingredient("seeds", 1),
},
-- 科技
TECH.NONE,
{
	
	atlas = "images/inventoryimages/dug_sjy_boluobush.xml",
	image = "dug_sjy_boluobush.tex",
	product = "dug_sjy_boluobush",
	numtogive = 1,
	
}
)



 AddRecipe2("dug_sjy_shuidaobush", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("sjy_guzi", 1,"images/inventoryimages/sjy_guzi.xml"),
Ingredient("seeds", 1),
},
-- 科技
TECH.NONE,
{
	
	atlas = "images/inventoryimages/dug_sjy_shuidaobush.xml",
	image = "dug_sjy_shuidaobush.tex",
	product = "dug_sjy_shuidaobush",
	numtogive = 1,
	
}
)




AddRecipe2("ice", --要制作的物品名称？
-- 材料名称					数量				图片路径
{Ingredient("snowball_item",2),
--  Ingredient("transistor", 2),
--  Ingredient("opalpreciousgem", 1),
},
-- 科技
TECH.NONE,
{
	-- atlas = "images/inventoryimages/sjy_book_gemstone.xml",
	-- image = "sjy_book_gemstone.tex",
	numtogive = 1,
}
 )