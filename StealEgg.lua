local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("IZI HUB | Steal an Egg", "Midnight")

local Main = Window:NewTab("Авто-Фарм")
local Section = Main:NewSection("Функции")

Section:NewToggle("Авто-сбор яиц", "Собирает и несет на базу", function(state)
    getgenv().Farm = state
    while getgenv().Farm do
        task.wait(0.1)
        pcall(function()
            for _, egg in pairs(workspace:GetDescendants()) do
                if egg.Name:lower():find("egg") and egg:IsA("BasePart") and egg:FindFirstChild("TouchInterest") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = egg.CFrame
                    firetouchinterest(game.Players.LocalPlayer.Character.Head, egg, 0)
                    task.wait(0.1)
                    -- Телепорт на базу (к спавну)
                    local spawn = game.Players.LocalPlayer.RespawnLocation
                    if spawn then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = spawn.CFrame + Vector3.new(0,3,0)
                    end
                    task.wait(0.3)
                end
            end
        end)
    end
end)

local Player = Window:NewTab("Игрок")
local PSection = Player:NewSection("Настройки")
PSection:NewSlider("Скорость", "Быстрый бег", 500, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)
