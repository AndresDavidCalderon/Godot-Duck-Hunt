extends CharacterBody3D

const SPEED := 250
#var angle = Vector3.ZERO

func _physics_process(delta):
	var moving_axis = Vector3(-SPEED,0,0)
	moving_axis=moving_axis.rotated(Vector3(0,1,0),rotation.y)
	moving_axis=moving_axis.rotated(Vector3(1,0,0),rotation.x)
	moving_axis=moving_axis.rotated(Vector3(0,0,1),rotation.z)
	velocity = moving_axis * delta
	move_and_slide()
