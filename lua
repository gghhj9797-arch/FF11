local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")

-- GUI MAIN
local gui = Instance.new("ScreenGui")
gui.Name = "VehicleSpeedGui_TH"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- ==========================================
-- 0. WELCOME IMAGE POPUP (แสดงรูปภาพ 2 วินาที)
-- ==========================================
local welcomeImg = Instance.new("ImageLabel", gui)
welcomeImg.Name = "WelcomePopup"
welcomeImg.Size = UDim2.new(0, 300, 0, 300) -- ขนาดของรูปภาพ
welcomeImg.Position = UDim2.new(0.5, -150, 0.5, -150) -- จัดให้อยู่กลางหน้าจอ
welcomeImg.BackgroundTransparency = 1
welcomeImg.Image = "rbxassetid://121585058694718"
welcomeImg.ImageTransparency = 0
welcomeImg.ZIndex = 10

-- ระบบนับเวลาแสดงรูป 2 วินาที แล้วจางหายไป
task.spawn(function()
	task.wait(2) -- แสดงผลเป็นเวลา 2 วินาที
	
	local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local tween = TweenService:Create(welcomeImg, tweenInfo, {ImageTransparency = 1})
	tween:Play()
	
	tween.Completed:Connect(function()
		welcomeImg:Destroy()
	end)
end)

-- 1. MAIN OPEN BUTTON (ปุ่มเปิด/ปิดเมนูหลัก)
local openBtn = Instance.new("TextButton", gui)
openBtn.Size = UDim2.new(0, 110, 0, 40)
openBtn.Position = UDim2.new(0.02, 0, 0.2, 0)
openBtn.Text = "⚡ ไนตรัส V1"
openBtn.Font = Enum.Font.GothamBold
openBtn.TextSize = 12
openBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
openBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(0, 10)

local openStroke = Instance.new("UIStroke", openBtn)
openStroke.Color = Color3.fromRGB(255, 215, 0)
openStroke.Thickness = 1.5

-- 2. SEPARATE NITRO BUTTON (ปุ่มลอยแยกข้างนอก - ไนตรัสแยก)
local nitroBtn = Instance.new("TextButton", gui)
nitroBtn.Size = UDim2.new(0, 120, 0, 40)
nitroBtn.Position = UDim2.new(0.02, 0, 0.27, 0)
nitroBtn.Text = "🚀 ไนตรัส : ปิด"
nitroBtn.Font = Enum.Font.GothamBold
nitroBtn.TextSize = 12
nitroBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 70)
nitroBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", nitroBtn).CornerRadius = UDim.new(0, 10)

local nitroStroke = Instance.new("UIStroke", nitroBtn)
nitroStroke.Color = Color3.fromRGB(60, 60, 70)
nitroStroke.Thickness = 1.5

-- 3. FRAME MAIN (หน้าต่างเมนูหลัก)
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 240, 0, 280)
frame.Position = UDim2.new(0.12, 0, 0.2, 0)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
frame.Active = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local frameStroke = Instance.new("UIStroke", frame)
frameStroke.Color = Color3.fromRGB(50, 50, 60)
frameStroke.Thickness = 1

-- TITLE
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, -40, 0, 35)
title.Position = UDim2.new(0, 12, 0, 2)
title.Text = "เมนูปรับความเร็วรถ"
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextColor3 = Color3.fromRGB(200, 200, 210)
title.TextXAlignment = Enum.TextXAlignment.Left
title.BackgroundTransparency = 1

-- CLOSE BUTTON
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -32, 0, 8)
closeBtn.Text = "✕"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 12
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 80)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)

-- INPUT BOX
local input = Instance.new("TextBox", frame)
input.Size = UDim2.new(1, -24, 0, 38)
input.Position = UDim2.new(0, 12, 0, 40)
input.PlaceholderText = "ป้อนความเร็ว (สูงสุด 400)"
input.Text = ""
input.Font = Enum.Font.GothamMedium
input.TextSize = 12
input.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
input.TextColor3 = Color3.fromRGB(255, 255, 255)
input.PlaceholderColor3 = Color3.fromRGB(120, 120, 140)
Instance.new("UICorner", input).CornerRadius = UDim.new(0, 8)

