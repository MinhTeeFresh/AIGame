extends Label

var response = "Hello, world!"

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	
@onready var WorldLineEdit = get_node("../WorldLineEdit")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if WorldLineEdit.responded == true:
		text = response
		show()
