

local cooking = require("cooking")
local containers = require "containers"
local params = containers.params

-- 超大餐桌
params.sjy_zhuozi_table =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_fish_box_5x4",
        animbuild = "ui_fish_box_5x4",
        pos = Vector3(0, 220, 0),
        side_align_tip = 160,
    },
    type = "sjy_table",
}

for y = 2.5, -0.5, -1 do
    for x = -1, 3 do
        table.insert(params.sjy_zhuozi_table.widget.slotpos, Vector3(75 * x - 75 * 2 + 75, 75 * y - 75 * 2 + 75, 0))
    end
end

function params.sjy_zhuozi_table.itemtestfn(container, item, slot)

    return item:HasTag("preparedfood") and not container.inst:HasTag("burnt")
end
-- 蘑菇餐桌1

params.sjy_mogu_table =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_backpack_2x4",
        animbuild = "ui_backpack_2x4",
        --pos = Vector3(-5, -70, 0),
        pos = Vector3(-5, -80, 0),        
    },
    issidewidget = true,
    type = "sjy_mogu_tables",
    openlimit = 1,
}

for y = 0, 3 do
    table.insert(params.sjy_mogu_table.widget.slotpos, Vector3(-162, -75 * y + 114, 0))
    table.insert(params.sjy_mogu_table.widget.slotpos, Vector3(-162 + 75, -75 * y + 114, 0))
end

function params.sjy_mogu_table.itemtestfn(container, item, slot)

    return item:HasTag("preparedfood") and not container.inst:HasTag("burnt")
end


-- 蘑菇餐桌2

params.sjy_mogu2_table =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_backpack_2x4",
        animbuild = "ui_backpack_2x4",
        --pos = Vector3(-5, -70, 0),
        pos = Vector3(-5, -80, 0),        
    },
    issidewidget = true,
    type = "sjy_mogu2_tables",
    openlimit = 1,
}

for y = 0, 3 do
    table.insert(params.sjy_mogu2_table.widget.slotpos, Vector3(-162, -75 * y + 114, 0))
    table.insert(params.sjy_mogu2_table.widget.slotpos, Vector3(-162 + 75, -75 * y + 114, 0))
end

function params.sjy_mogu2_table.itemtestfn(container, item, slot)

    return item:HasTag("preparedfood") and not container.inst:HasTag("burnt")
end
-- 蘑菇餐桌3
params.sjy_mogu3_table =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_backpack_2x4",
        animbuild = "ui_backpack_2x4",
        --pos = Vector3(-5, -70, 0),
        pos = Vector3(-5, -80, 0),        
    },
    issidewidget = true,
    type = "sjy_mogu3_tables",
    openlimit = 1,
}

for y = 0, 3 do
    table.insert(params.sjy_mogu3_table.widget.slotpos, Vector3(-162, -75 * y + 114, 0))
    table.insert(params.sjy_mogu3_table.widget.slotpos, Vector3(-162 + 75, -75 * y + 114, 0))
end

function params.sjy_mogu3_table.itemtestfn(container, item, slot)

    return item:HasTag("preparedfood") and not container.inst:HasTag("burnt")
end


-- 蘑菇餐桌4
params.sjy_mogu4_table =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_backpack_2x4",
        animbuild = "ui_backpack_2x4",
        --pos = Vector3(-5, -70, 0),
        pos = Vector3(-5, -80, 0),        
    },
    issidewidget = true,
    type = "sjy_mogu4_tables",
    openlimit = 1,
}

for y = 0, 3 do
    table.insert(params.sjy_mogu4_table.widget.slotpos, Vector3(-162, -75 * y + 114, 0))
    table.insert(params.sjy_mogu4_table.widget.slotpos, Vector3(-162 + 75, -75 * y + 114, 0))
end

function params.sjy_mogu4_table.itemtestfn(container, item, slot)

    return item:HasTag("preparedfood") and not container.inst:HasTag("burnt")
end
-- 捣蛋鬼帽子
params.sjy_wsj_limao =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_fish_box_5x4",
        animbuild = "ui_fish_box_5x4",
        pos = Vector3(0, 220, 0),
        side_align_tip = 160,
    },
    type = "sjy_wsj_limaos",
}
for y = 2.5, -0.5, -1 do
    for x = -1, 3 do
        table.insert(params.sjy_wsj_limao.widget.slotpos, Vector3(75 * x - 75 * 2 + 75, 75 * y - 75 * 2 + 75, 0))
    end
end

function params.sjy_wsj_limao.itemtestfn(container, item, slot)
    return not item:HasTag("sjy_wsj_limaotag")
end

