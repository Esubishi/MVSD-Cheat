local Aimbot = {}
Aimbot.ClosestPlayer = function(FOV_Enabled, FOV_Radius)
  local Closest_Target = nil
	local Distance = math.huge
	local MousePosition = Input:GetMouseLocation()

	for _, v in pairs(game.Players:GetPlayers(FOV_Enabled, FOV_Radius)) do
		if v == game.LocalPlayer  then
			continue
		end

		local character = v.Character
		if not character then
			continue
		end

		local humanoid = character:FindFirstChild("Humanoid")
		local head = character:FindFirstChild("Head")

		if not humanoid or humanoid.Health <= 0 or not head then
			continue
		end

		local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
		if not onScreen then
			continue
		end

		local mag = (Vector2.new(screenPos.X, screenPos.Y) - MousePosition).Magnitude
		if FOV_Enabled and mag > FOV_Radius then
			continue
		end
		if mag< Distance then
			Distance = mag
			Closest_Target = v
		end
	end

	return Closest_Target
end

return Aimbot
