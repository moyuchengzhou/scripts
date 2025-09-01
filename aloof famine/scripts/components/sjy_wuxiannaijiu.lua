
local function onwnj(self,wnj)
	if wnj then
		self.inst:RemoveTag("can_sjy_wuxiannaijiu")
		self.inst:AddTag("hide_percentage")
		if self.inst.components.fueled then
			self.inst.components.fueled.StartConsuming = function(self) self:StopConsuming() end
			self.inst.components.fueled:StopConsuming()
			self.inst.components.fueled.rate = 0
			self.inst.components.fueled:SetPercent(1)
		elseif self.inst.components.finiteuses  then
			self.inst.components.finiteuses:SetPercent(1)
			self.inst.components.finiteuses.SetUses = function(self)  end
		elseif self.inst.components.armor  then
			self.inst.components.armor:SetPercent(1)
			self.inst.components.armor.indestructible = true
		end
	else
		self.inst:AddTag("can_sjy_wuxiannaijiu")
	end

end

local sjy_gaibian = Class(function(self, inst)
	self.inst = inst
	self.wnj = false
end,
nil,
{
	wnj = onwnj
})

function sjy_gaibian:SetWNJ(object)
	self.wnj = true
	self.inst:AddTag("hide_percentage")
	self.inst:RemoveTag("show_broken_ui")
	self.inst:RemoveTag("show_spoilage")
	object.components.stackable:Get():Remove()
	return true

		----移除耐久显示
	

		-- if self.inst.components.perishable then
		-- 	self.inst.components.perishable:StopPerishing()
		-- 	--self.inst.components.perishable.localPerishMultiplyer = -100 
		-- 	self.inst.components.perishable:SetPercent(1)

		-- 	----弃用代码
		-- 	--local currentperc = self.inst.components.perishable:GetPercent()
		-- 	--if currentperc >= 1 then
		-- 	--	self.inst:RemoveComponent("perishable")
		-- 	--end
		-- end

		-- ----满级后耐久消耗为0
		-- if self.inst.components.finiteuses then
		-- 	self.inst.components.finiteuses:SetPercent(1)
		-- 	function self.inst.components.finiteuses:Use(num)
		-- 		return true
		-- 	end
		-- 	function self.inst.components.finiteuses:SetConsumption(action, uses)
		-- 		self[action] = 0
		-- 	end
		-- end

		-- ----满级后燃料消耗为0
		-- if self.inst.components.fueled then
		-- 	self.inst.components.fueled:SetPercent(1)
		-- 	self.inst.components.fueled.rate = 0
		-- 	function self.inst.components.fueled:StartConsuming()
		-- 		return true
		-- 	end
		-- 	function self.inst.components.fueled:DoDelta(amount, doer)
		-- 		return true
		-- 	end
		-- end

		-- ----满级后装备消耗为0
		-- if self.inst.components.armor then
		-- 	self.inst.components.armor:SetPercent(1)
		-- 	self.inst.components.armor.indestructible = true
		-- end
end

function sjy_gaibian:OnSave()
    return { wnj = self.wnj }
end

function sjy_gaibian:OnLoad(data)
    if data.wnj then
        self.wnj = true
    end
end
return sjy_gaibian
