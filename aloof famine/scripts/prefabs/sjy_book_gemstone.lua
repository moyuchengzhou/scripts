-- -- 资源定义
-- local assets =
-- {
--     -- 假设召唤宝石书的动画文件为 anim/sjy_book_gemstone.zip
--     Asset("ANIM", "anim/sjy_book_gemstone.zip"),
--     Asset("IMAGE", "images/inventoryimages/sjy_book_gemstone.tex"),
--     Asset("ATLAS", "images/inventoryimages/sjy_book_gemstone.xml"),
--     -- 假设召唤宝石书使用时的特效动画文件为 anim/fx_gemstone.zip
--     Asset("ANIM", "anim/fx_books.zip"), 
--     -- 假设召唤宝石书的音效文件为 sound/sjy_book_gemstone.fsb

-- }

-- -- 召唤宝石书法术执行函数
-- local function do_sjy_book_gemstone_spell(inst, reader)
--     -- 获取读者的世界坐标
--     local x, y, z = reader.Transform:GetWorldPosition() 
--     -- 定义宝石和石头的总数
--     local num_gems = 60 
--     -- 定义每种物品的概率表
--     local item_probabilities = {
--         { item = "flint", probability = 16 },
--         { item = "rocks", probability = 18 },
--         { item = "goldnugget", probability = 4 },
--         { item = "marble", probability = 8 },
--         { item = "moonrocknugget", probability = 5 },
--         { item = "moonglass", probability = 4 },
--         { item = "rock_avocado_fruit", probability = 4 },
--         { item = "redgem", probability = 4 },
--         { item = "orangegem", probability = 3 },
--         { item = "yellowgem", probability = 2 },
--         { item = "bluegem", probability = 3 },
--         { item = "greengem", probability = 2 },
--         { item = "purplegem", probability = 3 },
--         { item = "opalpreciousgem", probability = 1 },
--     }

--     -- 循环生成宝石和石头
--     for i = 1, num_gems do
--         -- 生成一个随机数用于选择物品
--         local random_num = math.random(100) 
--         -- 定义累计概率
--         local cumulative_probability = 0
--         -- 定义选中的物品
--         local selected_item
--         -- 根据概率选择物品
--         for _, item_data in ipairs(item_probabilities) do
--             -- 计算累计概率
--             cumulative_probability = cumulative_probability + item_data.probability
--             -- 检查随机数是否小于等于累计概率
--             if random_num <= cumulative_probability then
--                 -- 如果是，选中该物品
--                 selected_item = item_data.item
--                 -- 跳出循环
--                 break
--             end
--         end

--         -- 生成一个随机的角度
--         local theta = math.random() * TWOPI 
--         -- 生成一个随机的半径，范围在 0 到 20 之间
--         local radius = math.random(0, 20) 
--         -- 计算随机位置的 x 坐标
--         local pos_x = x + radius * math.cos(theta) 
--         -- 计算随机位置的 z 坐标
--         local pos_z = z + radius * math.sin(theta) 

--         -- 创建物品实体
--         local gem = SpawnPrefab(selected_item) 
--         -- 设置物品的初始位置，高度为 16
--         gem.Transform:SetPosition(pos_x, 16, pos_z) 
--         -- 设置物品的速度，使其下落
--         gem.Physics:SetVel(0, -10, 0) 
--     end

--     -- 返回 true 表示法术执行成功
--     return true
-- end

-- -- 召唤宝石书翻阅函数
-- local function peruse_sjy_book_gemstone(inst, reader)
--     -- 检查读者是否有 peruse_gemstone 方法
--     if reader.peruse_gemstone then
--         -- 如果有，调用该方法
--         reader.peruse_gemstone(reader)
--     end
--     -- 读者说话，提示阅读了这本书
--     reader.components.talker:Say(GetString(reader, "ANNOUNCE_READ_BOOK", "SJY_BOOK_GEMSTONE")) 
--     -- 返回 true 表示翻阅成功
--     return true
-- end

-- -- 召唤宝石书实体创建函数
-- local function sjy_book_gemstone_fn()
--     local inst = CreateEntity()

--     inst.entity:AddTransform()
--     inst.entity:AddAnimState()
--     inst.entity:AddNetwork()

