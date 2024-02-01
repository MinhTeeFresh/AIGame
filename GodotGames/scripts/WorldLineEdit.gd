extends LineEdit

var playerinput = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

@onready var player = get_node("../../player")
@onready var chat = get_node("..")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if chat.dialog == true:
		show()

func _on_text_submitted(new_text):
	if !new_text.is_empty():
		playerinput = new_text
		# playerinput --> AI
		chat.dialog = false
		chat.responded = true
		hide()
		clear()
