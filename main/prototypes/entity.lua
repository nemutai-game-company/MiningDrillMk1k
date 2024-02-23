--the fuck did the devs do to the code while I wasn't looking?

require ("__base__.prototypes.entity.pipecovers")

local hit_effects = require ("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")


function omega_drill_status_colors()
  return
  {
    -- If no_power, idle, no_minable_resources, disabled, insufficient_input or full_output is used, always_draw of corresponding layer must be set to true to draw it in those states.

    no_power = { 0, 0, 0, 0 },                  -- If no_power is not specified or is nil, it defaults to clear color {0,0,0,0}

    idle = { 1, 0, 0, 1 },                      -- If idle is not specified or is nil, it defaults to white.
    no_minable_resources = { 1, 0, 0, 1 },      -- If no_minable_resources, disabled, insufficient_input or full_output are not specified or are nil, they default to idle color.
    insufficient_input = { 1, 1, 0, 1 },
    full_output = { 1, 1, 0, 1 },
    disabled = { 1, 1, 0, 1 },

    working = { 0, 1, 0, 1 },                   -- If working is not specified or is nil, it defaults to white.
    low_power = { 1, 1, 0, 1 },                 -- If low_power is not specified or is nil, it defaults to working color.
  }
end

function omega_drill_status_leds_working_visualisation()
  local led_blend_mode = nil -- "additive"
  local led_tint = {1,1,1,1}
  return
  {
    apply_tint = "status",
    always_draw = true,
    draw_as_light = true,
    north_animation =
    {
      filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-N-light.png",
      width = 32,
      height = 32,
      blend_mode = led_blend_mode,
      tint = led_tint,
      shift = util.by_pixel(140, 140), --raw guess
    },
    east_animation =
    {
      filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-E-light.png",
      width = 32,
      height = 34,
      blend_mode = led_blend_mode,
      tint = led_tint,
      shift = util.by_pixel(140, 140), --raw guess
    },
    south_animation =
    {
      filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-S-light.png",
      width = 38,
      height = 46,
      blend_mode = led_blend_mode,
      tint = led_tint,
      shift = util.by_pixel(140, 140), --raw guess
    },
    west_animation =
    {
      filename = "__base__/graphics/entity/electric-mining-drill/hr-electric-mining-drill-W-light.png",
      width = 32,
      height = 34,
      blend_mode = led_blend_mode,
      tint = led_tint,
      shift = util.by_pixel(140, 140), --raw guess
    }
  }
end

function omega_drill_add_light_offsets(t)
  t.north_position = { 5,  5}
  t.east_position =  { 5,  5}
  t.south_position = { 5,  5}
  t.west_position =  { 5,  5}
  return t
end

local omega_drill_secondary_light =
  omega_drill_add_light_offsets(
  {
    always_draw = true,
    apply_tint = "status",
    light = { intensity = 0.2, size = 10, color={r=1, g=1, b=1}, minimum_darkness = 0.1 }
  })

