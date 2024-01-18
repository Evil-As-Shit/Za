class_name RecipeController

# id: [cost, icon_x, icon_y, [ingredients]]
static var Data:Dictionary = {
	"canned sauce": [1, 0, 1, []],
	"cheese": [1, 1, 2, []],
	"dough": [1, 3, 1, ["flour","water","yeast","salt","sugar"]],
	"flour": [1, 2, 1, []],
	"pizza": [1, 2, 2, ["dough","sauce","cheese"]],
	"salt": [1, 2, 0, []],
	"sauce": [1, 0, 2, ["water","canned sauce","salt","sugar","seasoning"]],
	"seasoning": [1, 0, 0, []],
	"sugar": [1, 2, 0, []],
	"water": [1, 1, 0, []],
	"yeast": [1, 3, 0, []],
}
