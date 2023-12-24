extends Node

class_name MoneyController

static var cost_dict = {
	"table_1x1": 1,
	"table_1x2": 2,
	"table_2x2": 3,
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


static func _can_afford_build() -> bool:
	return GameData.player_money >= cost_dict[GameData.item_to_build]

static func _purchase_build():
	GameData.player_money -= cost_dict[GameData.item_to_build]
