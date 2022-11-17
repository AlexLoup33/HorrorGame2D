extends Node2D

onready var animatedSprite = $AnimatedSprite
onready var InteractionBox = $InteractionBox

#### BUILT IN ####

func _ready():
	animatedSprite.play("default")

#### LOGIC ####

func _on_body_entered(body):
	if body.name == "Character":
		body.pick_coin()
		queue_free()
