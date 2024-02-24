extends Node3D

@onready var gridMap: GridMap = $GridMap;
@onready var warningLevel: TextureProgressBar = $Container/WarningLevel; 

var zombie = preload("res://Prefabs/Zombie.tscn")
var skeleton = preload("res://Prefabs/skeleton.tscn")
var slime = preload("res://Prefabs/slime.tscn")
var wallParticle = preload("res://Prefabs/wall_particle.tscn")

var mobs: Array
var spawn_timer: Timer
enum Tiles { FLOOR, WALL };

const UNIVERSE_SIZE = 65;
const INITIAL_WALL_SIZE = 17;

var cur_wall_size = INITIAL_WALL_SIZE;
var wall_health = 3;	
# Called when the node enters the scene tree for the first time.
func _ready():
	mobs.append(zombie)
	mobs.append(skeleton)
	mobs.append(slime)
	_spawner()
	var offset = UNIVERSE_SIZE / 2;
	for i in UNIVERSE_SIZE:
		for j in UNIVERSE_SIZE:
			gridMap.set_cell_item(Vector3i(i - offset, 0, j - offset), Tiles.FLOOR);
	_set_wall_to(INITIAL_WALL_SIZE);
	
	pass # Replace with function body.


func _input(event):
	if(event.is_action_pressed("debug_increase_wall")):
		cur_wall_size += 2;
		_set_wall_to(cur_wall_size);
	if(event.is_action_pressed("debug_decrease_wall")):
		cur_wall_size -= 2;
		_set_wall_to(cur_wall_size);
	
# Creates a wall around the center of the level with a size of factor x factor
# make sure factor is always an odd number (?)
func _set_wall_to(factor: int):
	var prevWalls = gridMap.get_used_cells_by_item(Tiles.WALL);
	
	for i in prevWalls:
		var particle = wallParticle.instantiate();
		particle.position = i;
		get_parent().add_child(particle);
		gridMap.set_cell_item(i, -1);
	var offset = factor /2 ;
	for i in range(1, factor -1 ):
		gridMap.set_cell_item(Vector3(i - offset, 1, -offset), Tiles.WALL);
		gridMap.set_cell_item(Vector3(i - offset, 1, offset), Tiles.WALL, 10);
	for j in range(1, factor - 1):
		gridMap.set_cell_item(Vector3(offset, 1, j - offset), Tiles.WALL, 22);
		gridMap.set_cell_item(Vector3(-offset, 1, j - offset), Tiles.WALL, 16);
	pass;
	
func _decress_curr_size(value: int):
	wall_health -=1
	if wall_health == 0:
		cur_wall_size -= value;
		wall_health = 3
		_set_wall_to(cur_wall_size);
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	warningLevel.value = 3-wall_health;
	pass

func _spawner():
	var random_number = randi() % 3
	var mob = mobs[random_number].instantiate()
	var randomX = randi() % cur_wall_size + (cur_wall_size/ 2)
	if randi() % 2 == 0:
		randomX *= -1
	var randomZ = randi() % cur_wall_size + (cur_wall_size/ 2)
	if randi() % 2 == 0:
		randomZ *= -1
	mob.position = Vector3(randomX,0.5,randomZ)
	add_child(mob)


func _on_timer_timeout():
	_spawner()
	pass # Replace with function body.
