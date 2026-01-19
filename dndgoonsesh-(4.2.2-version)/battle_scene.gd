extends Node2D

# Visual variables
@export var cameraMove = true
var campos = 0
var cam_reach = 15
var cam_speed = 1.5
var time = 0
var enemyTweak = 1
var p1t = false
var p2t = false
var p3t = false
var p4t = false
var p5t = false
var p6t = false

var p1p = false

var p1d = false
var pSelected = -1
var mSelected = -1
var moff = Vector2(0,0)
var mHold = -1
var mHover = -1

var currMove = Move.new()
var currPlayer = "null"

var diceHigh = preload("res://assets/sprites/ui/battle/d201.png")
var diceMed = preload("res://assets/sprites/ui/battle/d202.png")
var dicePoor = preload("res://assets/sprites/ui/battle/d203.png")
var diceLow = preload("res://assets/sprites/ui/battle/d204.png")
var mReady = preload("res://assets/sprites/ui/battle/buttonReady.png")
var mPressed = preload("res://assets/sprites/ui/battle/buttonPressed.png")
# turnbased variables
var turn = "player" # else "battle"
# Called when the node enters the scene tree for the first time.
func _ready():
	Battlemain.numPlayers = len(Main.party)
	visualstart()
	statstart()
	cboot()
func statstart():
	if Battlemain.numPlayers == 6:
		pass
	if Battlemain.numPlayers >= 5:
		pass
	if Battlemain.numPlayers >= 4:
		pass
	if Battlemain.numPlayers >= 3:
		pass
	if Battlemain.numPlayers >= 2:
		pass
	%p1name.text = str(Main.party[0].name)
	%p1statz.text = str(Main.party[0].hp) + "/" + str(Main.party[0].maxhp) + " Lv" + str(Main.party[0].lv)
func visualstart():
	%enemy.texture = Battlemain.enemysprite
	cam_reach = cam_reach if cameraMove else 0
	# find out how to make the console scroll thing work from anywhere inside the console box and not the tiny [Darn!][Freaking!] scroll bar
	#%console.schrollo
	var bling = RichTextLabel.new()
	bling.get_v_scroll_bar().get_rect().size = Vector2(10,10)
	%vs.text = "VS. " + Battlemain.enemycharacter.name
	if len(Main.party) >= 6:
		%p6.visible = true
		%p6bar.visible = true
	if len(Main.party) >= 5:
		%p5.visible = true
		%p5bar.visible = true
	if len(Main.party) >= 4:
		%p4.visible = true
		%p4bar.visible = true
	if len(Main.party) >= 3:
		%p3.visible = true
		%p3bar.visible = true
	if len(Main.party) >= 2:
		%p2.visible = true
		%p2bar.visible = true
	%p1.visible = true
	%p1button.visible = true
	
func visualfx(time):
	var camboby = sin(time * cam_speed / 1.5) * cam_reach
	var cambobyy = cos(time * cam_speed / 1.5) * cam_reach / 2
	var cambobx = cos(time * cam_speed) * cam_reach
	var cambobxx = sin(time * cam_speed) * cam_reach / 2
	%cam.position.y = camboby + cambobyy
	%cam.position.x = cambobx + cambobxx
	%enemy.position.x = 89 + (sin(time * enemyTweak) * enemyTweak)
	%enemy.position.y = (sin(time * enemyTweak * 2) * enemyTweak)
	%dice.texture_normal = dicePoor if (mHover != -1 and mHold == -1 and mSelected == -1) else (diceMed if mHold != -1 else (diceHigh if mSelected != -1 else diceLow))
	%m1but.texture = mReady if (mHold != 1 and mSelected != 1) else (mPressed if (mHold == 1 and mSelected != 1) else mReady)
	%console.get_v_scroll_bar().value = %VScrollBar.value if turn == "battle" else %console.get_v_scroll_bar().value
func hoverfx(time):
	var col = int(sin(time * 5) * 100) + 255
	%dice.modulate = Color8(col,col,col) if mSelected != -1 else Color8(255,255,255)
	if (p1t or p1p) and not p1d:
		%p1button.position.y = lerpf(%p1button.position.y, 281, 0.005)
		
		#col = 400 if col > 400 else col
		#print(col)
		%p1button.modulate = Color8(col,col,col) if not p1p else Color8(255,255,255)
		
		if p1p:
			%p1button.material.set_shader_parameter('strength',0.1)
			%p1.material.set_shader_parameter('border_visibility',1)
		else:
			%p1button.material.set_shader_parameter('strength',0)
			%p1.material.set_shader_parameter('border_visibility',0.33)
	else:
		if p1d:
			%p1button.position.y = lerpf(%p1button.position.y, 340, 0.005)
		else:
			%p1button.position.y = lerpf(%p1button.position.y, 301, 0.005)
		%p1button.modulate = Color8(255,255,255)
		%p1button.material.set_shader_parameter('strength',0)
		%p1.material.set_shader_parameter('border_visibility',0)
