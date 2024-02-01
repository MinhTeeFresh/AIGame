extends CharacterBody2D

var character = null
var state = "idle" # Possible states: idle, moving, conversing
var target_position = Vector2() # For when the NPC needs to move

func _on_area_2d_body_entered(body):
	character = body.get_name()
	if character == "player":
		$Label.show()

func _on_area_2d_body_exited(body):
	character = null
	$Label.hide()

func set_state(new_state):
	state = new_state

func set_target_position(new_target_position):
	target_position = new_target_position

func update():
	if state == "moving":
		move_to_target()

func move_to_target():
	# Move towards target_position. Implement actual movement logic here.
	pass
