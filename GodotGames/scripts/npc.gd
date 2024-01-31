extends CharacterBody2D

var motion = Vector2()
var state = 0

func _physics_process(delta):
	
	if state == 0:
		pass
	elif state == 1:
		velocity.x = 100
	elif state == 2:
		velocity.x = -100
	
	move_and_slide()

func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		$Label.show()


func _on_area_2d_body_exited(body):
	if body.has_method("player"):
		$Label.hide()


func _on_timer_timeout():
	state = floor(randf_range(0,3))
	print(state)
