extends Area3D

var player: Node3D
var collided: bool = false
var attacking: bool = false
var damage = 1
var attackTimer: Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_node("Player")
	attackTimer = get_node("Timer")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if collided && attacking:
		player.takeDamage(damage)
		attacking = false
		attackTimer.start()
	pass

func _physics_process(delta):
	look_at(player.position, Vector3.UP)
	if !collided:
		translate(Vector3.FORWARD * delta)
	pass


func _on_body_entered(body):
	collided = true
	attacking = true
	pass # Replace with function body.


func _on_body_exited(body):
	collided = false
	pass # Replace with function body.

func _on_timer_timeout():
	attacking = true
	attackTimer.stop()
	pass # Replace with function body.