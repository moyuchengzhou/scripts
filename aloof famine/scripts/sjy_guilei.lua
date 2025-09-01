--专属科技栏

GLOBAL.setmetatable(env,{__index = function(t, k)return GLOBAL.rawget(GLOBAL,k)end,})

-- Asset("ANIM", "anim/sjy_yudoufu.zip")
-- Asset("IMAGE", "images/inventoryimages/sjy.tex")
-- Asset("ATLAS", "images/inventoryimages/sjy.xml")
-- table.insert(Assets, Asset( "IMAGE", "images/inventoryimages/sjy.tex" ))
-- table.insert(Assets, Asset( "ATLAS", "images/inventoryimages/sjy.xml" ))

Assets = {
                Asset("IMAGE", "images/inventoryimages/sjy.tex"),
                Asset("ATLAS", "images/inventoryimages/sjy.xml"),
                Asset("IMAGE", "images/inventoryimages/sjy_changpian.tex"),
                Asset("ATLAS", "images/inventoryimages/sjy_changpian.xml"),
                Asset("IMAGE", "images/inventoryimages/sjy_zhiwu.tex"),
                Asset("ATLAS", "images/inventoryimages/sjy_zhiwu.xml"),
                Asset("IMAGE", "images/inventoryimages/sjy_jiagong.tex"),
                Asset("ATLAS", "images/inventoryimages/sjy_jiagong.xml"),
                Asset("IMAGE", "images/inventoryimages/sjy_jiaju.tex"),
                Asset("ATLAS", "images/inventoryimages/sjy_jiaju.xml"),
                Asset("IMAGE", "images/inventoryimages/sjy_chaoshi.tex"),
                Asset("ATLAS", "images/inventoryimages/sjy_chaoshi.xml"),
            }


local SJY =   --这里可以随便改,和下面AddRecipeFilter函数里面一样就行
{
   name = "SJY",     --要求英文大写
   atlas = "images/inventoryimages/sjy.xml",     --图标,64*64像素,背景虚化
   image = "sjy.tex",

}
AddRecipeFilter(SJY)                       --官方接口,添加合成表新分类


STRINGS.UI.CRAFTING_FILTERS.SJY = "食纪元道具栏"       --科技栏名称   移至chinese.lua里面







-- 食纪元唱片
local SJY_CHANGPIAN =   --这里可以随便改,和下面AddRecipeFilter函数里面一样就行
{
name = "SJY_CHANGPIAN",     --要求英文大写
atlas = "images/inventoryimages/sjy_changpian.xml",     --图标,64*64像素,背景虚化
image = "sjy_changpian.tex",

}
AddRecipeFilter(SJY_CHANGPIAN)                       --官方接口,添加合成表新分类

STRINGS.UI.CRAFTING_FILTERS.SJY_CHANGPIAN = "食纪元唱片"  






-- 食纪元植物  sjy_zhiwu
local SJY_ZHIWU =   --这里可以随便改,和下面AddRecipeFilter函数里面一样就行
{
name = "SJY_ZHIWU",     --要求英文大写
atlas = "images/inventoryimages/sjy_zhiwu.xml",     --图标,64*64像素,背景虚化
image = "sjy_zhiwu.tex",

}
AddRecipeFilter(SJY_ZHIWU)                       --官方接口,添加合成表新分类

STRINGS.UI.CRAFTING_FILTERS.SJY_ZHIWU = "食纪元植物栏"  







-- 食纪元加工栏 sjy_jiagong

local SJY_JIAGONG =   --这里可以随便改,和下面AddRecipeFilter函数里面一样就行
{
name = "SJY_JIAGONG",     --要求英文大写
atlas = "images/inventoryimages/sjy_jiagong.xml",     --图标,64*64像素,背景虚化
image = "sjy_jiagong.tex",

}
AddRecipeFilter(SJY_JIAGONG)                       --官方接口,添加合成表新分类

STRINGS.UI.CRAFTING_FILTERS.SJY_JIAGONG = "食纪元加工栏"

