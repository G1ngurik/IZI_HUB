--[[
    IZI HUB | Steal an Egg
    Version: 1.0
    Author: G1ngurik
]]

-- 1. Загрузка библиотеки интерфейса
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- 2. Создание главного окна
local Window = Rayfield:CreateWindow({
   Name = "🔥 IZI HUB | Steal an Egg",
   LoadingTitle = "Загрузка IZI HUB...",
   LoadingSubtitle = "by G1ngurik",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "IZI_HUB_Data",
      FileName = "StealEgg"
   }
})

-- Переменные для работы функций
getgenv().AutoFarm = false
local lp = game.Players.LocalPlayer

-- 3. Вкладка "Главная"
local MainTab = Window:CreateTab("🏠 Главная", 4483362458)
MainTab:CreateSection("Автоматизация")

-- Функция Авто-фарма
MainTab:CreateToggle({
   Name = "Авто-сбор яиц (Auto-Farm)",
   CurrentValue = false,
   Flag = "AutoFarmFlag",
   Callback = function(Value)
      getgenv().AutoFarm = Value
      
      -- Цикл, который работает пока включен тумблер
      task.spawn(function()
         while getgenv().AutoFarm do
            task.wait(0.3) -- Небольшая задержка, чтобы не кикнуло
            pcall(function()
               -- Ищем все яйца в папке Eggs (стандарт для этой игры)
               local eggsFolder = workspace:FindFirstChild("Eggs")
               if eggsFolder then
                  for _, egg in pairs(eggsFolder:GetChildren()) do
                     if getgenv().AutoFarm and egg:IsA("BasePart") and egg:FindFirstChild("TouchInterest") then
                        -- 1. Летим к яйцу
                        lp.Character.HumanoidRootPart.CFrame = egg.CFrame
                        firetouchinterest(lp.Character.HumanoidRootPart, egg, 0)
                        task.wait(0.1)
                        firetouchinterest(lp.Character.HumanoidRootPart, egg, 1)
                        
                        -- 2. Летим на базу сдать яйцо (к твоему спавну)
                        local mySpawn = lp.RespawnLocation
                        if mySpawn then
                           lp.Character.HumanoidRootPart.CFrame = mySpawn.CFrame + Vector3.new(0, 3, 0)
                        end
                        task.wait(0.5) -- Ждем сдачи яйца
                     end
                  end
               end
            end)
         end
      end)
   end,
})

-- 4. Вкладка "Визуал"
local VisualTab = Window:CreateTab("👁 Визуал", 4483362458)
VisualTab:CreateSection("ESP")

VisualTab:CreateButton({
   Name = "Подсветить яйца (ESP)",
   Callback = function()
      local eggsFolder = workspace:FindFirstChild("Eggs")
      if eggsFolder then
         for _, egg in pairs(eggsFolder:GetChildren()) do
            if not egg:FindFirstChild("Highlight") then
               local hl = Instance.new("Highlight", egg)
               hl.FillColor = Color3.fromRGB(255, 255, 0) -- Желтый цвет
               hl.OutlineColor = Color3.fromRGB(255, 255, 255)
            end
         end
         Rayfield:Notify({Title = "Успех", Content = "Все яйца теперь видны!", Duration = 3})
      end
   end,
})

-- 5. Вкладка "Персонаж"
local PlayerTab = Window:CreateTab("👤 Персонаж", 4483362458)
PlayerTab:CreateSection("Характеристики")

PlayerTab:CreateSlider({
   Name = "Скорость бега",
   Range = {16, 500},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Callback = function(Value)
      lp.Character.Humanoid.WalkSpeed = Value
   end,
})

PlayerTab:CreateSlider({
   Name = "Сила прыжка",
   Range = {50, 500},
   Increment = 1,
   Suffix = "Power",
   CurrentValue = 50,
   Callback = function(Value)
      lp.Character.Humanoid.JumpPower = Value
   end,
})

-- Уведомление при запуске
Rayfield:Notify({
   Title = "IZI HUB Загружен!",
   Content = "Приятной игры, G1ngurik!",
   Duration = 5,
   Image = 4483362458,
})