func lerpfx(time):
	if (pSelected != -1 and not collide(%m1button.position,%m1button.size,%mSlot.position,%mSlot.size)) and not %aura.position.y <= 264.5:
		%aura.position.y = lerpf(%aura.position.y, 264.5, 0.005)
	if ((pSelected == -1) or collide(%m1button.position,%m1button.size,%mSlot.position,%mSlot.size)) and not %aura.position.y >= 405:
		%aura.position.y = lerpf(%aura.position.y, 405, 0.005)
	if pSelected != -1 and not %dice.position.y <= 130.5:
		%dice.position.y = lerpf(%dice.position.y, 130.5, 0.005)
	if pSelected == -1 and not %dice.position.y >= 400:
		%dice.position.y = lerpf(%dice.position.y, 400, 0.005)
		
	#262 -> 400
	if ((pSelected == -1) or mSelected != -1) and not %consoleBody.position.y <= 262:
		%consoleBody.position.y = lerpf(%consoleBody.position.y, 262, 0.005)
	if (pSelected != -1 and mSelected == -1) and not %consoleBody.position.y >= 400:
		%consoleBody.position.y = lerpf(%consoleBody.position.y, 400, 0.005)
		
	if ((pSelected == -1) or mSelected != -1) and not %console.position.y <= 204:
		%console.position.y = lerpf(%console.position.y, 204, 0.005)
	if (pSelected != -1 and mSelected == -1) and not %console.position.y >= 342:
		%console.position.y = lerpf(%console.position.y, 342, 0.005)
	
	# 700 -> 465.5
	
	if ((pSelected == -1) or collide(%m1button.position,%m1button.size,%mSlot.position,%mSlot.size)) and not %descBody.position.x >= 700:
		%descBody.position.x = lerpf(%descBody.position.x, 700, 0.005)
	if pSelected != -1 and not collide(%m1button.position,%m1button.size,%mSlot.position,%mSlot.size) and not %descBody.position.x <= 465.5:
		%descBody.position.x = lerpf(%descBody.position.x, 465.5, 0.005)
		
	if ((pSelected == -1) or collide(%m1button.position,%m1button.size,%mSlot.position,%mSlot.size)) and not %desc.position.x >= 608.5:
		%desc.position.x = lerpf(%desc.position.x, 608.5, 0.005)
	if pSelected != -1 and not collide(%m1button.position,%m1button.size,%mSlot.position,%mSlot.size) and not %desc.position.x <= 374:
		%desc.position.x = lerpf(%desc.position.x, 374, 0.005)
		
	if (pSelected == -1 or mSelected == -1 or mHold != -1) and not %typebox.position.y >= 343:
		%typebox.position.y = lerpf(%typebox.position.y, 343, 0.005)
	if (pSelected != -1 and mSelected != -1 and mHold == -1) and not %typebox.position.x <= 213:
		%typebox.position.y = lerpf(%typebox.position.y, 213, 0.005)
	if len(%typebox.text) > 0 and (pSelected != -1 and mSelected != -1 and mHold == -1) and not %rollButton.position.x <= 289.5:
		%rollButton.position.y = lerpf(%rollButton.position.y, 289.5, 0.02)
	elif not %rollButton.position.x >= 439:
		%rollButton.position.y = lerpf(%rollButton.position.y, 439, 0.005)
	if mCollide(%rollButton.get_local_mouse_position(),%rollButton.size):
		%rollButton.scale = lerp(%rollButton.scale, Vector2(2.25,2.25),0.005)
		%rollButton.pivot_offset = (%rollButton.scale - Vector2(2,2)) * (%rollButton.size / 2)
	else:
		%rollButton.scale = lerp(%rollButton.scale, Vector2(2,2),0.005)
		%rollButton.pivot_offset = (%rollButton.scale - Vector2(2,2)) * (%rollButton.size / 2)
	#if pSelected and not %aura.position.y <= 264.5:
		#%aura.position.y = lerpf(%aura.position.y, 264.5, 0.005)
	#if not pSelected and not %aura.position.y >= 405:
		#%aura.position.y = lerpf(%aura.position.y, 405, 0.005)
	
	#%dice.material.set_shader_parameter('strength',0 if mSelected == -1 else 0.1)
	%mSlot.position.x = lerpf(%mSlot.position.x,384.5,0.01) if (mHold != -1 or mSelected != -1) else lerpf(%mSlot.position.x,619,0.005)
	if mHold == 1:
		#%m1button.global_position = (get_viewport().get_mouse_position() / 2)
		%m1button.global_position = (get_viewport().get_mouse_position() / 2) - (moff * 2)
		
	elif pSelected != -1:
		%m1button.position = lerp(%m1button.position, Vector2(384.5,131.5), 0.005) if mSelected == 1 else lerp(%m1button.position, Vector2(405,198), 0.005)
	if pSelected == -1:
		%m1button.position = lerp(%m1button.position, Vector2(600,198), 0.005)
	if (mHover == 1 and not collide(%m1button.position,%m1button.size,%mSlot.position,%mSlot.size)):
		%m1descBody.modulate.a = lerpf(%m1descBody.modulate.a, 1, 0.005)
		%m1descText.modulate.a = lerpf(%m1descText.modulate.a, 1, 0.005)
	else:
		%m1descBody.modulate.a = lerpf(%m1descBody.modulate.a, 0, 0.01)
		%m1descText.modulate.a = lerpf(%m1descText.modulate.a, 0, 0.01)
	if mHover == 1 and mCollide(%m1button.get_local_mouse_position(),%m1button.size):		
		%m1button.scale = lerp(%m1button.scale, Vector2(2.25,2.25),0.005)
		%m1button.pivot_offset = (%m1button.scale - Vector2(2,2)) * (%m1button.size / 2)
	else:
		%m1button.scale = lerp(%m1button.scale, Vector2(2,2),0.005)
		%m1button.pivot_offset = (%m1button.scale - Vector2(2,2)) * (%m1button.size / 2)