-- 食纪元家具栏

-- sjy_jiaju

local SJY_JIAJU =   --这里可以随便改,和下面AddRecipeFilter函数里面一样就行
{
name = "SJY_JIAJU",     --要求英文大写
atlas = "images/inventoryimages/sjy_jiaju.xml",     --图标,64*64像素,背景虚化
image = "sjy_jiaju.tex",

}
AddRecipeFilter(SJY_JIAJU)                       --官方接口,添加合成表新分类

STRINGS.UI.CRAFTING_FILTERS.SJY_JIAJU = "食纪元家具栏"

-- sjy_chaoshi

-- 食纪元超市栏

-- sjy_jiaju

local SJY_CHAOSHI =   --这里可以随便改,和下面AddRecipeFilter函数里面一样就行
{
name = "SJY_CHAOSHI",     --要求英文大写
atlas = "images/inventoryimages/sjy_chaoshi.xml",     --图标,64*64像素,背景虚化
image = "sjy_chaoshi.tex",

}
AddRecipeFilter(SJY_CHAOSHI)                       --官方接口,添加合成表新分类

STRINGS.UI.CRAFTING_FILTERS.SJY_CHAOSHI = "食纪元超市栏"

AddRecipeToFilter("jian","SJY")     
AddRecipeToFilter("jinhuafazhang","SJY") 
AddRecipeToFilter("packim_fishbone","SJY") 
AddRecipeToFilter("sjy_milufazhang","SJY") 
AddRecipeToFilter("sjy_wlcj","SJY") 
AddRecipeToFilter("sjy_zrzn","SJY") 
AddRecipeToFilter("sjy_wsj_limao","SJY") 
AddRecipeToFilter("sjy_guangzhu","SJY") 
AddRecipeToFilter("sjy_book_birds","SJY") 
AddRecipeToFilter("sjy_book_devour","SJY") 
AddRecipeToFilter("sjy_book_ikea_guidebook","SJY") 
AddRecipeToFilter("sjy_book_gemstone","SJY") 
AddRecipeToFilter("gears","SJY") 
-- AddRecipeToFilter("wwhmgqb_changpian","SJY") 
-- AddRecipeToFilter("wwhmgqb_changpian","SJY") 
-- AddRecipeToFilter("wwhmgqb_changpian","SJY") 
-- AddRecipeToFilter("wwhmgqb_changpian","SJY") 
-- AddRecipeToFilter("wwhmgqb_changpian","SJY") 
-- AddRecipeToFilter("wwhmgqb_changpian","SJY") 
-- AddRecipeToFilter("wwhmgqb_changpian","SJY") 
-- AddRecipeToFilter("wwhmgqb_changpian","SJY") 


-- 食纪元唱片栏
 
AddRecipeToFilter("xlg_changpian","SJY_CHANGPIAN") 
AddRecipeToFilter("crsjbb_changpian","SJY_CHANGPIAN") 
AddRecipeToFilter("fen_changpian","SJY_CHANGPIAN") 
AddRecipeToFilter("myjmdqt_1_changpian","SJY_CHANGPIAN") 
AddRecipeToFilter("myjmdqt_2_changpian","SJY_CHANGPIAN") 
AddRecipeToFilter("myjmdqt_3_changpian","SJY_CHANGPIAN") 
AddRecipeToFilter("sjy_huangjiamengwei","SJY_CHANGPIAN") 
-- AddRecipeToFilter("wwhmgqb_changpian","SJY_CHANGPIAN") 
-- AddRecipeToFilter("wwhmgqb_changpian","SJY_CHANGPIAN") 
AddRecipeToFilter("qby_changpian","SJY_CHANGPIAN") 
AddRecipeToFilter("smsnjlb_changpian","SJY_CHANGPIAN") 
AddRecipeToFilter("srkl_changpian","SJY_CHANGPIAN") 
AddRecipeToFilter("wwhls_changpian","SJY_CHANGPIAN") 
AddRecipeToFilter("wwhmbyhb_changpian","SJY_CHANGPIAN") 
AddRecipeToFilter("xhbkj_changpian","SJY_CHANGPIAN") 
AddRecipeToFilter("xl_changpian","SJY_CHANGPIAN") 
AddRecipeToFilter("xrfl_changpian","SJY_CHANGPIAN") 
AddRecipeToFilter("xrwhj_changpian","SJY_CHANGPIAN") 
AddRecipeToFilter("zhyw_changpian","SJY_CHANGPIAN") 
AddRecipeToFilter("wwhmgqb_changpian","SJY_CHANGPIAN") 


