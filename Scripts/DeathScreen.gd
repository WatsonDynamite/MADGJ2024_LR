extends Control

@onready var ui_elements = $ui_elements;
@onready var text = $ui_elements/Label;

var cursor = preload("res://Assets/cursor.png");

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_custom_mouse_cursor(cursor)
	var tween: Tween = create_tween();
	modulate.a = 0;
	await tween.tween_property(self, "modulate:a", 1, 3).finished;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_retry_button_pressed():
	get_tree().reload_current_scene();
	pass # Replace with function body.
