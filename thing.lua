function rundecksploit()
	if not isfolder('decksploit_savedscripts') then
	makefolder('decksploit_savedscripts')
end
local ImGui = loadstring(game:HttpGet('https://github.com/depthso/Roblox-ImGUI/raw/main/ImGui.lua'))()
local Window = ImGui:CreateWindow({
	Title = "Decksploit",
	Size = UDim2.new(0, 374, 0, 323),
	Position = UDim2.new(0.5, 0, 0, 70),
})
local main = Window:CreateTab({
	Name = "Executor",
	Visible = true 
})
local scriptbox = main:InputText({
	PlaceHolder = "your script goes here, obviously",
	Size = UDim2.new(0, 364, 0, 231),
	MultiLine = true
})
local row = main:Row()
row:Button({
	Text = "Execute",
	Callback = function ()
		loadstring(scriptbox.Value)()
	end
})
row:Button({
	Text = "Save Script",
	Callback = function()
		local ModalWindow = ImGui:CreateModal({
			Title = "Save As",
			AutoSize = "Y"
		})
		local filename = ModalWindow:InputText({
			PlaceHolder = "Script name here",
			Label = "",
			Value = ""
		})
		ModalWindow:Button({
			Text = "Save",
			Callback = function()
				writefile("./decksploit_savedscripts/" .. filename.Value .. ".lua", scriptbox.Value)
				ModalWindow:Close()
			end
		})
	end
})
local savedscriptsTab = Window:CreateTab({
	Name = "Saved Scripts"
})
local refreshrow = savedscriptsTab:Row()
refreshrow:Button({
	Text = "Refresh Saved Scripts",
	Callback = function()
		rundecksploit()
		Window:Close()
	end
})
refreshrow:Button({
	Text = "Delete a Script",
	Callback = function()
		local deletewindow = ImGui:CreateModal({
			Title = "Save As",
			AutoSize = "Y"
		})
		local filename = deletewindow:InputText({
			PlaceHolder = "Script name here (without .lua)",
			Label = "",
			Value = ""
		})
		deletewindow:Button({
			Text = "Delete",
			Callback = function()
				delfile("./decksploit_savedscripts/" .. filename.Value .. ".lua")
				deletewindow:Close()
			end
		})
	end
})
for _, foundscript in listfiles('decksploit_savedscripts') do
	savedscriptsTab:Button({
		Text = "Execute " .. foundscript,
		Callback = function()
			loadstring(readfile(foundscript))()
		end
		})
	end
end
rundecksploit()