-- 食纪元植物栏
AddRecipeToFilter("dug_sjy_dadoubush","SJY_ZHIWU")
AddRecipeToFilter("dug_sjy_dadoubush1","SJY_ZHIWU") 
AddRecipeToFilter("dug_sjy_dongguabush","SJY_ZHIWU") 
AddRecipeToFilter("dug_sjy_dongguabush1","SJY_ZHIWU") 
AddRecipeToFilter("dug_caomeibush","SJY_ZHIWU") 
AddRecipeToFilter("dug_caomeibush1","SJY_ZHIWU") 
AddRecipeToFilter("dug_lanmeibush","SJY_ZHIWU") 
AddRecipeToFilter("dug_lanmeibush1","SJY_ZHIWU") 
AddRecipeToFilter("dug_jiucai","SJY_ZHIWU") 
AddRecipeToFilter("dug_jiucai1","SJY_ZHIWU") 
AddRecipeToFilter("dug_banlibush","SJY_ZHIWU") 
AddRecipeToFilter("dug_banlibush1","SJY_ZHIWU") 
AddRecipeToFilter("dug_sjy_xiaomai","SJY_ZHIWU") 
AddRecipeToFilter("dug_sjy_xiaomai1","SJY_ZHIWU") 
AddRecipeToFilter("dug_sjy_huangguabush","SJY_ZHIWU") 
AddRecipeToFilter("dug_sjy_huangguabush1","SJY_ZHIWU") 
AddRecipeToFilter("dug_sjy_biwangwo","SJY_ZHIWU") 
AddRecipeToFilter("dug_sjy_boluobush","SJY_ZHIWU") 
AddRecipeToFilter("dug_sjy_boluobush1","SJY_ZHIWU") 
AddRecipeToFilter("dug_sjy_shuidaobush","SJY_ZHIWU") 
AddRecipeToFilter("dug_sjy_shuidaobush1","SJY_ZHIWU")
AddRecipeToFilter("seeds1","SJY_ZHIWU") 
AddRecipeToFilter("seeds2","SJY_ZHIWU") 


-- 食纪元加工栏
-- 食纪元 食纪元 食纪元 食纪元 食纪元 食纪元 食纪元 食纪元
AddRecipeToFilter("butter","SJY_JIAGONG") 
AddRecipeToFilter("sjy_mianfen","SJY_JIAGONG") 
AddRecipeToFilter("sjy_dongguapian","SJY_JIAGONG") 
AddRecipeToFilter("sjy_lvdoubean","SJY_JIAGONG") 
AddRecipeToFilter("sjy_huangdoubean","SJY_JIAGONG") 
AddRecipeToFilter("sjy_hongdoubean","SJY_JIAGONG") 
AddRecipeToFilter("sjy_heidoubean","SJY_JIAGONG") 
AddRecipeToFilter("sjy_shigaofen","SJY_JIAGONG") 
AddRecipeToFilter("sjy_choudoufu","SJY_JIAGONG") 
AddRecipeToFilter("sjy_shouchongyangnai","SJY_JIAGONG") 
AddRecipeToFilter("sjy_heilushui","SJY_JIAGONG") 
AddRecipeToFilter("sjy_dami","SJY_JIAGONG") 
AddRecipeToFilter("ice","SJY_JIAGONG") 
-- AddRecipeToFilter("ice","SJY_JIAGONG") 
-- AddRecipeToFilter("gears","SJY_JIAGONG") 
-- AddRecipeToFilter("sjy_dongguapian","SJY_JIAGONG") 





