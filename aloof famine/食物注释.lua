
local fruits = {"pomegranate", "dragonfruit", "cave_banana"}                    --石榴、火龙果、香蕉
AddIngredientValues(fruits, {fruit=1}, true)

AddIngredientValues({"berries"}, {fruit=.5}, true)                              --浆果    
AddIngredientValues({"durian"}, {fruit=1, monster=1}, true)                     --榴莲 【fruit=果、monster=怪物】

AddIngredientValues({"honey", "honeycomb"}, {sweetener=1}, true)                --蜂蜜、蜂巢【甜】

local veggies = {"carrot", "corn", "pumpkin", "eggplant", "cutlichen"}          --胡萝卜、玉米、南瓜、茄子、苔藓【veggie=菜】
AddIngredientValues(veggies, {veggie=1}, true)                                  

local mushrooms = {"red_cap", "green_cap", "blue_cap"}                          --红蘑菇、绿蘑菇、蓝蘑菇          
AddIngredientValues(mushrooms, {veggie=.5}, true)

AddIngredientValues({"meat"}, {meat=1}, true, true)                             --大肉【meat=肉】
AddIngredientValues({"monstermeat"}, {meat=1, monster=1}, true, true)           --怪物肉
AddIngredientValues({"froglegs", "drumstick"}, {meat=.5}, true)                 --蛙腿、鸡腿
AddIngredientValues({"smallmeat"}, {meat=.5}, true, true)                       --小肉

AddIngredientValues({"fish", "eel", "tropical_fish"}, {meat=.5,fish=1}, true)   --鱼、鳗鱼、热带鱼


AddIngredientValues({"mandrake"}, {veggie=1, magic=1}, true)                     --曼德拉草【magic=魔力】
AddIngredientValues({"egg"}, {egg=1}, true)                                      --鸡蛋【egg=蛋】
AddIngredientValues({"tallbirdegg"}, {egg=4}, true)                              --高鸟蛋
AddIngredientValues({"bird_egg"}, {egg=1}, true)                                 --鸟蛋
AddIngredientValues({"butterflywings"}, {decoration=2})                          --蝴蝶翅膀【decoration=装饰】
AddIngredientValues({"butter"}, {fat=1, dairy=1})                                --黄油【fat=肥, dairy=乳制品】
AddIngredientValues({"twigs"}, {inedible=1})                                     --树枝【inedible=不可吃的】

AddIngredientValues({"ice"}, {frozen=1})                                         --冰【frozen=冷冻的】
AddIngredientValues({"mole"}, {meat=.5})                                         --鼹鼠
AddIngredientValues({"cactus_meat"}, {veggie=1}, true)                           --仙人掌肉
AddIngredientValues({"watermelon"}, {fruit=1}, true)                             --西瓜
AddIngredientValues({"cactus_flower"}, {veggie=.5})                              --仙人掌花
AddIngredientValues({"acorn_cooked"}, {seed=1})                                  --熟橡果【seed=种子】
AddIngredientValues({"goatmilk"}, {dairy=1})                                     --羊奶
-- AddIngredientValues({"seeds"}, {seed=1}, true)

--Shipwrecked ingredients
AddIngredientValues({"seaweed"}, {veggie=1}, true, true)                          --海藻
AddIngredientValues({"sweet_potato"}, {veggie=1}, true)                           --甘薯
AddIngredientValues({"coffeebeans"}, {fruit=.5})                                  --咖啡豆
AddIngredientValues({"coffeebeans_cooked"}, {fruit=1})                            --咖啡
AddIngredientValues({"coconut_cooked", "coconut_halved"}, {fruit=1,fat=1})        --熟椰子、半个椰子
AddIngredientValues({"doydoyegg"}, {egg=1}, true)                                 --渡渡鸟蛋
AddIngredientValues({"dorsalfin"}, {inedible=1})                                  --背鳍

                --生鱼肉      死亡的狗鱼   鱼排               剑鱼        鲨鱼鳍      石斑鱼     熟石斑鱼        小丑鱼   熟小丑鱼       霓虹灯鱼  熟霓虹灯鱼      鱼卵   熟鱼籽
local fish_med = {"fish_raw", "fish_med", "fish_med_cooked", "swordfish", "shark_fin", "fish3", "fish3_cooked", "fish4", "fish4_cooked", "fish5", "fish5_cooked", "roe", "roe_cooked"}
AddIngredientValues(fish_med, {meat=0.5,fish=1})                                  

local jellyfish = {"jellyfish", "jellyfish_dead", "jellyfish_cooked", "jellyjerky"}  --水母、死水母、烤水母、水母干【jellyfish=水母】
AddIngredientValues(jellyfish, {fish=1,jellyfish=1,monster=1})                       --

AddIngredientValues({"limpets", "mussel"}, {fish=.5}, true)                       --帽贝、贻贝
AddIngredientValues({"lobster"}, {fish=2}, true)                                  --龙虾【fish=鱼】
AddIngredientValues({"crab"}, {fish=.5})                                          --螃蟹
AddIngredientValues({"fish_raw_small"}, {fish=0.5}, true)                         --小块鱼肉