extends Area3D
var speed = 3.5
var direction = Vector3.ZERO

@onready var particles = preload("res://Prefabs/Particles/warning_particle.tscn");

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
	_disable()
	if(area.has_method("_on_receive_damage")):
		area._on_receive_damage(1);
	pass; # Replace with function body.

func _on_body_entered(body):
	if(body.get_parent().has_method("_decress_curr_size")):
		body.get_parent()._decress_curr_size(2)
		var particle = particles.instantiate();
		particle.position = Vector3(position.x, position.y + 1, position.z);
		body.add_child(particle);
		_disable()
	pass # Replace with function body.

func _disable():
	set_process_mode(PROCESS_MODE_DISABLED)
	hide()
	position.y = 10
