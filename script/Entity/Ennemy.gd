extends KinematicBody2D

export var speed = 160
var velocity = Vector2.ZERO

var path : Array = []
var levelNavigation: Navigation2D = null
var character = null

var chasing = false

onready var Line = $Line2D

#### BUILT-IN ####

func _ready():
	yield(get_tree(), "idle_frame")
	var tree = get_tree()
	if tree.has_group("LevelNavigation"):
		levelNavigation = tree.get_nodes_in_group("LevelNavigation")[0]
	if tree.has_group("Character"):
		character = tree.get_nodes_in_group("Character")[0]

func _physics_process(delta):
	
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

func generate_path():
	if levelNavigation != null and character != null:
		path = levelNavigation.get_simple_path(global_position, character.global_position, false)

func move():
	velocity = move_and_slide(velocity)
