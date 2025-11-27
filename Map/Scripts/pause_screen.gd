extends CanvasLayer

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		if !get_tree().paused and !$AnimationPlayer.is_playing():
			get_tree().paused = true
			$AnimationPlayer.play("RollIn")
			await $AnimationPlayer.animation_finished
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			$Control/Paper/Resume.visible = true
			$Control/Paper/Options.visible = true
			$Control/Paper/Exit.visible = true
			$AnimationPlayer.play("FirstRowButtons")
			await $AnimationPlayer.animation_finished
			
#FirstRowButtonInput
func _on_resume_pressed() -> void:
	if get_tree().paused and !$AnimationPlayer.is_playing():
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
		$AnimationPlayer.play_backwards("FirstRowButtons")
		await $AnimationPlayer.animation_finished
		$Control/Paper/Resume.visible = false
		$Control/Paper/Options.visible = false
		$Control/Paper/Exit.visible = false
		$AnimationPlayer.play_backwards("RollIn")
		await $AnimationPlayer.animation_finished
		get_tree().paused = false
func _on_options_pressed() -> void:
	pass
func _on_exit_pressed() -> void:
	get_tree().quit()
