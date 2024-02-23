extends CharacterBody3D

@export var speed = 4
var model: Node3D 

func get_input(delta):
	# Input handling
	var movement: Vector3 = Vector3.ZERO
	movement.x = Input.get_action_strength("left") - Input.get_action_strength("right")
	movement.z = Input.get_action_strength("up") - Input.get_action_strength("down")
	# Normalize the movement vector to avoid faster diagonal movement
	movement = movement.normalized()
	# Apply movement
	velocity.x = movement.x * speed
	velocity.z = movement.z * speed
	#Mouse
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	var center: Vector2 = get_viewport().size / 2
	var angle: float = -Vector2.UP.angle_to(mouse_position - center)
	model.rotation = Vector3(model.rotation.x,lerp_angle(model.rotation.y, angle, delta * 100), model.rotation.z)
	#model.rotate(Vector3.UP, angle)
# Called when the node enters the scene tree for the first time.
func _ready():
	model = get_node("Model")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _physics_process(delta):
	get_input(delta)
	move_and_slide()
	