# TODO TODO TODO TODO TODO TODO TODO

# Created a new resource "battleattack" to be added to Battlemain.battleattacks when done...
# roll function adds a battleattack to Battlemain.battleattacks, next to program:

# - Progress from roll() to battle() when all players done with attacking (or player num is 1)

# - Program an enemy attack ai to attack either at random or wit sum variance

func pDeselect():
	pSelected = -1
	rconsole("Who should fight " + Battlemain.enemycharacter.name + "?\n")
	mSelected = -1

func mCollide(mpos,objectsize):
	var xCollide = not(mpos.x < 0) and not(mpos.x > objectsize.x)
	var yCollide = not(mpos.y < 0) and not(mpos.y > objectsize.y)
	var collide = xCollide and yCollide
	
	return collide
	
func mPosCollide(mpos,objectsize,objectpos):
	var xCollide = not(mpos.x < 0) and not(mpos.x > objectsize.x)
	var yCollide = not(mpos.y < 0) and not(mpos.y > objectsize.y)
	var collide = xCollide and yCollide
	
	return collide
	
func collide(collpos,collsize,objpos,objsize):
	var xCollide = not(collpos.x + collsize.x < objpos.x) and not(collpos.x > objpos.x + objsize.x)
	var yCollide = not(collpos.y + collsize.y < objpos.y) and not(collpos.y > objpos.y + objsize.y)
	var collide = xCollide and yCollide
	
	return collide
	
func _process(delta):
	time += delta
	visualfx(time)
	hoverfx(time)
	lerpfx(time)
	pass
func cboot():
	rconsole()
	p("Who should fight " + Battlemain.enemycharacter.name + "?")
func rconsole(x: String = ""):
	%console.text = x
func p(txt):
	%console.text += (">> " + str(txt) + "\n")
