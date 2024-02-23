local loaders = nil

local function on_built(entity)
	loaders = {}
	local center = entity.position
	local offsets = {
		-- left
		{center.x + (-7.5), center.y + (-2)},
		{center.x + (-7.5), center.y + (-3)},
		{center.x + (-7.5), center.y + (-4)},
		{center.x + (-7.5), center.y + (-5)},
		{center.x + (-7.5), center.y + (1)},
		{center.x + (-7.5), center.y + (2)},
		{center.x + (-7.5), center.y + (3)},
		{center.x + (-7.5), center.y + (4)},
		--right
		{center.x + (7), center.y + (-2)},
		{center.x + (7), center.y + (-3)},
		{center.x + (7), center.y + (-4)},
		{center.x + (7), center.y + (-5)},
		{center.x + (7), center.y + (2)},
		{center.x + (7), center.y + (3)},
		{center.x + (7), center.y + (4)},
		{center.x + (7), center.y + (5)},
	}
	for i, offset in ipairs(offsets) do
		local type = "input"; if i>=9 then type = "output" end
		local loader = entity.surface.create_entity {
			name = "express-loader-z",
			position = offset,
			force = entity.force,
			type = type,
			direction = 2
		}
		loaders.destructible = false
		loaders.minable = false
		loaders[i] = loader
	end
end

script.on_event(defines.events.on_built_entity, function(event)
    if event.created_entity.name == "omega-drill" then
        on_built(event.created_entity)
    end
end)

script.on_event(defines.events.on_robot_built_entity, function(event)
    if event.created_entity.name == "omega-drill" then
        on_built(event.created_entity)

    end
end)

script.on_event(defines.events.on_player_mined_entity, function(event)
    if event.entity.name == "omega-drill" then
        local center = event.entity.position
        for _, entity in pairs(event.entity.surface.find_entities_filtered {
            area = {
                {center.x - 8.8, center.y - 8.8},
                {center.x + 8.8, center.y + 8.8}
            },
            name = "express-loader-z"
        }) do entity.destroy() end
    end
end)

script.on_event(defines.events.on_robot_mined_entity, function(event)
    if event.entity.name == "omega-drill" then
        local center = event.entity.position
        for _, entity in pairs(event.entity.surface.find_entities_filtered {
            area = {
                {center.x - 8.8, center.y - 8.8},
                {center.x + 8.8, center.y + 8.8}
            },
            name = "express-loader-z"
        }) do entity.destroy() end
    end
end)

script.on_event(defines.events.on_entity_died, function(event)
    if event.entity.name == "omega-drill" then
        local center = event.entity.position
        for _, entity in pairs(event.entity.surface.find_entities_filtered {
            area = {
                {center.x - 8.8, center.y - 8.8},
                {center.x + 8.8, center.y + 8.8}
            },
            name = "express-loader-z"
        }) do entity.destroy() end
    end
end)