local inputStroke = Instance.new("UIStroke", input)
inputStroke.Color = Color3.fromRGB(45, 45, 55)

-- TOGGLE SPEED BUTTON (ปุ่มไนตรัสในเมนู)
local button = Instance.new("TextButton", frame)
button.Size = UDim2.new(1, -24, 0, 38)
button.Position = UDim2.new(0, 12, 0, 86)
button.Text = "🚀 ไนตรัส : ปิด"
button.Font = Enum.Font.GothamBold
button.TextSize = 12
button.BackgroundColor3 = Color3.fromRGB(220, 50, 70)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)

-- TOGGLE GODMODE BUTTON (ปุ่มกันตาย)
local godBtn = Instance.new("TextButton", frame)
godBtn.Size = UDim2.new(1, -24, 0, 38)
godBtn.Position = UDim2.new(0, 12, 0, 132)
godBtn.Text = "🛡️ กันตาย : ปิด"
godBtn.Font = Enum.Font.GothamBold
godBtn.TextSize = 12
godBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 70)
godBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", godBtn).CornerRadius = UDim.new(0, 8)

-- TOGGLE FPS BOOST BUTTON
local fpsBtn = Instance.new("TextButton", frame)
fpsBtn.Size = UDim2.new(1, -24, 0, 38)
fpsBtn.Position = UDim2.new(0, 12, 0, 178)
fpsBtn.Text = "📱 เร่ง FPS 1000+ : ปิด"
fpsBtn.Font = Enum.Font.GothamBold
fpsBtn.TextSize = 12
fpsBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 70)
fpsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", fpsBtn).CornerRadius = UDim.new(0, 8)

-- CREDIT
local credit = Instance.new("TextLabel", frame)
credit.Size = UDim2.new(1, 0, 0, 20)
credit.Position = UDim2.new(0, 0, 1, -24)
credit.Text = "สคริปต์ปรับความเร็ว v2 • โดย เอก"
credit.TextColor3 = Color3.fromRGB(255, 215, 0)
credit.BackgroundTransparency = 1
credit.Font = Enum.Font.GothamBold
credit.TextSize = 11

-- SYSTEM DRAG
local function dragify(obj)
	local dragging, start, startPos, dragInput

	obj.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			start = i.Position
			startPos = obj.Position
		end
	end)

	obj.InputChanged:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then
			dragInput = i
		end
	end)

	UIS.InputChanged:Connect(function(i)
		if i == dragInput and dragging then
			local delta = i.Position - start
			obj.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)

	UIS.InputEnded:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)
end

dragify(frame)
dragify(openBtn)
dragify(nitroBtn)

-- OPEN / CLOSE
frame.Visible = true

openBtn.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
end)

closeBtn.MouseButton1Click:Connect(function()
	frame.Visible = false
end)

-- VEHICLE DETECTION
local function getVehicle()
	local char = player.Character
	if not char then return nil end

	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hum then return nil end

	local seat = hum.SeatPart
	if seat and seat:IsA("VehicleSeat") then
		return seat
	end
	return nil
end

-- STATE & TOGGLES
local enabled = false
local godmodeEnabled = false
local fpsBoostEnabled = false
local targetSpeed = 0

input.FocusLost:Connect(function()
	local num = tonumber(input.Text)
	if num then
		targetSpeed = math.min(num, 400)
	else
		targetSpeed = 0
	end
end)

local function setSpeedState(newState)
	enabled = newState
	if enabled then
		button.Text = "⚡ ไนตรัส : เปิด"
		button.BackgroundColor3 = Color3.fromRGB(40, 190, 110)
		
		nitroBtn.Text = "⚡ ไนตรัส : เปิด"
		nitroBtn.BackgroundColor3 = Color3.fromRGB(40, 190, 110)
		nitroStroke.Color = Color3.fromRGB(100, 255, 150)
	else
		button.Text = "🚀 ไนตรัส : ปิด"
		button.BackgroundColor3 = Color3.fromRGB(220, 50, 70)
		
		nitroBtn.Text = "🚀 ไนตรัส : ปิด"
		nitroBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 70)
		nitroStroke.Color = Color3.fromRGB(60, 60, 70)
	end
end

button.MouseButton1Click:Connect(function()
	setSpeedState(not enabled)
end)

