extends KinematicBody2D

onready var AnimatedSprite = $AnimatedSprite
onready var Area2D = $InteractionBox
onready var Label = $Label

var coin;
var speed = 200
var moving_direction = Vector2.ZERO setget set_moving_direction, get_moving_direction
var facing_direction = Vector2.DOWN setget set_facing_direction, get_facing_direction

enum STATE {
	Idle, 
	Move,
}

var dir_dict = {
	"Up" : Vector2.UP, 
	"Down" : Vector2.DOWN,
	"Left" : Vector2.LEFT,
	"Right" : Vector2.RIGHT
}

var state_dict = {
	0 : "Idle",
	1 : "Move"
}

var state : int = STATE.Idle setget set_state, get_state

signal state_changed
signal facing_direction_changed
signal moving_direction_changed

#### ACCESSORS ####

func set_state(value) -> void:
	if value != state:
		state = value
	emit_signal("state_changed")

func get_state() -> int:
	return state

func set_facing_direction(value) -> void:
	if facing_direction != value:
		facing_direction = value
		emit_signal("facing_direction_changed")

func get_facing_direction() -> Vector2:
	return facing_direction

func set_moving_direction(value) -> void:
	if moving_direction != value:
		moving_direction = value
		emit_signal("moving_direction_changed")

func get_moving_direction() -> Vector2:
	return moving_direction

#### BUILT-IN ####

func _ready():
	coin = 0

func _physics_process(delta):
	var __ = move_and_slide(moving_direction * speed)

func _input(event):
	var dir = Vector2(
		int(Input.is_action_pressed("Right")) - int(Input.is_action_pressed("Left")),
		int(Input.is_action_pressed("Down")) - int(Input.is_action_pressed("Up"))
	)
	
	set_moving_direction(dir.normalized())
	
	if dir == Vector2.ZERO:
		set_state(STATE.Idle)
	else : 
		set_state(STATE.Move)

#### LOGIC ####

func find_dir_name(dir : Vector2) -> String:
	var dir_values_array = dir_dict.values()
	var dir_index = dir_values_array.find(dir)
	if dir_index == -1:
		return ""
	
	var dir_keys_array = dir_dict.keys()
	var dir_key = dir_keys_array[dir_index]
	
	return dir_key

func _on_AnimatedSprite_animation_finished():
	pass

func _update_animation():
	var dir_name = find_dir_name(facing_direction)
	
	var state_name = ""
	
	match(state):
		STATE.Idle: state_name = STATE.Idle
		STATE.Move: state_name = STATE.Move
	AnimatedSprite.play(state_dict[state_name] + dir_name)

func _update_InteractionBox_direction():
	var angle = facing_direction.angle()
	
	Area2D.set_rotation_degrees(rad2deg(angle)-90)

func pick_coin():
	coin += 1
	Label.set_text("coin : " + str(coin))

#### SIGNAL RESPONSES ####

func _on_interactionBox_body_entered(body):
	var bodies_array = Area2D.get_overlapping_bodies()
	if Input.is_action_pressed("Interaction"):
		for body in bodies_array:
			if body.has_method("interact"):
				body.interact()

func _on_state_changed():
	_update_animation()

func _on_facing_direction_changed():
	_update_animation()
	_update_InteractionBox_direction()

func _on_moving_direction_changed():
	if moving_direction == Vector2.ZERO or moving_direction == facing_direction:
		return 
	
	var sign_dir = Vector2(sign(moving_direction.x), sign(moving_direction.y))
	
	if sign_dir == moving_direction:
		set_facing_direction(moving_direction)
	else :
		if sign_dir.x == facing_direction.x:
			set_facing_direction(Vector2(0, sign_dir.y))
		else :
			set_facing_direction(Vector2(sign_dir.x, 0))
