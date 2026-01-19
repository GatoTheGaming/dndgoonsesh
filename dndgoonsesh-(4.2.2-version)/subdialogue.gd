extends Resource

class_name subDialogue

@export var texts: Array[String] = ["This is default dialogue.","Yup.","...","Ok bye now"]

func _init(text : Array[String] = ["This is default dialogue.","Yup.","...","Ok bye now"]):
	texts = text
