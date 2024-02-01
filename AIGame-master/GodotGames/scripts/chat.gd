extends Node

var escaped = false
var responded = false
var dialog = false
var input = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
@onready var WorldLineEdit = get_node("WorldLineEdit")
@onready var WorldResponse = get_node("WorldResponse")
@onready var player = get_node("../player")
@onready var escapeinst = get_node("escapeinst")
@onready var enterToCont = get_node("enterToCont")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
	if Input.is_action_pressed('esc'):
		escaped = true
		dialog = false
		responded = false
		WorldLineEdit.hide()
		WorldLineEdit.clear()
		WorldResponse.hide()
		escapeinst.hide()
		enterToCont.hide()
		
	if Input.is_action_pressed('e_key') and player.enemy != null and player.enemy != "player" and dialog == false:
		dialog = true
		escapeinst.show()
		enterToCont.show()
		
