extends CharacterBody2D

var SPEED = 50.0
var face = "front"

var talking = false
var talksnap = false
var talkStep = -1
var talkNum = 0
var talker
# Called when the node enters the scene tree for the first time.
func _ready():
	%dialogue.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("interact"):
		talksnap = false
	var frame = %an.frame
	var progress= %an.frame_progress
	if Input.is_action_just_pressed("interact") and talkStep == -1:
		for body in %dialogueArea.get_overlapping_bodies():
			if body.is_in_group("npcs"):
				%dialogue.visible = true
				talksnap = true
				%an.stop()
				talker = body
				#print("Heh! That's an NPC.")
				talking = true
				talkStep = 0
				talkNum = len(body.dialogue[body.interactNum].texts)
				
				#body.interactNum
				#print(body.dialogue)
				%dialogue.set_dialogue(body.dialogue[body.interactNum], talkStep)
				break
	if Input.is_action_pressed("run"):
		SPEED = 100.0
		%an.speed_scale = 2
	else:
		SPEED = 50.0
		%an.speed_scale = 1
	if not talking:
		if Input.is_action_pressed("left"):
			%an.play("walk_side")
			%an.set_frame_and_progress(frame,progress)
			%an.flip_h = 1
			face = "left"
			%dialogueArea.position = Vector2(-8,12)
		elif Input.is_action_pressed("right"):
			%an.play("walk_side")
			%an.set_frame_and_progress(frame,progress)
			%an.flip_h = 0
			face = "right"
			%dialogueArea.position = Vector2(8,12)
		elif Input.is_action_pressed("up"):
			%an.play("walk_back")
			%an.set_frame_and_progress(frame,progress)
			face = "back"
			%dialogueArea.position = Vector2(0,8)
		elif Input.is_action_pressed("down"):
			%an.play("walk_front")
			%an.set_frame_and_progress(frame,progress)
			face = "front"
			%dialogueArea.position = Vector2(0,16)
		else:
			match face:
				"front":
					%an.play("idle_front")
				"left":
					%an.play("idle_side")
				"right":
					%an.play("idle_side")
				"back":
					%an.play("idle_back")
	elif not talksnap:
		#print(talker.interactNum)
		if Input.is_action_just_pressed("interact"):
			talksnap = true
			talkStep += 1
			if talkStep == talkNum:
				talking = false
				talksnap = false
				talkStep = -1
				%dialogue.visible = false
				if talker.interactNum < len(talker.dialogue) - 1:
					talker.interactNum += 1
				else:
					if talker.battleReady:
						Battlemain.enemysprite = talker.battlesprite
						Battlemain.enemycharacter = talker.battlecharacter
						get_tree().change_scene_to_file("res://battle_scene.tscn")
			else:
				%dialogue.set_dialogue(talker.dialogue[talker.interactNum], talkStep)
	var direction = Input.get_vector("left","right","up","down")
	if direction and not talking:
		velocity = direction * SPEED
	else:
		velocity = Vector2(0,0)
		global_position = global_position.round()
	%cam.global_position = global_position.round()
	move_and_slide()
	
	
	
	
