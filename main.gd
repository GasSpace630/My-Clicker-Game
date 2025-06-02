class_name MainUI
extends Control

# Creator info and stuff
@onready var game_info_lbl: Label = %GameInfo_lbl

# Click button section
@onready var click_btn_section: MarginContainer = %clickBtn_section
@onready var upgrade_progress_bar: ProgressBar = %upgrade_progressBar
@onready var click_btn: Button = %Click_btn

@onready var score_lbl: Label = %Score_lbl
@onready var upgrade_btn: Button = %Upgrade_btn
@onready var info_lbl: Label = %info_lbl
@onready var goto_option_btn: MenuButton = %gotoOption_btn

@onready var menu_btn: Button = %Menu_btn
@onready var backgrund_panel: Panel = $Backgrund_panel
@onready var top_panel: PanelContainer = %top_panel

@onready var settings_panel: Control = $SettingsPanel

var score : int # main socre
var score_incre : int = 1 # The amout by which the score increase per click
var click_fill: int = 0 # Upgrade progress fill
var up_cost : int = 10 # upgrade cost

func _ready() -> void:
	info_lbl.text = ""
	
	# Clicking the main click button
	click_btn.pressed.connect(func():
		score_btn_clicked()
		)
	# Clicking the Upgrade button
	upgrade_btn.pressed.connect(func():
		upgrade(up_cost)
		)
	# Clicking the Menu button
	menu_btn.pressed.connect(func():
		btn_click_effect(menu_btn)
		popup_effect(settings_panel)
		)
	
	goto_options_menu()

func score_btn_clicked():
	
	# Increase score
	# show effects : score label shake, button click effect
	# update screen elements: info label, score label, upgrade button
	
	score += score_incre
	shake_effect(score_lbl)
	score_lbl.text = "Score : "+str(score)
	click_btn.text = "+"+str(score_incre)
	upgrade_btn.text = "Upgrade : "+str(up_cost)
	btn_click_effect(click_btn)
	info_lbl.text = ""

func upgrade(up_amount : int):
	# Update screen elements , show effects (code at last VVV)
	
	if score >= up_amount and click_fill <= 10:
		
		# Filling the upgrade progress bar
		# show effects
		
		click_fill += 1
		upgrade_progress_bar.value = click_fill
		score -= up_amount
		shake_effect(score_lbl)
		shake_effect(click_btn_section)
		if click_fill == 10:
			
			# Increase score multiplier per click
			
			click_fill = 0
			upgrade_progress_bar.value = click_fill
			up_cost += up_amount
			score_incre += 1
			info_lbl.text = "Button Upgraded"
	else:
		info_lbl.text = "Not enough score"

	upgrade_btn.text = "Upgrade : "+str(up_cost)
	click_btn.text = "+"+str(score_incre)
	score_lbl.text = "Score : "+str(score)
	btn_click_effect(upgrade_btn)

func goto_options_menu():
	goto_option_btn.get_popup().index_pressed.connect(func(index:int):
		if index == 0:
			print("bottles")
		)


# VVV - CUSTOM EFFECTS - VVV

func shake_effect(container_name):
	var tween = get_tree().create_tween()
	container_name.pivot_offset = container_name.size/2
	tween.tween_property(container_name , "rotation_degrees" , 10 , 0.1).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(container_name , "rotation_degrees" , -10 , 0.1).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(container_name , "rotation" , 0 , 0.1).set_trans(Tween.TRANS_ELASTIC)

func btn_click_effect(button : Button):
	var tween = get_tree().create_tween()
	button.pivot_offset = button.size/2
	tween.tween_property(button , "scale" , Vector2(0.8,0.8) , 0.05)
	tween.tween_property(button , "scale" , Vector2(1.1,1.1) , 0.05)
	tween.tween_property(button , "scale" , Vector2(1,1) , 0.05)

func popup_effect(container):
	var tween = get_tree().create_tween()
	if container.scale != Vector2(0,0):
		tween.tween_property(container , "scale" , Vector2(0,0) , 0.01)
	container.pivot_offset = container.size/2
	tween.tween_property(container , "visible" , true , 0.001)
	tween.tween_property(container , "scale" , Vector2(1,1) , 0.1).set_ease(Tween.EASE_OUT)
