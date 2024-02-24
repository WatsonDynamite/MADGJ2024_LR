extends Area3D
var speed = 3.5
var direction = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_mode(PROCESS_MODE_DISABLED)
	pass # Replace with function body.


func _physics_process(delta):
	translate(-Vector3.FORWARD * speed)
	pass
		
func setDirection(vector):
	transform = vector
	
func _on_area_entered(area):
	print("teste")
	_disable()
	area.queue_free()
	pass # Replace with function body.


func _on_body_entered(body):
	print("parede")
	body.get_parent()._decress_curr_size(2)
	_disable()
	pass # Replace with function body.

func _disable():
	hide()
	set_process_mode(PROCESS_MODE_DISABLED)
	position.y = 10