-- 食纪元家具栏
AddRecipeToFilter("sjy_wsj_meiqiuguai2","SJY_JIAJU") 
AddRecipeToFilter("sjy_bianfuzhutai","SJY_JIAJU") 
AddRecipeToFilter("sjy_daodangui","SJY_JIAJU") 
AddRecipeToFilter("sjy_huangsenanguadeng","SJY_JIAJU") 
AddRecipeToFilter("sjy_wsj_lazhunangua","SJY_JIAJU") 
AddRecipeToFilter("sjy_wsj_lvsenanguadeng","SJY_JIAJU") 
AddRecipeToFilter("sjy_wsj_meiqiuguai","SJY_JIAJU") 
AddRecipeToFilter("sjy_wsj_meiqiutuanzi","SJY_JIAJU") 
AddRecipeToFilter("sjy_wsj_nangualazhu","SJY_JIAJU") 
AddRecipeToFilter("sjy_wsj_putongzhutai","SJY_JIAJU") 
AddRecipeToFilter("sjy_wsj_youling","SJY_JIAJU") 
AddRecipeToFilter("sjy_wsj_youlings","SJY_JIAJU") 
AddRecipeToFilter("sjy_zhuozi_table","SJY_JIAJU") 
AddRecipeToFilter("sjy_jiangbingxiang1","SJY_JIAJU") 
AddRecipeToFilter("changpianji","SJY_JIAJU")
AddRecipeToFilter("sjy_wanshengjieguo","SJY_JIAJU")
AddRecipeToFilter("sjy_mogu_table","SJY_JIAJU") 
AddRecipeToFilter("sjy_mogu2_table","SJY_JIAJU") 
AddRecipeToFilter("sjy_mogu3_table","SJY_JIAJU")
AddRecipeToFilter("sjy_mogu4_table","SJY_JIAJU")
AddRecipeToFilter("sjy_jiangbingxiang2","SJY_JIAJU")
AddRecipeToFilter("sjy_jiangbingxiang3","SJY_JIAJU")
AddRecipeToFilter("sjy_shuiqiuji","SJY_JIAJU")
AddRecipeToFilter("sjy_chitang","SJY_JIAJU")






