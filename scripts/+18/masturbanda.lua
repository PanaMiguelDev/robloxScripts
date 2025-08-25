-- LocalScript para crear una Tool simple que ejecuta animación
-- Coloca este script en StarterPlayerScripts

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Variables para la animación
local animationTrack = nil
local animationId = "rbxassetid://79037075891654"
local tool = nil

-- Función cuando se equipa la tool
local function onToolEquipped()
	local character = player.Character
	if character then
		local humanoid = character:FindFirstChild("Humanoid")
		if humanoid then
			-- Crear y cargar la animación
			local animation = Instance.new("Animation")
			animation.AnimationId = animationId

			animationTrack = humanoid:LoadAnimation(animation)
			animationTrack.Looped = true -- Se repite mientras esté equipada
			animationTrack.Priority = Enum.AnimationPriority.Action

			-- Reproducir la animación
			animationTrack:Play()
			print("Animación iniciada")
		end
	end
end

-- Función cuando se desequipa la tool
local function onToolUnequipped()
	if animationTrack then
		animationTrack:Stop()
		animationTrack = nil
		print("Animación detenida")
	end
end

-- Función para crear la tool
local function createTool()
	-- Crear la Tool
	tool = Instance.new("Tool")
	tool.Name = "AnimationTool"
	tool.RequiresHandle = false -- No necesita handle
	tool.CanBeDropped = true

	-- Conectar eventos directamente desde este script
	tool.Equipped:Connect(onToolEquipped)
	tool.Unequipped:Connect(onToolUnequipped)

	return tool
end

-- Función para añadir la tool al backpack del jugador
local function addToolToPlayer()
	if player.Character then
		local backpack = player:FindFirstChild("Backpack")
		if backpack then
			local newTool = createTool()
			newTool.Parent = backpack
			print("Tool añadida al backpack")
		end
	end
end

-- Añadir la tool cuando el jugador aparezca
player.CharacterAdded:Connect(function()
	-- Esperar un poco para asegurar que el backpack esté listo
	wait(1)
	addToolToPlayer()
end)

-- Si el jugador ya tiene un personaje
if player.Character then
	addToolToPlayer()
end