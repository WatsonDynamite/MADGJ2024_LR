extends Area3D

@onready var destroyTimer = $DestroyTimer
@onready var animatedSprite = $AnimatedSprite3D

const speed = 0.1
# Called when the node enters the scene tree for the first time.
func _ready():
	animatedSprite.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	translate(Vector3.FORWARD * speed)
	pass


func _on_destroy_timer_timeout():
	print("bruh")
	queue_free()
	pass # Replace with function body.
