extends BaseButton

var is_debug_print: bool = false

func _ready():
	pressed.connect(self._on_pressed)
	mouse_entered.connect(self._on_mouse_entered)
	mouse_exited.connect(self._on_mouse_exited)

func _on_pressed():
	if (is_debug_print) : print("Clicked on ", self)
	
func _on_mouse_entered():
	if (is_debug_print) : print("Entering ", self)
	GameData.button_hovered = name
	
func _on_mouse_exited():
	if (is_debug_print) : print("Exiting ", self)
	if (GameData.button_hovered == name): GameData.button_hovered = ""
