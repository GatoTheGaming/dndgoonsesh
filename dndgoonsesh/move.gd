extends Resource

class_name Move

@export_category("Cosmetic")
@export var name: String = "Default Dagger"
@export var desc: String = "A dagger of default properties is thrown at the opponent."
@export var action: String = " throws a dagger of default properties at "

@export_category("Stats")
@export var damage: int = 100
@export var chance: int = 100
@export var auraPerc: int = 0
@export var levelReq: int = 1

@export_category("Effects")
@export var effect: String = "None"
