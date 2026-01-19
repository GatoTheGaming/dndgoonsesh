extends Node

var party = []
# Called when the node enters the scene tree for the first time.
func _ready():
	var gato = characterStats.new()
	gato.name = "Gato"
	gato.desc = "Big cat creature"
	gato.health = 5
	gato.damage = 5
	gato.luck = 5
	gato.defense = 5
	gato.aura = 5
	gato.xp = 100
	var slash = Move.new()
	slash.damage = 100
	slash.chance = 100
	slash.levelReq = 1
	slash.name = "Slash"
	slash.desc = "Gato swings his sword to devastating effect."
	slash.action = " violently slashes "
	#var drillpierce = Move.new()
	#drillpierce.damage = 150
	#drillpierce.chance = 34
	#drillpierce.levelReq = 5
	#drillpierce.name = "Drill-Pierce"
	#drillpierce.desc = "Gato dashes forward with the power of a drill."
	gato.normMoves = [slash]
	gato.updateStats()
	party.append(gato)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
