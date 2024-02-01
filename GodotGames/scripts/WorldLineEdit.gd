extends LineEdit

var playerinput = ""
var responded = false

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

@onready var player = get_node("../player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
	if Input.is_action_pressed('e_key') and player.enemy != null and player.enemy != "player" and player.dialog == false:
		show()
		player.dialog = true
		#print("pressed E")

func _on_text_submitted(new_text):
	if !new_text.is_empty():
		playerinput = new_text
	player.dialog = false
	responded = true
	hide()
	clear()