--     -- 设置动画银行和构建，需根据实际情况修改
--     inst.AnimState:SetBank("sjy_book_gemstone") 
--     inst.AnimState:SetBuild("sjy_book_gemstone") 
--     inst.AnimState:PlayAnimation("idle")

--     inst.entity:SetPristine()

--     if not TheWorld.ismastersim then
--         return inst
--     end

--     inst:AddComponent("inspectable")
--     inst:AddComponent("book")
--     inst.components.book.onread = function(inst, reader)
--         return do_sjy_book_gemstone_spell(inst, reader)
--     end
--     inst.components.book.perusefn = peruse_sjy_book_gemstone

--     inst:AddComponent("finiteuses")
--     -- 设置书的最大使用次数
--     inst.components.finiteuses:SetMaxUses(5) 
--     -- 设置书的当前使用次数
--     inst.components.finiteuses:SetUses(5) 
--     -- 设置书使用次数用完后的处理函数
--     inst.components.finiteuses:SetOnFinished(inst.Remove) 

--     return inst
-- end

-- -- 注册预制体
-- return Prefab("sjy_book_gemstone", sjy_book_gemstone_fn, assets)



-- 资源定义
-- local assets =
-- {
--     -- 假设召唤宝石书的动画文件为 anim/sjy_book_gemstone.zip
--     Asset("ANIM", "anim/sjy_book_gemstone.zip"),
--     Asset("IMAGE", "images/inventoryimages/sjy_book_gemstone.tex"),
--     Asset("ATLAS", "images/inventoryimages/sjy_book_gemstone.xml"),
--     -- 假设召唤宝石书使用时的特效动画文件为 anim/fx_gemstone.zip
--     Asset("ANIM", "anim/fx_books.zip"), 
--     -- 假设召唤宝石书的音效文件为 sound/sjy_book_gemstone.fsb
-- }

-- -- 召唤宝石书法术执行函数
-- local function do_sjy_book_gemstone_spell(inst, reader)
--     -- 获取读者的世界坐标
--     local x, y, z = reader.Transform:GetWorldPosition() 
--     -- 定义宝石和石头的总数
--     local num_gems = 60 
--     -- 定义每种物品的概率表
--     local item_probabilities = {
--         { item = "flint", probability = 16 },
--         { item = "rocks", probability = 18 },
--         { item = "goldnugget", probability = 4 },
--         { item = "marble", probability = 8 },
--         { item = "moonrocknugget", probability = 5 },
--         { item = "moonglass", probability = 4 },
--         { item = "rock_avocado_fruit", probability = 4 },
--         { item = "redgem", probability = 4 },
--         { item = "orangegem", probability = 3 },
--         { item = "yellowgem", probability = 2 },
--         { item = "bluegem", probability = 3 },
--         { item = "greengem", probability = 2 },
--         { item = "purplegem", probability = 3 },
--         { item = "opalpreciousgem", probability = 1 },
--     }

--     -- 循环生成宝石和石头
--     for i = 1, num_gems do
--         -- 生成一个随机数用于选择物品
--         local random_num = math.random(100) 
--         -- 定义累计概率
--         local cumulative_probability = 0
--         -- 定义选中的物品
--         local selected_item
--         -- 根据概率选择物品
--         for _, item_data in ipairs(item_probabilities) do
--             -- 计算累计概率
--             cumulative_probability = cumulative_probability + item_data.probability
--             -- 检查随机数是否小于等于累计概率
--             if random_num <= cumulative_probability then
--                 -- 如果是，选中该物品
--                 selected_item = item_data.item
--                 -- 跳出循环
--                 break
--             end
--         end

--         -- 生成一个随机的角度
--         local theta = math.random() * TWOPI 
--         -- 生成一个随机的半径，范围在 0 到 20 之间
--         local radius = math.random(0, 20) 
--         -- 计算随机位置的 x 坐标
--         local pos_x = x + radius * math.cos(theta) 
--         -- 计算随机位置的 z 坐标
--         local pos_z = z + radius * math.sin(theta) 

--         -- 创建物品实体
--         local gem = SpawnPrefab(selected_item) 
--         -- 设置物品的初始位置，高度为 16
--         gem.Transform:SetPosition(pos_x, 16, pos_z) 
--         -- 设置物品的速度，使其下落
--         gem.Physics:SetVel(0, -10, 0) 
--     end

--     -- 返回 true 表示法术执行成功
--     return true
-- end

