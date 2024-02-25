extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _powerUp():
	var children: Array = get_parent().get_node("Enemies").get_children()
	for i in children.size():
		children[i].queue_free()
	
