extends GPUParticles3D

func _ready():
	set_emitting(true);
	pass;

func _on_finished():
	queue_free();
	pass # Replace with function body.