-- 万圣节锅
params.sjy_wanshengjieguo =
{
    widget =
    {
        slotpos =
        {
            Vector3(0, 64 + 32 + 8 + 4, 0),
            Vector3(0, 32 + 4, 0),
            Vector3(0, -(32 + 4), 0),
            Vector3(0, -(64 + 32 + 8 + 4), 0),
        },
        animbank = "ui_cookpot_1x4",
        animbuild = "ui_cookpot_1x4",
        pos = Vector3(200, 0, 0),
        side_align_tip = 100,
        buttoninfo =
        {
            text = STRINGS.ACTIONS.COOK,
            position = Vector3(0, -165, 0),
        }
    },
    acceptsstacks = false,
    type = "sjy_wanshengjieguos",
}

function params.sjy_wanshengjieguo.itemtestfn(container, item, slot)
    return cooking.IsCookingIngredient(item.prefab) and not container.inst:HasTag("burnt")
end

function params.sjy_wanshengjieguo.widget.buttoninfo.fn(inst, doer)
    if inst.components.container ~= nil then
        BufferedAction(doer, inst, ACTIONS.COOK):Do()
    elseif inst.replica.container ~= nil and not inst.replica.container:IsBusy() then
        SendRPCToServer(RPC.DoWidgetButtonAction, ACTIONS.COOK.code, inst, ACTIONS.COOK.mod_name)
    end
end

function params.sjy_wanshengjieguo.widget.buttoninfo.validfn(inst)
    return inst.replica.container ~= nil and inst.replica.container:IsFull()
end


-- 姜饼箱子1
params.sjy_jiangbingxiang1 =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_fish_box_5x4",
        animbuild = "ui_fish_box_5x4",
        pos = Vector3(0, 220, 0),
        side_align_tip = 160,
    },
    type = "chest",
}
for y = 2.5, -0.5, -1 do
    for x = -1, 3 do
        table.insert(params.sjy_jiangbingxiang1.widget.slotpos, Vector3(75 * x - 75 * 2 + 75, 75 * y - 75 * 2 + 75, 0))
    end
end

-- 姜饼箱子2
params.sjy_jiangbingxiang2 =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_fish_box_5x4",
        animbuild = "ui_fish_box_5x4",
        pos = Vector3(0, 220, 0),
        side_align_tip = 160,
    },
    type = "chest",
}
for y = 2.5, -0.5, -1 do
    for x = -1, 3 do
        table.insert(params.sjy_jiangbingxiang2.widget.slotpos, Vector3(75 * x - 75 * 2 + 75, 75 * y - 75 * 2 + 75, 0))
    end
end

-- 姜饼箱子3
params.sjy_jiangbingxiang3 =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_fish_box_5x4",
        animbuild = "ui_fish_box_5x4",
        pos = Vector3(0, 220, 0),
        side_align_tip = 160,
    },
    type = "chest",
}
for y = 2.5, -0.5, -1 do
    for x = -1, 3 do
        table.insert(params.sjy_jiangbingxiang3.widget.slotpos, Vector3(75 * x - 75 * 2 + 75, 75 * y - 75 * 2 + 75, 0))
    end
end




-- 炒锅
params.sjy_chaoguo =
{
    widget =
    {
        slotpos =
        {
            Vector3(0, 64 + 32 + 8 + 4, 0),
            Vector3(0, 32 + 4, 0),
            Vector3(0, -(32 + 4), 0),
            Vector3(0, -(64 + 32 + 8 + 4), 0),
        },
        animbank = "ui_cookpot_1x4",
        animbuild = "ui_cookpot_1x4",
        pos = Vector3(200, 0, 0),
        side_align_tip = 100,
        buttoninfo =
        {
            text = STRINGS.ACTIONS.COOK,
            position = Vector3(0, -165, 0),
        }
    },
    acceptsstacks = false,
    type = "sjy_chaoguos",
}

function params.sjy_chaoguo.itemtestfn(container, item, slot)
    return cooking.IsCookingIngredient(item.prefab) and not container.inst:HasTag("burnt")
end

function params.sjy_chaoguo.widget.buttoninfo.fn(inst, doer)
    if inst.components.container ~= nil then
        BufferedAction(doer, inst, ACTIONS.COOK):Do()
    elseif inst.replica.container ~= nil and not inst.replica.container:IsBusy() then
        SendRPCToServer(RPC.DoWidgetButtonAction, ACTIONS.COOK.code, inst, ACTIONS.COOK.mod_name)
    end
end

function params.sjy_chaoguo.widget.buttoninfo.validfn(inst)
    return inst.replica.container ~= nil and inst.replica.container:IsFull()
end





















































for k, v in pairs(params) do
    containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0)
end