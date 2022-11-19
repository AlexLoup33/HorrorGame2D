extends KinematicBody2D

const speed_normal = 190
const speed_chase = 220
var speed;
var velocity = Vector2.ZERO

var path : Array = []
var levelNavigation: Navigation2D = null
var character = null

var chasing = false

onready var Line = $Line2D

#### BUILT-IN ####

func _ready():
	speed = speed_normal
	yield(get_tree(), "idle_frame")
	var tree = get_tree()
	if tree.has_group("LevelNavigation"):
		print("enter")
		levelNavigation = tree.get_nodes_in_group("LevelNavigation")[0]
		#levelNavigation = tree.get_nodes_in_groups("LevelNavigation")[0]
	if tree.has_group("Character"):
		print("enter 2")
		character = tree.get_nodes_in_group("Character")[0]
		#character = tree.get_nodes_in_group("Character")[0]

func _physics_process(delta):
	Line.global_position = Vector2.ZERO
	if character and levelNavigation:
		generate_path()
		navigate()
	move()

#### LOGIC ####

func navigate():
	if path.size() > 0:
		velocity = global_position.direction_to(path[1]) * speed
		
		if global_position == path[0]:
			path.pop_front()

func position_avaible_around_character() -> Vector2:
	var x;
	var y;
	x = rand_range((character.global_position.x - 200), (character.global_position.x + 200))
	y = rand_range((character.global_position.y - 200), (character.global_position.y + 200))
	return Vector2(x, y)

func generate_path():
	if levelNavigation != null and character != null:
		if not chasing : 
			var arr = position_avaible_around_character()
			path = levelNavigation.get_simple_path(global_position, character.global_position, false)
		elif chasing : 
			path = levelNavigation.get_simple_path(global_position, character.global_position, false)
		

func move():
	velocity = move_and_slide(velocity)
