--[[
    IZI HUB - Steal an Egg
    Style: Chilli.lua Inspired
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🔥 IZI HUB | Steal an Egg",
   LoadingTitle = "Chilli Style Loading...",
   LoadingSubtitle = "by G1ngurik",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "IZI_HUB_Data",
      FileName = "StealEggConf"
   }
})

local MainTab = Window:CreateTab("🏠 Main", 4483362458) -- Icons: lucide.dev
local PlayerTab = Window:CreateTab("👤 Player", 4483362458)

-- ФУНКЦИИ АВТОФАРМА
MainTab:CreateSection("Automation")

local AutoFarmToggle = MainTab:CreateToggle({
   Name = "Auto Steal Eggs (Safe)",
   CurrentValue = false,
   Flag = "Toggle1",
   Callback = function(Value)
      getgenv().AutoFarm = Value
      while getgenv().AutoFarm do
         task.wait(0.5)
         pcall(function()
            for _, v in pairs(workspace.Eggs:GetChildren()) do
               if getgenv().AutoFarm and v:FindFirstChild("TouchInterest") then
                  -- Телепорт к яйцу
                  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                  firetouchinterest(game.Players.LocalPlayer.Character.Head, v, 0)
                  task.wait(0.1)
                  firetouchinterest(game.Players.LocalPlayer.Character.Head, v, 1)
                  
                  -- Телепорт на базу (возврат)
                  local spawnPos = game.Players.LocalPlayer.RespawnLocation.CFrame
                  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = spawnPos + Vector3.new(0, 3, 0)
                  task.wait(0.5)
               end
            end
         end)
      end
   end,
})

MainTab:CreateButton({
   Name = "Highlight All Eggs (ESP)",
   Callback = function()
      for _, v in pairs(workspace.Eggs:GetChildren()) do
         if not v:FindFirstChild("Highlight") then
            local hl = Instance.new("Highlight", v)
            hl.FillColor = Color3.fromRGB(255, 0, 0)
         end
      end
      Rayfield:Notify({Title = "ESP", Content = "Яйца подсвечены!", Duration = 3})
   end,
})

-- НАСТРОЙКИ ИГРОКА
PlayerTab:CreateSection("Movement")

PlayerTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 300},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "Slider1",
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

PlayerTab:CreateSlider({
   Name = "JumpPower",
   Range = {50, 500},
   Increment = 1,
   Suffix = "Power",
   CurrentValue = 50,
   Flag = "Slider2",
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
   end,
})

Rayfield:Notify({Title = "IZI HUB", Content = "Скрипт успешно запущен!", Duration = 5})
