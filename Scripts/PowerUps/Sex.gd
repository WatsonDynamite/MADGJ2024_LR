extends Area3D

@onready var audio = $AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _powerUp():
	get_parent().get_parent().get_node("Player")._raise_health()
	audio.play()
	