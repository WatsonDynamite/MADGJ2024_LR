extends Area3D

@onready var audio = $AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _powerUp():
	audio.play()
	var children: Array = get_parent().get_node("Enemies").get_children()
	for i in children.size():
		children[i]._on_receive_damage(10)
	