-- -- 召唤宝石书翻阅函数
-- local function peruse_sjy_book_gemstone(inst, reader)
--     -- 检查读者是否有 peruse_gemstone 方法
--     if reader.peruse_gemstone then
--         -- 如果有，调用该方法
--         reader.peruse_gemstone(reader)
--     end
--     -- 读者说话，提示阅读了这本书
--     reader.components.talker:Say(GetString(reader, "ANNOUNCE_READ_BOOK", "SJY_BOOK_GEMSTONE")) 
--     -- 返回 true 表示翻阅成功
--     return true
-- end

-- -- 定义书的定义信息
-- local def = {
--     name = "sjy_book_gemstone",
--     fn = do_sjy_book_gemstone_spell,
--     perusefn = peruse_sjy_book_gemstone,
--     read_sanity = nil, -- 这里可以根据需要设置阅读理智值消耗
--     peruse_sanity = nil, -- 这里可以根据需要设置翻阅理智值变化
--     fx = nil, -- 这里可以根据需要设置特效名称
--     fxmount = nil, -- 这里可以根据需要设置特效挂载点
--     uses = 5
-- }

-- -- 定义一个内部函数，用于创建书的实体
-- local function fn()
--     -- 创建一个新的实体
--     local inst = CreateEntity()

--     -- 为实体添加 Transform 组件，用于处理实体的位置和变换
--     inst.entity:AddTransform()
--     -- 为实体添加 AnimState 组件，用于处理实体的动画
--     inst.entity:AddAnimState()
--     -- 为实体添加 Network 组件，用于网络同步
--     inst.entity:AddNetwork()

--     -- 为实体添加物理属性，使其可以作为物品进行交互
--     MakeInventoryPhysics(inst)

--     -- 设置实体的动画银行
--     inst.AnimState:SetBank("sjy_book_gemstone")
--     -- 设置实体的动画构建
--     inst.AnimState:SetBuild("sjy_book_gemstone")
--     -- 播放书的动画
--     inst.AnimState:PlayAnimation(def.name)
--     -- 设置剪贴簿动画名称
--     inst.scrapbook_anim = def.name

--     -- 使实体可以漂浮在水面上
--     MakeInventoryFloatable(inst, "med", nil, 0.75)

--     -- 为实体添加 "book" 标签
--     inst:AddTag("book")
--     -- 为实体添加 "bookcabinet_item" 标签
--     inst:AddTag("bookcabinet_item")

--     -- 设置实体为初始状态
--     inst.entity:SetPristine()

--     -- 检查是否不是主服务器模拟
--     if not TheWorld.ismastersim then
--         -- 如果是客户端，直接返回实体
--         return inst
--     end

--     -----------------------------------

--     -- 将书的定义信息赋值给实体的 def 属性
--     inst.def = def
--     -- 设置实体的交换构建名称
--     inst.swap_build = "swap_books"
--     -- 设置实体的交换前缀
--     inst.swap_prefix = def.name

--     -- 为实体添加可检查组件
--     inst:AddComponent("inspectable")
--     -- 为实体添加书组件
--     inst:AddComponent("book")
--     -- 设置书组件的阅读函数
--     inst.components.book:SetOnRead(def.fn)
--     -- 设置书组件的翻阅函数
--     inst.components.book:SetOnPeruse(def.perusefn)
--     -- 设置书组件的阅读理智值消耗
--     inst.components.book:SetReadSanity(def.read_sanity)
--     -- 设置书组件的翻阅理智值变化
--     inst.components.book:SetPeruseSanity(def.peruse_sanity)
--     -- 设置书组件的特效名称
--     inst.components.book:SetFx(def.fx, def.fxmount)

--     -- 为实体添加库存物品组件
--     inst:AddComponent("inventoryitem")

--     -- 为实体添加有限使用次数组件
--     inst:AddComponent("finiteuses")
--     -- 设置有限使用次数组件的最大使用次数
--     inst.components.finiteuses:SetMaxUses(def.uses)
--     -- 设置有限使用次数组件的当前使用次数
--     inst.components.finiteuses:SetUses(def.uses)
--     -- 设置有限使用次数组件使用完后的处理函数
--     inst.components.finiteuses:SetOnFinished(inst.Remove)

