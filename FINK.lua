script_authors('E.LopeZ')
script_name('FINK')

require 'lib.moonloader'
local sampev = require 'samp.events'
local key = require 'vkeys'
local money = -1
local action = 0
local doing = false

function main()
	if not isSampfuncsLoaded() or not isSampLoaded() then return end
	while not isSampAvailable() do wait(100) end

	sampRegisterChatCommand('finka', function ()
		if not sampIsDialogActive() then
			sampSendChat('/bc') money = -1 action = 0 doing = true
		end
	end)

	while true do wait (0)
	end
end
function sampev.onShowDialog(id, style, title, btn1, btn2, text)
	if doing then
		if id == 2400 and style == 2 and title == "{34C924}Управление предприятием" and money == -1 and action == 0 then sampSendDialogResponse(2400,1,7,"Общая информация") action = 1
		elseif id == 2399 and style == 0 and action == 1 then money = text:match("Баланс кассы: {ffff00}(%d+)") money = money - 3000 sampSendDialogResponse(2399,0,65535,'')
			if tonumber(money) <= 0 then action = -1 else action = 2 end
		elseif id == 2400 and style == 2 and title == "{34C924}Управление предприятием" and money ~= -1 and action == 2 then sampSendDialogResponse(2400,1,6,"Взять деньги из кассы") action = 3
		elseif id == 2409 and style == 1 and title == "{34C924}Управление предприятием" and money ~= -1 and action == 3 then sampSendDialogResponse(2409,1,65535,money) action = 4
		elseif id == 2399 and style == 0 and action == 4 then sampSendDialogResponse(2399,1,65535,'') action = 5
		elseif id == 2400 and style == 2 and title == "{34C924}Управление предприятием" and action == 5 then sampSendDialogResponse(2400,0,0,'') doing = false action = 0
		elseif id == 2400 and style == 2 and title == "{34C924}Управление предприятием" and action == -1 then sampAddChatMessage("Нет денег",-1) doing = false action = 0 sampSendDialogResponse(2400,0,0,'') return false
		end
		return false
	else
	end
end
