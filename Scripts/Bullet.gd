extends CharacterBody3D
var speed = 3.5
var direction = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	translate(-Vector3.FORWARD * speed)
	pass
		
func setDirection(vector):
	transform = vector