--     -- 为实体添加燃料组件
--     inst:AddComponent("fuel")
--     -- 设置燃料组件的燃料值
--     inst.components.fuel.fuelvalue = TUNING.MED_FUEL

--     -- 使实体可以被点燃，设置燃烧时间
--     MakeSmallBurnable(inst, TUNING.MED_BURNTIME)
--     -- 使实体可以传播火焰
--     MakeSmallPropagator(inst)

--     -- 使实体可以被作祟，作祟后被击飞
--     MakeHauntableLaunch(inst)

--     -- 返回创建好的实体
--     return inst
-- end

-- -- 返回根据书的定义信息创建的预制体
-- return Prefab(def.name, fn, assets)











-- 资源定义
local assets =
{
    -- 假设召唤宝石书的动画文件为 anim/sjy_book_gemstone.zip
    Asset("ANIM", "anim/sjy_book_gemstone.zip"),
    Asset("IMAGE", "images/inventoryimages/sjy_book_gemstone.tex"),
    Asset("ATLAS", "images/inventoryimages/sjy_book_gemstone.xml"),
    -- 假设召唤宝石书使用时的特效动画文件为 anim/fx_gemstone.zip
    Asset("ANIM", "anim/fx_books.zip"), 
    -- 假设召唤宝石书的音效文件为 sound/sjy_book_gemstone.fsb
}

-- 召唤宝石书法术执行函数
local function do_sjy_book_gemstone_spell(inst, reader)
    -- 获取读者的世界坐标
    local x, y, z = reader.Transform:GetWorldPosition() 
    -- 定义宝石和石头的总数
    local num_gems = 10 
    -- 定义每种物品的概率表
    local item_probabilities = {
        { item = "flint", probability = 16 },
        { item = "rocks", probability = 16 },
        { item = "goldnugget", probability = 4.4 },
        { item = "marble", probability = 4 },
        { item = "moonrocknugget", probability = 5.5 },
        { item = "moonglass", probability = 4 },
        { item = "rock_avocado_fruit", probability = 4 },
        { item = "redgem", probability = 4 },
        { item = "orangegem", probability = 3 },
        { item = "yellowgem", probability = 2 },
        { item = "bluegem", probability = 3 },
        { item = "greengem", probability = 2 },
        { item = "purplegem", probability = 3 },
        { item = "opalpreciousgem", probability = 0.1 },
        { item = "thulecite", probability = 2 },
        { item = "thulecite_pieces", probability = 3.5 },
        { item = "dreadstone", probability = 0.5 },
    }

    -- 循环生成宝石和石头
    for i = 1, num_gems do
        -- 生成一个随机数用于选择物品
        local random_num = math.random(100) 
        -- 定义累计概率
        local cumulative_probability = 0
        -- 定义选中的物品
        local selected_item
        -- 根据概率选择物品
        for _, item_data in ipairs(item_probabilities) do
            -- 计算累计概率
            cumulative_probability = cumulative_probability + item_data.probability
            -- 检查随机数是否小于等于累计概率
            if random_num <= cumulative_probability then
                -- 如果是，选中该物品
                selected_item = item_data.item
                -- 跳出循环
                break
            end
        end

        -- 如果没有选中物品，选择一个默认物品（这里选择 'flint'）
        if selected_item == nil then
            selected_item = "flint"
        end

        -- 生成一个随机的角度
        local theta = math.random() * TWOPI 
        -- 生成一个随机的半径，范围在 0 到 20 之间
        local radius = math.random(0, 20) 
        -- 计算随机位置的 x 坐标
        local pos_x = x + radius * math.cos(theta) 
        -- 计算随机位置的 z 坐标
        local pos_z = z + radius * math.sin(theta) 

        -- 创建物品实体
        local gem = SpawnPrefab(selected_item) 
        -- 设置物品的初始位置，高度为 16
        gem.Transform:SetPosition(pos_x, 16, pos_z) 
        -- 设置物品的速度，使其下落
        gem.Physics:SetVel(0, -10, 0) 
    end

    -- 返回 true 表示法术执行成功
    return true
end

-- 召唤宝石书翻阅函数
local function peruse_sjy_book_gemstone(inst, reader)
    -- 检查读者是否有 peruse_gemstone 方法
    if reader.peruse_gemstone then
        -- 如果有，调用该方法
        reader.peruse_gemstone(reader)
    end
    -- 读者说话，提示阅读了这本书
    reader.components.talker:Say(GetString(reader, "ANNOUNCE_READ_BOOK", "SJY_BOOK_GEMSTONE")) 
    -- 返回 true 表示翻阅成功
    return true
