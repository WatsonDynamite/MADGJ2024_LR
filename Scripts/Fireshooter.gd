extends Node3D

var fireball = preload("res://Prefabs/fireball.tscn")

@onready var shootTimer = $ShootTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_shoot_timer_timeout():
	var shoot = fireball.instantiate()
	shoot.rotation = global_rotation
	shoot.position = global_position
	get_tree().root.get_child(0).add_child(shoot)
	pass # Replace with function body.
