extends Resource

class_name battleattack

@export var attack: Move = Move.new()
@export var attacker: characterStats = characterStats.new()
@export var target: characterStats = characterStats.new()
@export var text: String = "This guy does this to this guy by doing this"
