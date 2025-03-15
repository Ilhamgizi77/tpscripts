local InsertService = game:GetService("InsertService")
local Players = game:GetService("Players")

local assetId = 113243272093228
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local success, asset = pcall(function()
    return InsertService:LoadAsset(assetId)
end)

if success and asset then
    local ui = asset:GetChildren()[1] -- Ambil UI dari model
    if ui and ui:IsA("ScreenGui") then
        ui.Parent = playerGui
    end
end