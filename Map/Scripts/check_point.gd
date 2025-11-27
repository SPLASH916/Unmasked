extends Area2D

var done = false

func _on_body_entered(_body: Node2D) -> void:
	if _body.is_in_group("Player"):
		CheckPoints.current_cp = position
		if done == false:
			$AudioStreamPlayer2D.play()
			done = true
			await $AudioStreamPlayer2D.finished
			queue_free()
