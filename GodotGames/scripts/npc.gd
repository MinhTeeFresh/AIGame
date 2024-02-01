extends CharacterBody2D
var character = null

func _on_area_2d_body_entered(body):
	character = body.get_name()
	if character == "player":
		$Label.show()

func _on_area_2d_body_exited(body):
	character = null
	$Label.hide()
