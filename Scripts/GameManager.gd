extends Control


var score = 0;
@onready var survivalLabel = $Score
@onready var survivalTimer = $Score/SurvivalTimer;


@onready var waveLabel = $Wave;
@onready var waveTimer = $Wave/WaveTimer

var wave_counter = 1;

# Called when the node enters the scene tree for the first time.
func _ready():
	survivalLabel.text = "Score: 0";
	survivalTimer.start(1);
	_start_wave(1);
	pass # Replace with function body.

func _add_score(new_sc: int): 
	score += new_sc;
	survivalLabel.text = "Score: " + str(score);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	waveLabel.text = "Wave " + str(wave_counter) + ": " + _format_seconds(waveTimer.time_left)
	pass

func _on_survival_timer_timeout():
	_add_score(10);
	pass # Replace with function body.
	
func _format_seconds(time : float):
	var minutes := time / 60
	var seconds := fmod(time, 60)
	return "%02d:%02d" % [minutes, seconds]
	pass;


func _start_wave(wave: int):
	waveTimer.start(wave * 60);
	
