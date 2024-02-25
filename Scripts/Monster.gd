extends Area3D

var rockNroll = preload("res://Prefabs/PowerUps/RockNRoll.tscn")
var alcohol = preload("res://Prefabs/PowerUps/Alcohol.tscn")
var sex = preload("res://Prefabs/PowerUps/Sex.tscn")
var drugs = preload("res://Prefabs/PowerUps/Drugs.tscn")

var allPowerUps: Array

var player: Node3D
var collided: bool = false
var attacking: bool = false
var damage = 1
var attackTimer: Timer

@export var health = 1;
@export var movespeed = 1;
@export var isBoss = false
@export var death_particle: PackedScene;

var cur_health = health;

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().root.get_child(0).get_node("Player")
	allPowerUps.append(rockNroll)
	allPowerUps.append(alcohol)
	allPowerUps.append(sex)
	allPowerUps.append(drugs)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
	pass # Replace with function body.


func _on_death():
	if(isBoss):
		var powerUp = allPowerUps[randi() % 4].instantiate()
		powerUp.position = Vector3(global_position.x,1,global_position.z)
		get_parent().add_child(powerUp)
	queue_free();
	pass;

func _on_body_exited(body):
	collided = false
	pass # Replace with function body.
