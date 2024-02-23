data:extend({
    --- express-loader-z
    {
        type = "loader",
        name = "express-loader-z",
        icon = "__base__/graphics/icons/express-loader.png",
        icon_size = 32,
        --- flags = {"placeable-neutral", "player-creation", "fast-replaceable-no-build-while-moving"},
        minable = {mining_time = 0.1, result = "express-loader-z"},
        max_health = 170,
        filter_count = 5,
        corpse = "small-remnants",
        resistances = {{type = "fire", percent = 60}},
        collision_box = {{-0.4, -0.9}, {0.4, 0.9}},
        selection_box = {{-0.5, -1}, {0.5, 1}},
        animation_speed_coefficient = 32,
        belt_animation_set = express_belt_animation_set,
        fast_replaceable_group = "loader",
        speed = 45, --45
        structure = {
            direction_in = {
                sheet = {
                    filename = "__base__/graphics/entity/loader/loader-structure.png",
                    priority = "extra-high",
                    width = 64,
                    height = 64
                }
            },
            direction_out = {
                sheet = {
                    filename = "__base__/graphics/entity/loader/loader-structure.png",
                    priority = "extra-high",
                    width = 64,
                    height = 64,
                    y = 64
                }
            }
        }
	},
	{
        type = "item",
        name = "express-loader-z",
        icon = "__base__/graphics/icons/express-loader.png",
        icon_size = 32,
        flags = {"hidden"},
        subgroup = "belt",
        order = "d[loader]-c[express-loader]",
        place_result = "express-loader-z",
        stack_size = 50
	}
})

require("prototypes.entity")
require("prototypes.item")
require("prototypes.recipe")
require("prototypes.technology")