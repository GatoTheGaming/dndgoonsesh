extends StaticBody2D

@export var dialogue: Array[subDialogue] = [subDialogue.new(),subDialogue.new(["...Okay, you can stop talking to me now."])]
var interactNum = 0

@export var sprite = preload("res://assets/sprites/npcs/nullspace/test_shites-1.png(1).png")
@export var battlesprite = preload("res://assets/sprites/npcs/nullspace/test_shites-1.png(1).png")
@export var battleReady = false
@export var battlecharacter = characterStats.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	%sprite.texture = sprite
	add_to_group("npcs")
	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

