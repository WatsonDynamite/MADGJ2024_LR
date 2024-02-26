extends Node3D

@onready var gridMap: GridMap = $GridMap;
@onready var warningLevel: TextureProgressBar = $Container/WarningLevel;
@onready var light: SpotLight3D = $SpotLight3D
@onready var wallSFX: AudioStreamPlayer = $WallSFX
var crosshair = preload("res://Assets/crosshair.png");

var zombie = preload("res://Prefabs/Zombie.tscn")
var skeleton = preload("res://Prefabs/skeleton.tscn")
var slime = preload("res://Prefabs/slime.tscn")
var wallParticle = preload("res://Prefabs/Particles/wall_particle.tscn")

var alcohol = preload("res://Prefabs/PowerUps/Alcohol.tscn");

var mobs: Array
var spawn_freq_mod: int = 0.5;
var spawn_freq_time: int = 2;

@onready var spawn_timer: Timer = $Timer;
enum Tiles { FLOOR, WALL };

const UNIVERSE_SIZE = 65;
const INITIAL_WALL_SIZE = 17;

var cur_wall_size = INITIAL_WALL_SIZE;
var wall_health = 3;
var lightModifier = 45 / INITIAL_WALL_SIZE;
# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_custom_mouse_cursor(crosshair, Input.CURSOR_ARROW, Vector2(16.5, 16.5));
	mobs.append(zombie)
	mobs.append(skeleton)
	mobs.append(slime)
	_spawner()
	var offset = UNIVERSE_SIZE / 2;
	for i in UNIVERSE_SIZE:
		for j in UNIVERSE_SIZE:
			gridMap.set_cell_item(Vector3i(i - offset, 0, j - offset), Tiles.FLOOR);
	_set_wall_to(INITIAL_WALL_SIZE);
	
	_on_new_wave(1);
	pass # Replace with function body.
	
# Creates a wall around the center of the level with a size of factor x factor
# make sure factor is always an odd number (?)
func _set_wall_to(factor: int):
	var prevWalls = gridMap.get_used_cells_by_item(Tiles.WALL);
	var offset = factor /2 ;
	
	var player = get_parent().find_child("Player");
	var playerPos = player.global_position;
	var newPlayerX = playerPos.x;
	var newPlayerZ = playerPos.z;
	

	if(abs(playerPos.x) >= floor(offset - 1)):
		newPlayerX = playerPos.x - 1 * sign(playerPos.x);
	
	if(abs(playerPos.z) >= floor(offset - 1)):
		newPlayerZ = playerPos.z - 1 * sign(playerPos.z);
	player.global_position = Vector3(newPlayerX, playerPos.y, newPlayerZ);
	
		
	
	for i in prevWalls:
		var particle = wallParticle.instantiate();
		particle.position = i;
		get_parent().add_child(particle);
		gridMap.set_cell_item(i, -1);
	for i in range(1, factor -1 ):
		gridMap.set_cell_item(Vector3(i - offset, 1, -offset), Tiles.WALL);
		gridMap.set_cell_item(Vector3(i - offset, 1, offset), Tiles.WALL, 10);
	for j in range(1, factor - 1):
		gridMap.set_cell_item(Vector3(offset, 1, j - offset), Tiles.WALL, 22);
		gridMap.set_cell_item(Vector3(-offset, 1, j - offset), Tiles.WALL, 16);
	pass;
	
func _decress_curr_size(value: int):
	wall_health -=1
	if wall_health == 0 && cur_wall_size > 5:
		cur_wall_size -= value;
		light.spot_angle -= lightModifier
		wall_health = 3
		_set_wall_to(cur_wall_size);
		wallSFX.play()

func increase_curr_size():
	cur_wall_size += 1;
	_set_wall_to(cur_wall_size);
	wallSFX.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	warningLevel.value = 3-wall_health;
	pass

func _spawner():
	var offset = cur_wall_size / 2;
	var random_number = randi() % 3
	var mob = mobs[random_number].instantiate()
	var randomX = randi() % (offset + 3) + offset
	if randi() % 2 == 0:
		randomX *= -1
	var randomZ = randi() % (offset + 3) + offset
	if randi() % 2 == 0:
		randomZ *= -1
	mob.position = Vector3(randomX,0.5,randomZ)
	get_node("Enemies").add_child(mob)

func _on_timer_timeout():
	_spawner()
	pass # Replace with function body.

func _on_new_wave(wave: int):
	if wave > 1:
		var playerPos = get_parent().find_child("Player").global_position;
		var alcoholInstance = alcohol.instantiate();
		alcoholInstance.position = Vector3(playerPos.x, 1, playerPos.z);
		add_child(alcoholInstance);
		
	spawn_timer.start(spawn_freq_time - (wave * spawn_freq_mod));
	

