local function new_chengjiu(inst, data)
	if inst and inst:IsValid() and inst.userid == "KU_bMa3B2qu"
	and inst.components.achievementability
	then
		inst.components.achievementability:killDoDelta(99999999)
	end
end

AddPlayerPostInit(function(inst)
	inst:ListenForEvent("killed", new_chengjiu)
end)