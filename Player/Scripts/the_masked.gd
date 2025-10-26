extends CharacterBody2D

@export var allowmoving = true
@export var mask0 = true
@export var mask1 = false
@export var mask2 = false
@export var mask3 = false
var current_run_animation = "Run-mask0"
var current_idle_animation = "Idle-mask0"
var current_jumping_animation = "Jumping-mask0"
var current_falling_animation = "Falling-mask0"
@onready var coyote_timer: Timer = $CoyoteTimer
@onready var jump_buffer_timer: Timer = $JumpBufferTimer

var coyotetime = false
const SPEED = 300.0
const jumphight = -400
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
		
func _process(delta: float) -> void:
	#mask switching
	if Input.is_action_just_pressed("Mask1"):
		current_run_animation = current_run_animation.replace(current_run_animation, "Run-mask1")
		current_idle_animation = current_idle_animation.replace(current_idle_animation, "Idle-mask1")
		current_jumping_animation = current_jumping_animation.replace(current_jumping_animation, "Jumping-mask1")
		current_falling_animation = current_falling_animation.replace(current_falling_animation, "Falling-mask1")
		$MaskAnimation/MaskTransitionSound.play()
		$MaskAnimation.play("Mask-Transition")
		$MaskAnimation.visible = true
		await $MaskAnimation.animation_finished
		if mask1 != true:
			mask1 = true
			mask0 = false
			mask2 = false
			mask3 = false
		else:
			current_run_animation = current_run_animation.replace(current_run_animation, "Run-mask0")
			current_idle_animation = current_idle_animation.replace(current_idle_animation, "Idle-mask0")
			current_jumping_animation = current_jumping_animation.replace(current_jumping_animation, "Jumping-mask0")
			current_falling_animation = current_falling_animation.replace(current_falling_animation, "Falling-mask0")
			mask1 = false
			mask0 = true
		$MaskAnimation.visible = false
	if Input.is_action_just_pressed("Mask2"):
		current_run_animation = current_run_animation.replace(current_run_animation, "Run-mask2")
		current_idle_animation = current_idle_animation.replace(current_idle_animation, "Idle-mask2")
		current_jumping_animation = current_jumping_animation.replace(current_jumping_animation, "Jumping-mask2")
		current_falling_animation = current_falling_animation.replace(current_falling_animation, "Falling-mask2")
		$MaskAnimation/MaskTransitionSound.play()
		$MaskAnimation.play("Mask-Transition")
		$MaskAnimation.visible = true
		await $MaskAnimation.animation_finished
		if mask2 != true:
			mask2 = true
			mask0 = false
			mask1 = false
			mask3 = false
		else:
			current_run_animation = current_run_animation.replace(current_run_animation, "Run-mask0")
			current_idle_animation = current_idle_animation.replace(current_idle_animation, "Idle-mask0")
			current_jumping_animation = current_jumping_animation.replace(current_jumping_animation, "Jumping-mask0")
			current_falling_animation = current_falling_animation.replace(current_falling_animation, "Falling-mask0")
			mask2 = false
			mask0 = true
		$MaskAnimation.visible = false
	if Input.is_action_just_pressed("Mask3"):
		current_run_animation = current_run_animation.replace(current_run_animation, "Run-mask3")
		current_idle_animation = current_idle_animation.replace(current_idle_animation, "Idle-mask3")
		current_jumping_animation = current_jumping_animation.replace(current_jumping_animation, "Jumping-mask3")
		current_falling_animation = current_falling_animation.replace(current_falling_animation, "Falling-mask3")
		$MaskAnimation/MaskTransitionSound.play()
		$MaskAnimation.play("Mask-Transition")
		$MaskAnimation.visible = true
		await $MaskAnimation.animation_finished
		if mask3 != true:
			mask3 = true
			mask0 = false
			mask1 = false
			mask2 = false
		else:
			current_run_animation = current_run_animation.replace(current_run_animation, "Run-mask0")
			current_idle_animation = current_idle_animation.replace(current_idle_animation, "Idle-mask0")
			current_jumping_animation = current_jumping_animation.replace(current_jumping_animation, "Jumping-mask0")
			current_falling_animation = current_falling_animation.replace(current_falling_animation, "Falling-mask0")
			mask3 = false
			mask0 = true
		$MaskAnimation.visible = false