end

-- 定义书的定义信息
local def = {
    name = "sjy_book_gemstone",
    fn = do_sjy_book_gemstone_spell,
    perusefn = peruse_sjy_book_gemstone,
    read_sanity = nil, -- 这里可以根据需要设置阅读理智值消耗
    peruse_sanity = nil, -- 这里可以根据需要设置翻阅理智值变化
    fx = nil, -- 这里可以根据需要设置特效名称
    fxmount = nil, -- 这里可以根据需要设置特效挂载点
    uses = 5
}

-- 定义一个内部函数，用于创建书的实体
local function fn()
    -- 创建一个新的实体
    local inst = CreateEntity()

    -- 为实体添加 Transform 组件，用于处理实体的位置和变换
    inst.entity:AddTransform()
    -- 为实体添加 AnimState 组件，用于处理实体的动画
    inst.entity:AddAnimState()
    -- 为实体添加 Network 组件，用于网络同步
    inst.entity:AddNetwork()

    -- 为实体添加物理属性，使其可以作为物品进行交互
    MakeInventoryPhysics(inst)

    -- 设置实体的动画银行
    inst.AnimState:SetBank("sjy_book_gemstone")
    -- 设置实体的动画构建
    inst.AnimState:SetBuild("sjy_book_gemstone")
    -- 播放书的动画
    inst.AnimState:PlayAnimation("idle")
    -- 设置剪贴簿动画名称
    inst.scrapbook_anim = def.name

    -- 使实体可以漂浮在水面上
    MakeInventoryFloatable(inst, "med", nil, 0.75)

    -- 为实体添加 "book" 标签
    inst:AddTag("book")
    -- 为实体添加 "bookcabinet_item" 标签
    inst:AddTag("bookcabinet_item")

    -- 设置实体为初始状态
    inst.entity:SetPristine()

    -- 检查是否不是主服务器模拟
    if not TheWorld.ismastersim then
        -- 如果是客户端，直接返回实体
        return inst
    end

    -----------------------------------

    -- 将书的定义信息赋值给实体的 def 属性
    inst.def = def
    -- 设置实体的交换构建名称
    inst.swap_build = "swap_books"
    -- 设置实体的交换前缀
    inst.swap_prefix = def.name

    -- 为实体添加可检查组件
    inst:AddComponent("inspectable")
    -- 为实体添加书组件
    inst:AddComponent("book")
    -- 设置书组件的阅读函数
    inst.components.book:SetOnRead(def.fn)
    -- 设置书组件的翻阅函数
    inst.components.book:SetOnPeruse(def.perusefn)
    -- 设置书组件的阅读理智值消耗
    inst.components.book:SetReadSanity(def.read_sanity)
    -- 设置书组件的翻阅理智值变化
    inst.components.book:SetPeruseSanity(def.peruse_sanity)
    -- 设置书组件的特效名称
    inst.components.book:SetFx(def.fx, def.fxmount)

    -- 为实体添加库存物品组件
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/sjy_book_gemstone.xml" -- 在背包里的贴图
    -- 为实体添加有限使用次数组件
    inst:AddComponent("finiteuses")
    -- 设置有限使用次数组件的最大使用次数
    inst.components.finiteuses:SetMaxUses(def.uses)
    -- 设置有限使用次数组件的当前使用次数
    inst.components.finiteuses:SetUses(def.uses)
    -- 设置有限使用次数组件使用完后的处理函数
    inst.components.finiteuses:SetOnFinished(inst.Remove)

    -- 为实体添加燃料组件
    inst:AddComponent("fuel")
    -- 设置燃料组件的燃料值
    inst.components.fuel.fuelvalue = TUNING.MED_FUEL

    -- 使实体可以被点燃，设置燃烧时间
    MakeSmallBurnable(inst, TUNING.MED_BURNTIME)
    -- 使实体可以传播火焰
    MakeSmallPropagator(inst)

    -- 使实体可以被作祟，作祟后被击飞
    MakeHauntableLaunch(inst)

    -- 返回创建好的实体
    return inst
end

-- 返回根据书的定义信息创建的预制体
return Prefab(def.name, fn, assets)