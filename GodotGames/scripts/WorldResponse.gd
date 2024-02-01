extends Label

var response = 'hey'

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	
@onready var WorldLineEdit = get_node("../WorldLineEdit")
@onready var chat = get_node("..")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if chat.responded == true:
		text = response
		show()

func _input(event):
	if Input.is_action_pressed('ui_accept'):
		chat.dialog = true
		chat.responded = false
		hide()
