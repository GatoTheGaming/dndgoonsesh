extends Node2D

var test = -10
# Called when the node enters the scene tree for the first time.
func _ready():
	%file.add_filter("*.png", "PNG's")
	%file.popup()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_file_file_selected(path):
	%spr.texture = load(path)