nitroBtn.MouseButton1Click:Connect(function()
	setSpeedState(not enabled)
end)

-- ระบบสวิตช์เปิด/ปิด กันตาย
godBtn.MouseButton1Click:Connect(function()
	godmodeEnabled = not godmodeEnabled

	if godmodeEnabled then
		godBtn.Text = "🛡️ กันตาย : เปิด"
		godBtn.BackgroundColor3 = Color3.fromRGB(40, 190, 110)
	else
		godBtn.Text = "🛡️ กันตาย : ปิด"
		godBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 70)
	end
end)

-- UNLIMITED FPS BOOST (1000+ FPS)
local function optimizeGraphics(enable)
	if setfpscap then
		setfpscap(enable and 1000 or 60)
	end

	if settings and settings():GetService("RenderSettings") then
		settings():GetService("RenderSettings").QualityLevel = enable and Enum.QualityLevel.Level01 or Enum.QualityLevel.Automatic
	end

	Lighting.GlobalShadows = not enable
	Lighting.CastShadows = not enable
	
	for _, effect in ipairs(Lighting:GetChildren()) do
		if effect:IsA("PostEffect") or effect:IsA("Atmosphere") or effect:IsA("Sky") then
			effect.Enabled = not enable
		end
	end

	if enable then
		collectgarbage("collect")

		for _, obj in ipairs(workspace:GetDescendants()) do
			if obj:IsA("BasePart") and not obj:IsA("MeshPart") then
				obj.Material = Enum.Material.SmoothPlastic
			elseif obj:IsA("Texture") or obj:IsA("Decal") then
				obj.Transparency = 1
			elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") then
				obj.Enabled = false
			end
		end
	else
		for _, obj in ipairs(workspace:GetDescendants()) do
			if obj:IsA("Texture") or obj:IsA("Decal") then
				obj.Transparency = 0
			elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") then
				obj.Enabled = true
			end
		end
	end
end

fpsBtn.MouseButton1Click:Connect(function()
	fpsBoostEnabled = not fpsBoostEnabled

	if fpsBoostEnabled then
		fpsBtn.Text = "🚀 เร่ง FPS 1000+ : เปิด"
		fpsBtn.BackgroundColor3 = Color3.fromRGB(40, 190, 110)
		optimizeGraphics(true)
	else
		fpsBtn.Text = "📱 เร่ง FPS 1000+ : ปิด"
		fpsBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 70)
		optimizeGraphics(false)
	end
end)

-- ANTI-AFK SAFEGUARD
player.Idled:Connect(function()
	VirtualUser:CaptureController()
	VirtualUser:ClickButton2(Vector2.new())
end)

-- GOD MODE LOOP (ระบบทำงานกันตาย)
RunService.Stepped:Connect(function()
	if not godmodeEnabled then return end

	local char = player.Character
	if not char then return end

	local hum = char:FindFirstChildOfClass("Humanoid")
	local root = char:FindFirstChild("HumanoidRootPart")

	if hum and hum.Health < hum.MaxHealth and hum.Health > 0 then
		hum.Health = hum.MaxHealth
	end

	if root and root.Position.Y < -200 then
		root.AssemblyLinearVelocity = Vector3.zero
		root.CFrame = CFrame.new(root.Position.X, 50, root.Position.Z)
	end
end)

-- SPEED CORE LOOP (ระบบความเร็ว)
RunService.Stepped:Connect(function()
	local seat = getVehicle()
	if not seat then return end

	if enabled and targetSpeed > 0 then
		seat.Throttle = 1

		local dir = seat.CFrame.LookVector
		local vel = seat.AssemblyLinearVelocity
		local forwardSpeed = vel:Dot(dir)
		local speedError = targetSpeed - forwardSpeed

		local newVelocity = vel + dir * (speedError * 0.12)
		
		if newVelocity.Magnitude > 550 then
			newVelocity = newVelocity.Unit * 550
		end

		seat.AssemblyLinearVelocity = newVelocity
	end
end)

-- CREDIT ANIMATION
task.spawn(function()
	local hue = 0
	while true do
		hue = (hue + 0.02) % 1
		credit.TextColor3 = Color3.fromHSV(hue, 0.7, 1)
		task.wait(0.1)
	end
end)
