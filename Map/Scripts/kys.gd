extends Area2D

@onready var the_masked: CharacterBody2D = $"/root/Map/The Masked"
@onready var check_point: Area2D = $"/root/Map/CheckPoint"

func _on_body_entered(_body: Node2D) -> void:
	CheckPoints.current_cp.y -= 31
	the_masked.position = CheckPoints.current_cp
	CheckPoints.current_cp.y += 31
	the_masked.maskreset()
	$AudioStreamPlayer.play()
