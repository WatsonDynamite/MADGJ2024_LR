extends Node3D

@onready var gridMap: GridMap = $GridMap;

enum Tiles { FLOOR, WALL };

const UNIVERSE_SIZE = 65;
const INITIAL_WALL_SIZE = 15;

var cur_wall_size = INITIAL_WALL_SIZE;
# Called when the node enters the scene tree for the first time.
func _ready():
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
		gridMap.set_cell_item(i, -1);
	var offset = factor /2 ;
	for i in range(1, factor -1 ):
		gridMap.set_cell_item(Vector3(i - offset, 1, -offset), Tiles.WALL);
		gridMap.set_cell_item(Vector3(i - offset, 1, offset), Tiles.WALL, 10);
	for j in range(1, factor - 1):
		gridMap.set_cell_item(Vector3(offset, 1, j - offset), Tiles.WALL, 22);
		gridMap.set_cell_item(Vector3(-offset, 1, j - offset), Tiles.WALL, 16);
	pass;
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass