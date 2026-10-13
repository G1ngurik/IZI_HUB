--[[
    IZI HUB | STEAL AN EGG (SPECIAL EDITION)
    Logic: Spicy Hub / Chilli.lua
    PlaceID: 107778070777162
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🔥 IZI HUB | Steal An Egg",
   LoadingTitle = "Spicy Style Loading...",
   LoadingSubtitle = "by G1ngurik",
   ConfigurationSaving = {
      Enabled = false
   }
})

local lp = game.Players.LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait()

-- Переменные фарма
getgenv().AutoFarm = false
getgenv().WalkSpeed = 16

-- ФУНКЦИЯ ПОИСКА ТВОЕГО ГНЕЗДА (НЕСТА)
local function getMyNest()
    local teamColor = tostring(lp.TeamColor)
    for _, nest in pairs(workspace.Map.Nests:GetChildren()) do
        if tostring(nest.Color) == teamColor or nest.Name:find(tostring(lp.Team)) then
            return nest
        end
    end
    return nil
end

-- ВКЛАДКА МЕЙН
local MainTab = Window:CreateTab("🏠 Главная", 4483362458)
MainTab:CreateSection("Мощный Авто-Фарм")

MainTab:CreateToggle({
   Name = "Авто-Сбор и Доставка (OP)",
   CurrentValue = false,
   Flag = "FarmToggle",
   Callback = function(Value)
      getgenv().AutoFarm = Value
      task.spawn(function()
         while getgenv().AutoFarm do
            pcall(function()
               -- Ищем яйца именно там, где они спавнятся в этой игре
               local eggs = workspace.Map.Eggs:GetChildren()
               local nest = getMyNest()
               
               if #eggs > 0 and nest then
                  for _, egg in pairs(eggs) do
                     if getgenv().AutoFarm and egg:IsA("BasePart") then
                        -- 1. Летим к яйцу (чуть выше, чтобы не провалиться)
                        lp.Character.HumanoidRootPart.CFrame = egg.CFrame * CFrame.new(0, 2, 0)
                        task.wait(0.1)
                        
                        -- 2. Касаемся яйца (симуляция)
                        firetouchinterest(lp.Character.HumanoidRootPart, egg, 0)
                        firetouchinterest(lp.Character.HumanoidRootPart, egg, 1)
                        task.wait(0.1)
                        
                        -- 3. Летим в своё гнездо сдать яйцо
                        lp.Character.HumanoidRootPart.CFrame = nest.CFrame * CFrame.new(0, 3, 0)
                        task.wait(0.3)
                        
                        if not getgenv().AutoFarm then break end
                     end
                  end
               else
                  -- Если яиц нет в центре, ищем украденные у других
                  for _, otherNest in pairs(workspace.Map.Nests:GetChildren()) do
                      if tostring(otherNest.Color) ~= tostring(lp.TeamColor) then
                          local stolenEggs = otherNest:GetChildren()
                          for _, sEgg in pairs(stolenEggs) do
                              if sEgg:IsA("BasePart") and getgenv().AutoFarm then
                                  lp.Character.HumanoidRootPart.CFrame = sEgg.CFrame
                                  task.wait(0.1)
                                  lp.Character.HumanoidRootPart.CFrame = nest.CFrame * CFrame.new(0, 3, 0)
                                  task.wait(0.3)
                              end
                          end
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
local PlayerTab = Window:CreateTab("👤 Игрок", 4483362458)

PlayerTab:CreateSlider({
   Name = "Скорость бега",
   Range = {16, 300},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value)
      getgenv().WalkSpeed = Value
      lp.Character.Humanoid.WalkSpeed = Value
   end,
})

-- Анти-кик за скорость (обход)
task.spawn(function()
    while task.wait() do
        if lp.Character and lp.Character:FindFirstChild("Humanoid") then
            lp.Character.Humanoid.WalkSpeed = getgenv().WalkSpeed
        end
    end
end)

PlayerTab:CreateButton({
   Name = "Бесконечный прыжок",
   Callback = function()
      game:GetService("UserInputService").JumpRequest:Connect(function()
          lp.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
      end)
   end,
})

-- ВКЛАДКА ВИЗУАЛ
local VisualTab = Window:CreateTab("👁 Визуал", 4483362458)

VisualTab:CreateButton({
   Name = "ESP: Подсветить яйца",
   Callback = function()
      for _, v in pairs(workspace.Map.Eggs:GetChildren()) do
         if not v:FindFirstChild("Highlight") then
            local h = Instance.new("Highlight", v)
            h.FillColor = Color3.fromRGB(255, 255, 0)
         end
      end
   end,
})

Rayfield:Notify({Title = "IZI HUB", Content = "Скрипт настроен под Steal An Egg!", Duration = 5})
