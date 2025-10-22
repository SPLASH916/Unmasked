extends StaticBody2D

@onready var the_masked: CharacterBody2D = get_node("/root/Map/The Masked")

func _process(delta: float) -> void:
	if the_masked.mask2 == false:
		$CollisionShape2D.disabled = true
		visible = false
	else:
		$CollisionShape2D.disabled = false
		visible = true
