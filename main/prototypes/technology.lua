data:extend(
{
  {
    type = "technology",
    name = "omega-drill",
    icon = "__OmegaDrill__/graphics/icons/omega-drill-large.png",
	icon_size = 128,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "omega-drill"
      },
    },
    prerequisites = { "electric-engine", "logistics-3"},
    unit = {
      count = 150,
      ingredients = {
        {"automation-science-pack", 2},
        {"logistic-science-pack", 2},
	{"chemical-science-pack", 2},
	{"production-science-pack", 2}
      },
      time = 20
    },
    order = "c-g-b-z",
  },
})