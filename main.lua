local player = game.Players.LocalPlayer

-- Buat ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.Name = "TeleportUI"
screenGui.ResetOnSpawn = false

-- Buat MainFrame
local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 250, 0, 350)
mainFrame.Position = UDim2.new(0.5, -125, 0.5, -175)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.BorderSizePixel = 2
mainFrame.Draggable = true
mainFrame.Active = true
mainFrame.Transparency = 1

-- Toggle Button
local toggleButton = Instance.new("TextButton")
toggleButton.Parent = mainFrame
toggleButton.Size = UDim2.new(1, 0, 0, 30)
toggleButton.Position = UDim2.new(0, 0, 0, -35)
toggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Text = "Toggle Teleport UI"
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.TextSize = 16


-- CanvasGroup untuk menghilangkan/munculkan UI
local canvasGroup = Instance.new("CanvasGroup")
canvasGroup.Parent = mainFrame
canvasGroup.Size = UDim2.new(1, 0, 1, 0)

-- Label Selected Place
local selectedPlaceLabel = Instance.new("TextLabel")
selectedPlaceLabel.Parent = canvasGroup
selectedPlaceLabel.Size = UDim2.new(1, 0, 0, 30)
selectedPlaceLabel.Position = UDim2.new(0, 0, 0, 0)
selectedPlaceLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
selectedPlaceLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
selectedPlaceLabel.Text = "Selected Place: None"
selectedPlaceLabel.Font = Enum.Font.SourceSansBold
selectedPlaceLabel.TextSize = 16

-- ScrollingFrame untuk daftar lokasi
local scrollingFrame = Instance.new("ScrollingFrame")
scrollingFrame.Parent = canvasGroup
scrollingFrame.Size = UDim2.new(1, 0, 1, -30)
scrollingFrame.Position = UDim2.new(0, 0, 0, 30)
scrollingFrame.BackgroundTransparency = 1
scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 500)
scrollingFrame.ScrollBarThickness = 5

-- UIListLayout untuk menyusun tombol
local uiList = Instance.new("UIListLayout")
uiList.Parent = scrollingFrame
uiList.SortOrder = Enum.SortOrder.LayoutOrder
uiList.Padding = UDim.new(0, 5)
uiList.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Koordinat Teleport
local teleportLocations = {
	Moosewod = Vector3.new(391, 135, 249),
	Roslit = Vector3.new(-1470, 133, 700),
	Forsaken = Vector3.new(-2483, 133, 1562),
	GrandReef = Vector3.new(-3576, 151, 522),
	["Atlantean Storm"] = Vector3.new(-3642, 131, 773),
	Spike = Vector3.new(-1281, 140, 1526),
	Terapin = Vector3.new(-175, 143, 1924),
	Ancient = Vector3.new(6058, 196, 303),
	Mushgrove = Vector3.new(2498, 134, -773),
	Arch = Vector3.new(1007, 135, -1254),
	["Podium 1"] = Vector3.new(-3405, -2263, 3825),
	["Podium 2"] = Vector3.new(-768, -3283, -688),
	["Podium 3"] = Vector3.new(-13538, -11050, 129)
}

-- Fungsi untuk membuat tombol teleport
local function createTeleportButton(locationName, position)
	local button = Instance.new("TextButton")
	button.Parent = scrollingFrame
	button.Size = UDim2.new(0.9, 0, 0, 30)
	button.Text = locationName
	button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.Font = Enum.Font.SourceSansBold
	button.TextSize = 16
	button.LayoutOrder = #scrollingFrame:GetChildren()

	-- Fungsi saat tombol ditekan
	button.MouseButton1Click:Connect(function()
		if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			player.Character.HumanoidRootPart.CFrame = CFrame.new(position)
			selectedPlaceLabel.Text = "Selected Place: " .. locationName
		end
	end)
end

-- Buat tombol teleport berdasarkan daftar lokasi
for name, position in pairs(teleportLocations) do
	createTeleportButton(name, position)
end

-- Toggle UI dengan CanvasGroup
local isVisible = true
toggleButton.MouseButton1Click:Connect(function()
	isVisible = not isVisible
	canvasGroup.Visible = isVisible
	canvasGroup.GroupTransparency = isVisible and 0 or 1
end)
