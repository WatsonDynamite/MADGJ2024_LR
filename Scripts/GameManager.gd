extends Control


var score = 0;
@onready var label = $Score

# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = "Score: 0";
	pass # Replace with function body.


func _add_score(score: int): 
	score += score;
	label.text = "Score: " + str(score);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_survival_timer_timeout():
	_add_score(10);
	pass # Replace with function body.