-- 食纪元超市栏
AddRecipeToFilter("sjy_gudongbi1","SJY_CHAOSHI") 
AddRecipeToFilter("sjy_gudongbi2","SJY_CHAOSHI") 
AddRecipeToFilter("sjy_gudongbi3","SJY_CHAOSHI") 
AddRecipeToFilter("sjy_kekoukele","SJY_CHAOSHI") 
AddRecipeToFilter("sjy_chengzhiweifenda","SJY_CHAOSHI") 
AddRecipeToFilter("sjy_caomeiweimeinianda","SJY_CHAOSHI") 
AddRecipeToFilter("sjy_xuebi","SJY_CHAOSHI") 
AddRecipeToFilter("sjy_boluopi","SJY_CHAOSHI") 
AddRecipeToFilter("sjy_yuanweishupian","SJY_CHAOSHI") 
AddRecipeToFilter("sjy_huangguaweishupian","SJY_CHAOSHI") 
AddRecipeToFilter("sjy_fanqieweishupian","SJY_CHAOSHI") 
AddRecipeToFilter("sjy_ningmengweishupian","SJY_CHAOSHI") 
AddRecipeToFilter("sjy_molihuacha","SJY_CHAOSHI") 
AddRecipeToFilter("sjy_lvcha","SJY_CHAOSHI") 
AddRecipeToFilter("sjy_cocokele","SJY_CHAOSHI") 
AddRecipeToFilter("sjy_xbi","SJY_CHAOSHI") 
AddRecipeToFilter("sjy_chengzhiweimeinianda","SJY_CHAOSHI") 
AddRecipeToFilter("sjy_putaoweimeinianda","SJY_CHAOSHI") 
AddRecipeToFilter("sjy_pingguoweimeinianda","SJY_CHAOSHI") 
AddRecipeToFilter("sjy_ningmengweifenda","SJY_CHAOSHI") 
AddRecipeToFilter("sjy_putongpijiu","SJY_CHAOSHI") 
AddRecipeToFilter("sjy_yanjinpijiu","SJY_CHAOSHI") 
AddRecipeToFilter("sjy_hongjiu","SJY_CHAOSHI") 
AddRecipeToFilter("sjy_linzhus","SJY_CHAOSHI") 
AddRecipeToFilter("sjy_jiangyou","SJY_CHAOSHI") 
AddRecipeToFilter("sjy_zhiwushiyongyou","SJY_CHAOSHI") 
-- AddRecipeToFilter("sjy_xuebi","SJY_CHAOSHI") 
-- AddRecipeToFilter("sjy_boluopi","SJY_CHAOSHI") 
-- AddRecipeToFilter("sjy_yuanweishupian","SJY_CHAOSHI") 
-- AddRecipeToFilter("sjy_huangguaweishupian","SJY_CHAOSHI") 
-- AddRecipeToFilter("sjy_fanqieweishupian","SJY_CHAOSHI") 
-- AddRecipeToFilter("sjy_ningmengweishupian","SJY_CHAOSHI") 
-- AddRecipeToFilter("sjy_molihuacha","SJY_CHAOSHI") 
-- AddRecipeToFilter("sjy_lvcha","SJY_CHAOSHI") 
-- AddRecipeToFilter("sjy_cocokele","SJY_CHAOSHI") 
-- AddRecipeToFilter("sjy_xbi","SJY_CHAOSHI") 
-- AddRecipeToFilter("sjy_chengzhiweimeinianda","SJY_CHAOSHI") 
-- AddRecipeToFilter("sjy_putaoweimeinianda","SJY_CHAOSHI") 
-- AddRecipeToFilter("sjy_pingguoweimeinianda","SJY_CHAOSHI") 
-- AddRecipeToFilter("sjy_putongpijiu","SJY_CHAOSHI") 































































































--把缘之书配方加入到科技栏中
--RemoveRecipeFromFilter("yuanmeng_book","PROTOTYPERS")     --把缘之书配方从科技栏中移除

-- --花盏科技栏,离开就消失科技栏的那种,类似于天体灵球
-- AddPrototyperDef("yuanmeng_huazhan_copy", { --第一个参数是指玩家靠近时会解锁科技的prefab名
-- 	icon_atlas = "images/inventoryimages/yuanmeng_huazhan_fil.xml",
--    icon_image = "yuanmeng_huazhan_fil.tex",
-- 	is_crafting_station = true,
-- 	action_str = "YUANMENGHUAZHAN", --台词已在语言文件中
-- 	filter_text = "花盏" --台词已在语言文件中
-- })

-- AddPrototyperDef("yuanmeng_huazhan", { --第一个参数是指玩家靠近时会解锁科技的prefab名
-- 	icon_atlas = "images/filter/yuanmeng_huazhan_fil.xml",
--    icon_image = "yuanmeng_huazhan_fil.tex",
-- 	is_crafting_station = true,
-- 	action_str = "YUANMENGHUAZHAN", --台词已在语言文件中
-- 	filter_text = "花盏" --台词已在语言文件中
-- })
-- local YUANMENG_HUAZHAN_FILTER =
-- {
-- 	name = "YUANMENGHUAZHAN",
-- 	atlas =  "images/filter/yuanmeng_huazhan_fil.xml",
--    image = "yuanmeng_huazhan_fil.tex",
--    image_size = 64,
-- 	custom_pos = true ,
-- }
-- AddRecipeFilter(YUANMENG_HUAZHAN_FILTER, 1)


-- return Prefab( assets)