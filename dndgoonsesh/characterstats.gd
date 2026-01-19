extends Resource

class_name characterStats

@export_category("Cosmetics")
@export var name: String = "Defaultguy"
@export var desc: String = "Yeah hes just a default guy. What did you expect"

@export_category("Base Stats (Min: 5 || Max: 100)")
@export var health: int = 5 # * 4 level
@export var damage: int = 5 # * level
@export var luck: int = 5 # * 1
@export var defense: int = 5 # * level
@export var aura: int = 5 # * 1

@export_category("Current stats")
@export var lv: int = 1
@export var xp: int = 100
@export var maxhp: int = 20
@export var hp: int = 20
@export var dmg: int = 5
@export var lck: int = 5
@export var def: int = 5
@export var ara: int = 5

@export_category("Moves")
@export var normMoves = [Move.new()]
@export var specialMoves = [Move.new()]
@export var ultMoves = [Move.new()]

@export_category("Keywords")
@export var weakTo: Array[String] = []
@export var strongAgainst: Array[String] = []

func updateStats():
	lv = xp / 100
	maxhp = health * 4 * lv
	hp = maxhp
	dmg = damage * lv
	lck = luck
	def = defense * lv
	ara = aura
	

