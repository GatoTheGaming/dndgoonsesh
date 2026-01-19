extends Node

var enemysprite = preload("res://assets/sprites/npcs/nullspace/test_shites-1.png(1).png")
var enemycharacter = characterStats.new()
var currentTurn = "player" # else "enemy"
var numPlayers = 1 # max of 6
var currentPlayerTurn = 1 # from 1 to partylen
var battleattacks = []
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
