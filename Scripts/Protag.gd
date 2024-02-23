extends CharacterBody3D

@export var speed = 4


func get_input():
	# Input handling
	var movement: Vector3 = Vector3.ZERO
	movement.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	movement.z = Input.get_action_strength("down") - Input.get_action_strength("up")
	# Normalize the movement vector to avoid faster diagonal movement
	movement = movement.normalized()
	# Apply movement
	velocity.x = movement.x * speed
	velocity.z = movement.z * speed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _physics_process(delta):
	get_input()
	move_and_slide()
	
