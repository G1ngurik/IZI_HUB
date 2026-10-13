--[[
    IZI HUB | STEAL AN EGG (REMASTERED)
    Based on Spicy Hub (Chilli.lua) Logic
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🔥 IZI HUB | Steal an Egg",
   LoadingTitle = "Spicy Style Loading...",
   LoadingSubtitle = "by G1ngurik",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "IZI_Data"
   }
})

local lp = game.Players.LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait()

-- ФУНКЦИЯ ПОИСКА БАЗЫ (ВАЖНО ДЛЯ РАБОТЫ)
local function getMyBase()
    local team = lp.Team
    if team then
        -- Ищем зону сдачи яиц по названию команды или цвету
        for _, v in pairs(workspace:GetDescendants()) do
            if v.Name == "Goal" or v.Name == "Deposit" or v.Name == tostring(team) then
                return v
            end
        end
    end
    -- Если не нашли, возвращаем спавн
    return lp.RespawnLocation
end

-- ВКЛАДКА МЕЙН
local MainTab = Window:CreateTab("🏠 Main", 4483362458)
MainTab:CreateSection("Авто-Фарм")

getgenv().AutoSteal = false

MainTab:CreateToggle({
   Name = "Auto Steal Eggs (РАБОТАЕТ)",
   CurrentValue = false,
   Flag = "StealToggle",
   Callback = function(Value)
      getgenv().AutoSteal = Value
      task.spawn(function()
         while getgenv().AutoSteal do
            pcall(function()
               -- Ищем все яйца на карте
               for _, obj in pairs(workspace:GetDescendants()) do
                  if getgenv().AutoSteal and obj:IsA("TouchTransmitter") and obj.Parent.Name:lower():find("egg") then
                     local egg = obj.Parent
                     local hrp = lp.Character:FindFirstChild("HumanoidRootPart")
                     local base = getMyBase()
                     
                     if hrp and egg then
                        -- Летим к яйцу
                        hrp.CFrame = egg.CFrame
                        task.wait(0.2)
                        
                        -- Летим на базу сдать
                        if base then
                            hrp.CFrame = (base:IsA("BasePart") and base.CFrame or base.CFrame) + Vector3.new(0, 3, 0)
                        end
                        task.wait(0.3)
                     end
                  end
               end
            end)
            task.wait(0.1)
         end
      end)
   end,
})

-- ВКЛАДКА ИГРОК
local PlayerTab = Window:CreateTab("👤 Player", 4483362458)

PlayerTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 300},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value)
      lp.Character.Humanoid.WalkSpeed = Value
   end,
})

PlayerTab:CreateButton({
   Name = "Infinite Jump (Бесконечный прыжок)",
   Callback = function()
      game:GetService("UserInputService").JumpRequest:Connect(function()
          lp.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
      end)
   end,
})

-- ВКЛАДКА ВИЗУАЛ
local VisualTab = Window:CreateTab("👁 Visuals", 4483362458)

VisualTab:CreateButton({
   Name = "ESP: Показать все яйца",
   Callback = function()
      for _, v in pairs(workspace:GetDescendants()) do
         if v.Name:lower():find("egg") and v:IsA("BasePart") then
            if not v:FindFirstChild("Highlight") then
                local h = Instance.new("Highlight", v)
                h.FillColor = Color3.fromRGB(255, 0, 0)
            end
         end
      end
   end,
})

Rayfield:LoadConfiguration()
