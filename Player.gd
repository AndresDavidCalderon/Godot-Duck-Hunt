extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var head := $Head
@onready var camera := $Head/Camera3D
@onready var anim := $Head/Gun/AnimationPlayer
@onready var gun := $Head/Gun/RayCast3D
@onready var bulletScene := preload("res://bullet.tscn")

func _unhandled_input(event):
	if event is InputEventMouseButton:
		Input.mouse_mode = 2 # capture
	elif event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = 0 # default
		
	if event.is_action_pressed("Shoot"):
		anim.play("shoot")
		var bullet = bulletScene.instantiate()
		bullet.position = gun.global_position
		bullet.transform.basis = gun.global_transform.basis
		add_child(bullet)
		
	if Input.mouse_mode == 2:
		if event is InputEventMouseMotion:
			head.rotate_y(-event.relative.x * 0.007)
			head.rotate(Vector3(0,0,1).rotated(Vector3(0,1,0),head.rotation.y+PI/2),-event.relative.y * 0.007)

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("Left", "Right", "Forward", "Backward")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
