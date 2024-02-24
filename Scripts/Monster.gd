extends Area3D

var player: Node3D
var collided: bool = false
var attacking: bool = false
var damage = 1
var attackTimer: Timer

@export var health = 1;
@export var movespeed = 1;
@export var death_particle: PackedScene;

var cur_health = health;

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().root.get_child(0).get_node("Player")
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
		translate(Vector3.FORWARD * delta * movespeed)
	pass

func _on_receive_damage(damage: int):
	var particle = death_particle.instantiate();
	particle.position = position;
	get_parent().add_child(particle);
	
	health -= damage;
	if(health <= 0):
		_on_death();
	pass

func _on_body_entered(body):
	collided = true
	attacking = true
	pass # Replace with function body.


func _on_death():
	queue_free();
	pass;

func _on_body_exited(body):
	collided = false
	pass # Replace with function body.

func _on_timer_timeout():
	attacking = true
	attackTimer.stop()
	pass # Replace with function body.
