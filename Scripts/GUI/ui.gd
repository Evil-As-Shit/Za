extends CanvasLayer

var item : String = ""

func _ready():
#	SignalController.placeables.connect(item_selected)
	pass
	
func item_selected(_item):
	
	pass
	

func _process(_delta):
	$Label.text = str("$", GameData.player_money)
