extends CharacterBody2D

@export var allowmoving = true
var mask0 = true
var mask1 = false
var mask2 = false
var mask3 = false
var current_run_animation = "Run-mask0"
var current_idle_animation = "Idle-mask0"
var current_jumping_animation = "Jumping-mask0"
var current_falling_animation = "Falling-mask0"
@onready var coyote_timer: Timer = $CoyoteTimer
@onready var jump_buffer_timer: Timer = $JumpBufferTimer

var coyotetime = false
const SPEED = 200.0
const jumphight = -390
var gravity = 12.0
const max_gravity =14.5

func _physics_process(delta: float) -> void:
	if allowmoving:
		#jump
		if is_on_floor():
			coyotetime = false
			gravity = lerp(gravity, 12.0, 12*delta)
		else:
			gravity = lerp(gravity, max_gravity, 12*delta)
			if coyote_timer.is_stopped() and !coyotetime:
				$CoyoteTimer.start()
				coyotetime = true
			if Input.is_action_just_released("Jump") or is_on_ceiling():
				velocity.y *= 0.5
		if Input.is_action_just_pressed("Jump"):
			if $JumpBufferTimer.is_stopped():
				$JumpBufferTimer.start()
		if !jump_buffer_timer.is_stopped() and (!coyote_timer.is_stopped() or is_on_floor()):
			velocity.y = jumphight
			$CoyoteTimer.stop()
			$JumpBufferTimer.stop()
			coyotetime = true
		velocity.y += gravity
		#movement
		var direction := Input.get_axis("Left", "Right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		#movement animation
		if direction != 0 :
			$PlayerAnimation.flip_h = direction < 0
			$MaskAnimation.flip_h = direction < 0
			if is_on_floor():
				$PlayerAnimation.play(current_run_animation)
		if !is_on_floor():
			if velocity.y < 0:
				$PlayerAnimation.play(current_jumping_animation)
			if velocity.y > 0:
				$PlayerAnimation.play(current_falling_animation)
		if direction == 0 and is_on_floor():
			$PlayerAnimation.play(current_idle_animation)
		move_and_slide()
	#bugfix
	if $RayCast2D.is_colliding():
		$PlayerHitbox.disabled = true
	else:
		$PlayerHitbox.disabled = false
		
		
func _process(_delta: float) -> void:
	#mask switching
	if Input.is_action_just_pressed("Mask1"):
		if not $MaskAnimation.is_playing():
			$MaskAnimation/MaskTransitionSound.play()
			$MaskAnimation.play("Mask-Transition")
			if mask1 != true:
				current_run_animation = "Run-mask1"
				current_idle_animation = "Idle-mask1"
				current_jumping_animation = "Jumping-mask1"
				current_falling_animation = "Falling-mask1"
				mask1 = true
				mask0 = false
				mask2 = false
				mask3 = false
			else:
				maskreset()
	if Input.is_action_just_pressed("Mask2"):
		if not $MaskAnimation.is_playing():
			$MaskAnimation/MaskTransitionSound.play()
			$MaskAnimation.play("Mask-Transition")
			if mask2 != true:
				current_run_animation = "Run-mask2"
				current_idle_animation = "Idle-mask2"
				current_jumping_animation = "Jumping-mask2"
				current_falling_animation = "Falling-mask2"
				mask2 = true
				mask0 = false
				mask1 = false
				mask3 = false
			else:
				maskreset()
	if Input.is_action_just_pressed("Mask3"):
		if not $MaskAnimation.is_playing():
			$MaskAnimation/MaskTransitionSound.play()
			$MaskAnimation.play("Mask-Transition")
			if mask3 != true:
				current_run_animation = "Run-mask3"
				current_idle_animation = "Idle-mask3"
				current_jumping_animation = "Jumping-mask3"
				current_falling_animation = "Falling-mask3"
				mask3 = true
				mask0 = false
				mask1 = false
				mask2 = false
			else:
				maskreset()
#masktranshide
	if $MaskAnimation.is_playing():
		$MaskAnimation.visible = true
		await $MaskAnimation.animation_finished
	else:
		$MaskAnimation.visible = false
#direactionalchanges
	if Input.is_action_just_pressed("Right"):
		$PlayerHitbox.position = Vector2(2,6)
		$RayCast2D.position.x = 2
	elif Input.is_action_just_pressed("Left"):
		$PlayerHitbox.position = Vector2(-2,6)
		$RayCast2D.position.x = -2

#resetingmaskfunc
func maskreset():
	mask0 = true
	mask1 = false
	mask2 = false
	mask3 = false
	current_run_animation = "Run-mask0"
	current_idle_animation = "Idle-mask0"
	current_jumping_animation = "Jumping-mask0"
	current_falling_animation = "Falling-mask0"