func pui(player):
	if pSelected != -1:
		%aura.visible = true
	else:
		%aura.visible = false
	var b = len(player.normMoves)
	if b > 3:
		%m4button.visible = true
	if b > 2:
		%m3button.visible = true
	if b > 1:
		%m2button.visible = true
	if b > 0:
		%m1button.visible = true
		%m1lv.text = "[center]Lv. " + str(player.normMoves[0].levelReq) + "[/center]"
		%m1desc.text = "[center]" + str(player.normMoves[0].name) + " - " + str(player.normMoves[0].damage) + "[/center]"
		%m1descText.text = ">> " + player.normMoves[0].desc + " " + str(player.normMoves[0].damage) + "dmg|" + str(player.normMoves[0].chance) + "%|" + str(player.normMoves[0].auraPerc) + " aura|lv." + str(player.normMoves[0].levelReq)
	%desc.text = ">> " + player.name + " | HP: " + str(player.hp) + "/" + str(player.maxhp) + " | DMG: " + str(player.dmg) + "/" + str(player.damage) + " | LCK: " + str(player.lck) + "/" + str(player.luck) + " | DEF: " + str(player.def) + "/" + str(player.defense) + " | ARA: " + str(player.ara) + "/" + str(player.aura)
	%desc.text += "\n>> " + str(player.desc)
func mui(player,move):
	rconsole()
	currMove = move
	currPlayer = player
	p(player.name + move.action + Battlemain.enemycharacter.name + " by... ")
	%typebox.text = ""
	pass
func _on_p_1_button_mouse_entered(): # pos (2,301)
	p1t = true
func _on_p_1_button_mouse_exited():
	p1t = false
func _on_p_1_button_button_down():
	if p1p == false:
		p1p = true
		p(Main.party[0].name + " was selected!")
		pSelected = 0
		pui(Main.party[0])
		#%p1button.material.set_shader_parameter('strength',0.1)
	else:
		p1p = false
		pDeselect()
		
		#%p1button.material.set_shader_parameter('strength',0.1)




func _on_m_1_button_button_down():
	if pSelected != -1:
		moff = %m1button.get_local_mouse_position()
		mHold = 1
		mSelected = -1
		

func _on_m_1_button_button_up():
	if collide(%m1button.position,%m1button.size,%mSlot.position,%mSlot.size):
		mSelected = 1
		mui(Main.party[pSelected],Main.party[pSelected].normMoves[0])
	else:
		mSelected = -1
	mHold = -1

func _on_m_1_button_mouse_entered():
	mHover = 1


func _on_m_1_button_mouse_exited():
	mHover = -1

func roll():
	# ONLY TURN TO turn = "battle" IF ALL PLAYERS HAVE ATTACKED OR PLAYERCOUNT = 1
	# This is mainly js to add the attack to Battlemain.battleattacks otherwise
	var attack = battleattack.new()
	attack.attack = currMove
	attack.attacker = currPlayer
	attack.target = Battlemain.enemycharacter
	attack.text = %typebox.text
	Battlemain.battleattacks.append(attack)
	print("-------------------")
	for attacka in Battlemain.battleattacks:
		print("-+=+-")
		print(attacka.attack.name)
		print(attacka.attacker.name)
		print(attacka.target.name)
		print(attacka.text)
		print("-+=+-")
	print("-------------------")
	if len(Main.party) == 1:
		p1d = true
		reset()
		battle()
	else:
		if p1p:
			p1d = true
		reset()
		pass

func reset():
	p1p = false
	
	%VScrollBar.value = 0
	
	pSelected = -1
	mSelected = -1
	moff = Vector2(0,0)
	mHold = -1
	mHover = -1
	currMove = Move.new()
	currPlayer = "null"
	turn = "player"
	
	pass

func attack(atk):
	p(atk.attacker.name + atk.attack.action + atk.target.name + " by " + atk.text + "!")
	if calcchance(atk.attack):
		var roll = diceroll()
		var dmg = calcdmg(atk.attack,atk.attacker,atk.target,roll)
		p(("[color=green]PERFECT ROLL![/color] " if roll == 20 else ("[color=orange]Abysmal roll...[/color] " if (roll == 1 or dmg == 0) else "")) + atk.target.name + " took " + str(dmg) + " dmg.")
func calcdmg(atk, atker, target, roll):
	var ting = int(((atk.damage / 100 * 2 * atker.dmg) * (roll / 10.0)) - target.def)
	if ting < 0:
		ting = 0
	return ting

func diceroll():
	var y = RandomNumberGenerator.new().randi_range(1,20)
	return y
	
func calcchance(atk):
	var pluh = RandomNumberGenerator.new()
	var x = pluh.randi_range(1,100)
	return (x <= atk.chance)

func battle():
	turn = "battle"
	rconsole("[center] -+= BATTLE START=+- [/center]\n")
	for atak in Battlemain.battleattacks:
		for i in range(20):
			attack(atak)
	
func _on_roll_button_pressed():
	roll()
