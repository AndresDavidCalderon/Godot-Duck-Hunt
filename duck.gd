extends CharacterBody3D

const SPEED := 250
#var angle = Vector3.ZERO

func _physics_process(delta):
	velocity = -transform.basis.z * SPEED * delta
	velocity = velocity * get_rotation()
	move_and_slide()
