extends Node3D

@onready var pauseUI = $Control
var pause = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		if pause:
			get_node("Level").process_mode = PROCESS_MODE_ALWAYS
			get_node("Player").process_mode = PROCESS_MODE_ALWAYS
			get_node("Bullets").process_mode = PROCESS_MODE_ALWAYS
			pause = false
			pauseUI.hide()
		else:
			get_node("Level").process_mode = PROCESS_MODE_DISABLED
			get_node("Player").process_mode = PROCESS_MODE_DISABLED
			get_node("Bullets").process_mode = PROCESS_MODE_DISABLED
			pause = true
			pauseUI.show()
	pass
