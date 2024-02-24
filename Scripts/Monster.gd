extends Area3D

var player: Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_node("Player")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	look_at(player.position, Vector3.UP)
	translate(Vector3.FORWARD * delta)
	pass
