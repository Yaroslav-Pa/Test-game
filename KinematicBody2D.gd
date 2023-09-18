extends KinematicBody2D

enum PlayerState {
	Idle,
	Walk,
	Run,
	Jump,
	Fall,
	Dash,
	Climb,
	WallSlide,
	WallJump
}

const fireballl = preload("res://addons/Fireball.tscn")

var state = PlayerState.Idle
var velocity = Vector2()
var gravity = 500
var walk_speed = 150
var run_speed = 300
var jump_force = -400
var dash_force = 6000
var rs_look = Vector2(0,0)
var impulse = Vector2(0,0)
var deadzone = 0.3

func setImpulse(value):
	impulse += value
	

func rslook():
	rs_look.y = Input.get_joy_axis(0, JOY_AXIS_1)
	rs_look.x = Input.get_joy_axis(0, JOY_AXIS_0)
	if rs_look.length() >= deadzone:
		rotation = rs_look.angle()
		
func _physics_process(delta):
	rslook()
	# Handle input and state transitions here
	match state:
		PlayerState.Idle, PlayerState.Walk:
			var move_input = 0
			if Input.is_action_pressed("ui_left"):
				move_input -= 1
			if Input.is_action_pressed("ui_right"):
				move_input += 1
			
			velocity.x = move_input * walk_speed
			
			if move_input != 0:
				state = PlayerState.Walk
			else:
				state = PlayerState.Idle
			
			if Input.is_action_just_pressed("ui_up"):
				state = PlayerState.Jump
				velocity.y = jump_force
		
		PlayerState.Jump:
			velocity.y += gravity * delta
			if is_on_floor():
				state = PlayerState.Idle
				velocity.y = 0
			elif Input.is_action_just_pressed("ui_up"):
				impulse = dash_force * rs_look
				velocity = Vector2.ZERO
				state = PlayerState.Dash

		PlayerState.Dash:
			velocity += impulse * delta 
			if is_on_floor():
				state = PlayerState.Idle
				velocity.x = 0
				
	velocity += impulse
	
	impulse -= impulse * delta * 17
	velocity.y += gravity * delta
# warning-ignore:return_value_discarded
	move_and_slide(velocity, Vector2(0, -1))
	
	if Input.is_action_just_pressed("fire"):
		var fireball = fireballl.instance()
		fireball.position = get_position() + Vector2.RIGHT.rotated(rotation) * 30
		fireball.rotation = rotation
#		fireball.gravity_direction = rotation
		get_parent().add_child(fireball)
		
	# Handle input and state transitions here

#	match state:
#		PlayerState.Idle:
#			# Set idle animation
#		PlayerState.Walk:
#			# Set walk animation
#		PlayerState.Jump:
#			# Set jump animation
#		PlayerState.Dash:
#			# Set dash animation
#		# Add animations for other states as needed

#func _input(event):
##	if event.is_action_pressed("interact"):
#		# Handle interaction logic (e.g., climbing a ladder)
#	if event.is_action_pressed("climb_up"):
#		state = PlayerState.Climb
#		# Handle climbing logic (e.g., moving up)
#	elif event.is_action_pressed("climb_down"):
#		state = PlayerState.Climb
#		# Handle climbing logic (e.g., moving down)
#	elif event.is_action_pressed("wall_slide"):
#		state = PlayerState.WallSlide
#		# Handle wall sliding logic
#	elif event.is_action_pressed("wall_jump"):
#		state = PlayerState.WallJump
#		# Handle wall jump logic

	# Add more input handling for other actions as needed
