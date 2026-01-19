extends Control
# Called when the node enters the scene tree for the first time.

func set_dialogue(dialogue, dialogueNum):
	%txt.text = dialogue.texts[dialogueNum]
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

