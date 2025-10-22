extends CharacterBody2D

@export var allowmoving = true
@export var mask0 = true
@export var mask1 = false
@export var mask2 = false
@export var mask3 = false
const SPEED = 300.0
const JUMP_VELOCITY = -500.0


func _physics_process(delta: float) -> void:
	if allowmoving:
		#gravity
		if not is_on_floor():
			velocity += get_gravity() * delta
		#jump
		if is_on_floor():
			if Input.is_action_just_pressed("Jump"):
				velocity.y = JUMP_VELOCITY
		elif velocity.y < 0:
			if Input.is_action_just_released("Jump") or is_on_ceiling():
				velocity.y *=0.5
		#movement
		var direction := Input.get_axis("Left", "Right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		#movement animation
		if direction != 0:
			$PlayerAnimation.flip_h = direction < 0
			$MaskAnimation.flip_h = direction < 0
			if mask0:
				$PlayerAnimation.play("Run-mask0")
			if mask1:
				$PlayerAnimation.play("Run-mask1")
			if mask2:
				$PlayerAnimation.play("Run-mask2")
			if mask3:
				$PlayerAnimation.play("Run-mask3")
		else:
			if mask0:
				$PlayerAnimation.play("Idle-mask0")
			if mask1:
				$PlayerAnimation.play("Idle-mask1")
			if mask2:
				$PlayerAnimation.play("Idle-mask2")
			if mask3:
				$PlayerAnimation.play("Idle-mask3")

		move_and_slide()
func _process(delta: float) -> void:
	#mask switching
	if mask1 and mask2 and mask3 == false:
		mask0 = true
	if Input.is_action_just_pressed("Mask1"):
		if mask1 != true:
			mask1 = true
			mask0 = false
			mask2 = false
			mask3 = false
		else:
			mask1 = false
			mask0 = true
	if Input.is_action_just_pressed("Mask2"):
		if mask2 != true:
			mask2 = true
			mask0 = false
			mask1 = false
			mask3 = false
		else:
			mask2 = false
			mask0 = true
	if Input.is_action_just_pressed("Mask3"):
		if mask3 != true:
			mask3 = true
			mask0 = false
			mask1 = false
			mask2 = false
		else:
			mask3 = false
			mask0 = true
	#mask transition
	if Input.is_action_just_pressed("Mask1") or Input.is_action_just_pressed("Mask2") or Input.is_action_just_pressed("Mask3"):
		$MaskAnimation/MaskTransitionSound.play()
		$MaskAnimation.play("Mask-Transition")
		$MaskAnimation.visible = true
		await $MaskAnimation.animation_finished
		$MaskAnimation.visible = false