data:extend(
{
  {
    type = "mining-drill",
    name = "omega-drill",
    icon = "__OmegaDrill__/graphics/icons/omega-drill.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 25, result = "omega-drill"},
    max_health = 7500,
    resource_categories = {"basic-solid"},
    corpse = "big-remnants",
    dying_explosion = "massive-explosion",
    collision_box = {{ -7.3, -7.3}, {7.3, 7.3}},
    selection_box = {{ -7.5, -7.5}, {7.5, 7.5}},
    input_fluid_box =
    {
      production_type = "input-output",
      pipe_picture = assembler2pipepictures(),
      pipe_covers = pipecoverspictures(),
      base_area = 1,
      height = 2,
      base_level = -1,
      pipe_connections =
      {
        { position = {-8, 0} },
        { position = {8, 0} },
        { position = {0, 8} },
      }
    },
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/electric-mining-drill.ogg",
        volume = 1
      },
      audible_distance_modifier = 1,
      fade_in_ticks = 4,
      fade_out_ticks = 20
    },
    vehicle_impact_sound = sounds.generic_impact,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    
    graphics_set =
    {
--    drilling_vertical_movement_duration = 10 / electric_drill_animation_speed,
--    animation_progress = 1,
--    min_animation_progress = 0,
--    max_animation_progress = 30,

      status_colors = omega_drill_status_colors(),

      circuit_connector_layer = "object",
      circuit_connector_secondary_draw_order = { north = 70, east = 127, south = 127, west = 127 },
      animation =
      {
        north = 
        { --here we go again
        layers =
          {
            {
              priority = "high",
              filename = "__OmegaDrill__/graphics/omega-drill/anim.png",
              line_length = 3,
              width = 600,
              height = 600,
              frame_count = 8,
              animation_speed = 0.25,
              direction_count = 1,
              shift = { 0 , 0 },
            },
            {
              priority = "high",
              --filename = "__OmegaDrill__/graphics/omega-drill/pn.png",
              --line_length = 1,
              width = 600,
              height = 600,
              frame_count = 8,
              animation_speed = 0.25,
              direction_count = 1,
              shift = { 0 , 0 },
              stripes = util.multiplystripes(8,
              {
                {
                 filename = "__OmegaDrill__/graphics/omega-drill/pn.png",
                 width_in_frames = 1,
                 height_in_frames = 1,
                },
              }),
            },
          }
        },
        east = 
        {
        layers =
          {
            {
              priority = "high",
              filename = "__OmegaDrill__/graphics/omega-drill/anim.png",
              line_length = 3,
              width = 600,
              height = 600,
              frame_count = 8,
              animation_speed = 0.25,
              direction_count = 1,
              shift = { 0 , 0 },
            },
            {
              priority = "high",
              --filename = "__OmegaDrill__/graphics/omega-drill/pe.png",
              --line_length = 1,
              width = 600,
              height = 600,
              frame_count = 8,
              animation_speed = 0.25,
              direction_count = 1,
              shift = { 0 , 0 },
              stripes = util.multiplystripes(8,
              {
                {
                 filename = "__OmegaDrill__/graphics/omega-drill/pe.png",
                 width_in_frames = 1,
                 height_in_frames = 1,
                },
              }),
            },
          }
        },
        south = 
        {
        layers =
          {
            {
              priority = "high",
              filename = "__OmegaDrill__/graphics/omega-drill/anim.png",
              line_length = 3,
              width = 600,
              height = 600,
              frame_count = 8,
              animation_speed = 0.25,
              direction_count = 1,
              shift = { 0 , 0 },
            },
            {
              priority = "high",
              --filename = "__OmegaDrill__/graphics/omega-drill/ps.png",
              --line_length = 1,
              width = 600,
              height = 600,
              frame_count = 8,
              animation_speed = 0.25,
              direction_count = 1,
              shift = { 0 , 0 },
              stripes = util.multiplystripes(8,
              {
                {
                 filename = "__OmegaDrill__/graphics/omega-drill/ps.png",
                 width_in_frames = 1,
                 height_in_frames = 1,
                },
              }),
            },
          }
        },
        west = 
        {
        layers =
          {
            {
              priority = "high",
              filename = "__OmegaDrill__/graphics/omega-drill/anim.png",
              line_length = 3,
              width = 600,
              height = 600,
              frame_count = 8,
              animation_speed = 0.25,
              direction_count = 1,
              shift = { 0 , 0 },
            },
            {
              priority = "high",
              --filename = "__OmegaDrill__/graphics/omega-drill/pw.png",
              --line_length = 1,
              width = 600,
              height = 600,
              frame_count = 8,
              animation_speed = 0.25,
              direction_count = 1,
              shift = { 0 , 0 },
              stripes = util.multiplystripes(8,
              {
                {
                 filename = "__OmegaDrill__/graphics/omega-drill/pw.png",
                 width_in_frames = 1,
                 height_in_frames = 1,
                },
              }),
            },
          }
        }
        
      },
      
      
      working_visualisations =
      {
        -- LEDs
        omega_drill_status_leds_working_visualisation(),

        -- light
        --electric_mining_drill_primary_light,
        omega_drill_secondary_light
      }
        
    },
    wet_mining_graphics_set =
    {
--    drilling_vertical_movement_duration = 10 / electric_drill_animation_speed,
--    animation_progress = 1,
--    min_animation_progress = 0,
--    max_animation_progress = 30,

      status_colors = omega_drill_status_colors(),

      circuit_connector_layer = "object",
      circuit_connector_secondary_draw_order = { north = 70, east = 127, south = 127, west = 127 },
      animation =
      {
        north = 
        { --here we go yeti again
        layers =
          {
            {
              priority = "high",
              filename = "__OmegaDrill__/graphics/omega-drill/wanim.png",
              line_length = 3,
              width = 600,
              height = 600,
              frame_count = 8,
              animation_speed = 0.25,
              direction_count = 1,
              shift = { 0 , 0 },
            },
			
            {
              priority = "high",
              filename = "__OmegaDrill__/graphics/omega-drill/on.png",
              line_length = 1,
              width = 600,
              height = 600,
              frame_count = 1,
              animation_speed = 0.25,
              direction_count = 1,
              shift = { 0 , 0 },
              repeat_count = 8,
            },
          }
        },
        east = 
        {
        layers =
          {
            {
              priority = "high",
              filename = "__OmegaDrill__/graphics/omega-drill/wanim.png",
              line_length = 3,
              width = 600,
              height = 600,
              frame_count = 8,
              animation_speed = 0.25,
              direction_count = 1,
              shift = { 0 , 0 },
            },
			
            {
              priority = "high",
              filename = "__OmegaDrill__/graphics/omega-drill/oe.png",
              line_length = 1,
              width = 600,
              height = 600,
              frame_count = 1,
              animation_speed = 0.25,
              direction_count = 1,
              shift = { 0 , 0 },
              repeat_count = 8,
            },
          }
        },
        south = 
        {
        layers =
          {
            {
              priority = "high",
              filename = "__OmegaDrill__/graphics/omega-drill/wanim.png",
              line_length = 3,
              width = 600,
              height = 600,
              frame_count = 8,
              animation_speed = 0.25,
              direction_count = 1,
              shift = { 0 , 0 },
            },
			
            {
              priority = "high",
              filename = "__OmegaDrill__/graphics/omega-drill/os.png",
              line_length = 1,
              width = 600,
              height = 600,
              frame_count = 1,
              animation_speed = 0.25,
              direction_count = 1,
              shift = { 0 , 0 },
              repeat_count = 8,
            },
          }
        },
        west = 
        {
        layers =
          {
            {
              priority = "high",
              filename = "__OmegaDrill__/graphics/omega-drill/wanim.png",
              line_length = 3,
              width = 600,
              height = 600,
              frame_count = 8,
              animation_speed = 0.25,
              direction_count = 1,
              shift = { 0 , 0 },
            },
			
            {
              priority = "high",
              filename = "__OmegaDrill__/graphics/omega-drill/ow.png",
              line_length = 1,
              width = 600,
              height = 600,
              frame_count = 1,
              animation_speed = 0.25,
              direction_count = 1,
              shift = { 0 , 0 },
              repeat_count = 8,
            },
          }
        }
        
      },
      
      
      working_visualisations =
      {
        -- LEDs
        omega_drill_status_leds_working_visualisation(),

        -- light
        --electric_mining_drill_primary_light,
        omega_drill_secondary_light,
        
        --awww I gotta redo the water anims? d'ya think just straight copying the prev will work? (it doesn't)

        {--input_fluid_patch_window_sprites
          secondary_draw_order = -49,
          always_draw = true,
          north_animation =
          {
		    layers =
			{{
              priority = "high",
              filename = "__OmegaDrill__/graphics/omega-drill/flbg.png",
              line_length = 1,
              width = 600,
              height = 600,
              frame_count = 1,
              animation_speed = 1,
              direction_count = 1,
              shift = { 0 , 0 }
            }}
          },
		  east_animation =
          {
		    layers =
			{{
              priority = "high",
              filename = "__OmegaDrill__/graphics/omega-drill/flbg.png",
              line_length = 1,
              width = 600,
              height = 600,
              frame_count = 1,
              animation_speed = 1,
              direction_count = 1,
              shift = { 0 , 0 }
            }}
          },
		  south_animation =
          {
		    layers =
			{{
              priority = "high",
              filename = "__OmegaDrill__/graphics/omega-drill/flbg.png",
              line_length = 1,
              width = 600,
              height = 600,
              frame_count = 1,
              animation_speed = 1,
              direction_count = 1,
              shift = { 0 , 0 }
            }}
          },
		  west_animation =
          {
		    layers =
			{{
              priority = "high",
              filename = "__OmegaDrill__/graphics/omega-drill/flbg.png",
              line_length = 1,
              width = 600,
              height = 600,
              frame_count = 1,
              animation_speed = 1,
              direction_count = 1,
              shift = { 0 , 0 }
            }}
          }
        },
        {--input_fluid_patch_window_flow_sprites
          secondary_draw_order = -47,
          always_draw = true,
          apply_tint = "input-fluid-flow-color",
          north_animation =
          {
		    layers =
			{{
              priority = "high",
              filename = "__OmegaDrill__/graphics/omega-drill/flfl.png",
              line_length = 1,
              width = 600,
              height = 600,
              frame_count = 1,
              animation_speed = 1,
              direction_count = 1,
              shift = { 0 , 0 }
            }}
          },
		  east_animation =
          {
		    layers =
			{{
              priority = "high",
              filename = "__OmegaDrill__/graphics/omega-drill/flfl.png",
              line_length = 1,
              width = 600,
              height = 600,
              frame_count = 1,
              animation_speed = 1,
              direction_count = 1,
              shift = { 0 , 0 }
            }}
          },
		  south_animation =
          {
		    layers =
			{{
              priority = "high",
              filename = "__OmegaDrill__/graphics/omega-drill/flfl.png",
              line_length = 1,
              width = 600,
              height = 600,
              frame_count = 1,
              animation_speed = 1,
              direction_count = 1,
              shift = { 0 , 0 }
            }}
          },
		  west_animation =
          {
		    layers =
			{{
              priority = "high",
              filename = "__OmegaDrill__/graphics/omega-drill/flfl.png",
              line_length = 1,
              width = 600,
              height = 600,
              frame_count = 1,
              animation_speed = 1,
              direction_count = 1,
              shift = { 0 , 0 }
            }}
          }
        },
        {--input_fluid_patch_window_base_sprites
          always_draw = true,
          -- render_layer = "lower-object-above-shadow",
          secondary_draw_order = -48,
          apply_tint = "input-fluid-base-color",
          north_animation =
          {
		    layers =
			{{
              priority = "high",
              filename = "__OmegaDrill__/graphics/omega-drill/flms.png",
              line_length = 1,
              width = 600,
              height = 600,
              frame_count = 1,
              animation_speed = 1,
              direction_count = 1,
              shift = { 0 , 0 }
            }}
          },
		  east_animation =
          {
		    layers =
			{{
              priority = "high",
              filename = "__OmegaDrill__/graphics/omega-drill/flms.png",
              line_length = 1,
              width = 600,
              height = 600,
              frame_count = 1,
              animation_speed = 1,
              direction_count = 1,
              shift = { 0 , 0 }
            }}
          },
		  south_animation =
          {
		    layers =
			{{
              priority = "high",
              filename = "__OmegaDrill__/graphics/omega-drill/flms.png",
              line_length = 1,
              width = 600,
              height = 600,
              frame_count = 1,
              animation_speed = 1,
              direction_count = 1,
              shift = { 0 , 0 }
            }}
          },
		  west_animation =
          {
		    layers =
			{{
              priority = "high",
              filename = "__OmegaDrill__/graphics/omega-drill/flms.png",
              line_length = 1,
              width = 600,
              height = 600,
              frame_count = 1,
              animation_speed = 1,
              direction_count = 1,
              shift = { 0 , 0 }
            }}
          }
        },
        
        
        
        
      }
        
    },

    mining_speed = 37.5,
    energy_source =
    {
      type = "electric",
      -- will produce this much * energy pollution units per tick
      emissions_per_minute = 500,
      usage_priority = "secondary-input"
    },
    energy_usage = "7000kW",
    mining_power = 3,
    resource_searching_radius = 12.49,
    vector_to_place_result = {0, -7.85},
    module_specification =
    {
      module_slots = 3
    },
    radius_visualisation_picture =
    {
      filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-radius-visualization.png",
      width = 12,
      height = 12
    },
    monitor_visualization_tint = {r=78, g=173, b=255},
    fast_replaceable_group = "mining-drill",
    circuit_wire_connection_points = circuit_connector_definitions["electric-mining-drill"].points,
    circuit_connector_sprites = circuit_connector_definitions["electric-mining-drill"].sprites,
    circuit_wire_max_distance = default_circuit_wire_max_distance
    
  },
}
)

if (data.raw["resource-category"]["hard-resource"]) then
  data.raw["entity"]["omega-drill"].resource_categories = {"basic-solid","hard-resource"}
end