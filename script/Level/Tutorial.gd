extends Node2D

onready var Character = $Character
var count_step_coin = 0
var step_coin = [23, 45, 53]

enum State {
	Close, 
	Open,
	Finish,
}

var state = State.Close
#### BUILT IN ####

func _ready():
	Character.coin_limiter(23)

# warning-ignore:unused_argument
func _process(delta):
	if state == State.Open:
		open_levelEnd()
		state = State.Finish
	elif count_step_coin <= 2:
		if Character.coin == step_coin[count_step_coin]:
			match(count_step_coin):
				0: 
					$Door1.queue_free()
				1:
					$Door2.queue_free()
				2:
					$Door3.queue_free()
			count_step_coin += 1
			
			if count_step_coin == 3:
				state = State.Open
			else :
				Character.coin_limiter(step_coin[count_step_coin])

#### LOGIC ####

func open_levelEnd():
	print("Final Door open")
