extends Control

@onready var back_btn: Button = %Back_btn
@onready var theme_option_btn: OptionButton = %ThemeOption_btn
@onready var game_info_toggle_btn: CheckButton = %GameInfoToggle_btn

@onready var main = get_tree().get_first_node_in_group("main") # Refference the main scene

# THEMES
var blue_theme
var red_theme
var pink_theme
var black_theme

func _ready() -> void:
	# Loding custom themes
	blue_theme = preload("res://Styles/themes/BlueBG_theme.tres")
	red_theme = preload("res://Styles/themes/RedBG_theme.tres")
	pink_theme = preload("res://Styles/themes/PinkBG_theme.tres")
	black_theme = preload("res://Styles/themes/BlackBG_theme.tres")
	
	back_btn.pressed.connect(func(): # Going Back
		main.btn_click_effect(back_btn)
		popdown_effect(self)
		)
	
	# Toggle the visibility of gameinfo label
	game_info_toggle_btn.toggled.connect(func(toggled):
		if toggled:
			main.game_info_lbl.hide()
		else:
			main.game_info_lbl.show()
		)

func _on_theme_option_btn_item_selected(index: int) -> void:
	if index == 0:
		main.backgrund_panel.add_theme_stylebox_override("panel",blue_theme)
		main.top_panel.add_theme_stylebox_override("panel",blue_theme)
	if index == 1:
		main.backgrund_panel.add_theme_stylebox_override("panel",red_theme)
		main.top_panel.add_theme_stylebox_override("panel",red_theme)
	if index == 2:
		main.backgrund_panel.add_theme_stylebox_override("panel",pink_theme)
		main.top_panel.add_theme_stylebox_override("panel",pink_theme)
	if index == 3:
		main.backgrund_panel.add_theme_stylebox_override("panel",black_theme)
		main.top_panel.add_theme_stylebox_override("panel",black_theme)


# CUSTOM EFFECTS
func popdown_effect(container):
	var tween = get_tree().create_tween()
	container.pivot_offset = container.size/2
	tween.tween_property(container , "scale" , Vector2(0,0) , 0.1).set_ease(Tween.EASE_OUT)
	tween.tween_property(container , "visible" , false , 0.001)
