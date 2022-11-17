extends Node2D

onready var Character = $Character
var count_step_coin = 0
var step_coin = [23, 45, 60]
#### BUILT IN ####

func _ready():
	Character.coin_limiter(23)

func _process(delta):
	if count_step_coin == 3:
		pass
	elif Character.coin == step_coin[count_step_coin]:
		match(count_step_coin):
			0: 
				pass
			1:
				pass
			2:
				pass
		count_step_coin += 1
	

#### LOGIC ####
