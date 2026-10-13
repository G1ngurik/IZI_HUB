--[[
    IZI HUB | STEAL AN EGG (ULTIMATE WORKING)
    Design: Chilli/Spicy Style
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🔥 IZI HUB | Steal an Egg",
   LoadingTitle = "Spicy Style Loading...",
   LoadingSubtitle = "by G1ngurik",
   ConfigurationSaving = {
      Enabled = false
   }
})

local lp = game.Players.LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait()

-- Функция уведомлений (чтобы ты видел, что чит работает)
local function Notify(text)
    Rayfield:Notify({Title = "IZI HUB", Content = text, Duration = 2})
end

-- ВКЛАДКА: ГЛАВНАЯ
local MainTab = Window:CreateTab("🏠 Main", 4483362458)
MainTab:CreateSection("Рабочий Авто-Фарм")

getgenv().FarmActive = false

MainTab:CreateToggle({
   Name = "Авто-Сбор (Умный поиск)",
   CurrentValue = false,
   Flag = "FarmToggle",
   Callback = function(Value)
      getgenv().FarmActive = Value
      if Value then
          Notify("Авто-фарм запущен!")
          task.spawn(function()
              while getgenv().FarmActive do
                  local foundEgg = false
                  -- Ищем яйца везде в Workspace
                  for _, obj in pairs(workspace:GetDescendants()) do
                      if getgenv().FarmActive and obj:IsA("TouchTransmitter") and (obj.Parent.Name:lower():find("egg") or obj.Parent:FindFirstChild("MeshId")) then
                          local egg = obj.Parent
                          if egg:IsA("BasePart") then
                              foundEgg = true
                              print("Нашел яйцо: " .. egg.Name) -- Это появится в F9 консоли
                              
                              -- 1. Летим к яйцу
                              lp.Character.HumanoidRootPart.CFrame = egg.CFrame
                              firetouchinterest(lp.Character.HumanoidRootPart, egg, 0)
                              task.wait(0.1)
                              firetouchinterest(lp.Character.HumanoidRootPart, egg, 1)
                              
                              -- 2. Ищем базу твоей команды для сдачи
                              local team = lp.Team and tostring(lp.Team) or "Neutral"
                              for _, base in pairs(workspace:GetDescendants()) do
                                  if base.Name:lower():find("goal") or base.Name:lower():find("deposit") or base.Name == team then
                                      lp.Character.HumanoidRootPart.CFrame = base.CFrame + Vector3.new(0, 5, 0)
                                      break
                                  end
                              end
                              task.wait(0.5) -- Время на сдачу
                          end
                      end
                  end
                  
                  if not foundEgg then
                      print("Яйца не найдены, жду появления...")
                      task.wait(2)
                  end
                  task.wait(0.1)
              end
          end)
      else
          Notify("Авто-фарм остановлен")
      end
   end,
})

-- ВКЛАДКА: ИГРОК
local PlayerTab = Window:CreateTab("👤 Player", 4483362458)

PlayerTab:CreateSlider({
   Name = "Скорость бега",
   Range = {16, 300},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value)
      lp.Character.Humanoid.WalkSpeed = Value
   end,
})

PlayerTab:CreateButton({
   Name = "Infinite Jump (Прыжки в воздухе)",
   Callback = function()
      game:GetService("UserInputService").JumpRequest:Connect(function()
          lp.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
      end)
      Notify("Бесконечный прыжок включен")
   end,
})

-- ВКЛАДКА: ВИЗУАЛ
local VisualTab = Window:CreateTab("👁 Visuals", 4483362458)

VisualTab:CreateButton({
   Name = "ESP: Подсветить яйца",
   Callback = function()
      local count = 0
      for _, v in pairs(workspace:GetDescendants()) do
         if v.Name:lower():find("egg") and v:IsA("BasePart") then
            if not v:FindFirstChild("Highlight") then
                local h = Instance.new("Highlight", v)
                h.FillColor = Color3.fromRGB(0, 255, 0)
                count = count + 1
            end
         end
      end
      Notify("Подсвечено объектов: " .. count)
   end,
})

Rayfield:Notify({Title = "IZI HUB", Content = "Скрипт готов к работе!", Duration = 5})
