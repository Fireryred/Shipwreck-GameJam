extends Control

@onready var card1 := $"1st Card"
@onready var card2 := $"2nd Card"

func _ready():
	pass 

func _process(delta):
	if card1.type == card2.type:
		card2.random_card()
