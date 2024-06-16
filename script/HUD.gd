extends Control


@onready var spawner_ground = $"../../allybase/SpawnerGround"
@onready var spawner_water = $"../../allybase/SpawnerWater"
@onready var spawner_air = $"../../allybase/SpawnerAir"

@onready var ally_base = %allybase

@onready var selected_spawner = spawner_ground
@onready var selected_button = $buttonSpawnerGround
@onready var selected_spawner_name = "ground"



func _ready():
	$ButtonUnit1.connect("pressed",_on_UnitButton_pressed.bind("soldier"),0)
	$ButtonUnit2.connect("pressed",_on_UnitButton_pressed.bind("ranged"), 1)
	$ButtonUnit3.connect("pressed", _on_UnitButton_pressed.bind("tank"), 2)

	$buttonSpawnerGround.connect("pressed",_on_SpawnerButton_pressed.bind(spawner_ground, $buttonSpawnerGround),0)
	$ButtonSpawnerWater.connect("pressed",_on_SpawnerButton_pressed.bind(spawner_water, $ButtonSpawnerWater),1)
	$ButtonSpawnerAir.connect("pressed",_on_SpawnerButton_pressed.bind(spawner_air, $ButtonSpawnerAir),2)
	

func _process(delta):
	$HealthLabel.text=str(ally_base.current_health)
	$MoneyLabel.text=str(ally_base.current_money)

func _on_UnitButton_pressed(unit_type):
	if selected_spawner == spawner_ground:
		selected_spawner_name = "ground"
	if selected_spawner == spawner_air:
		selected_spawner_name = "air"
	if selected_spawner == spawner_water:
		selected_spawner_name = "water"
	var cost = selected_spawner.info_unit(unit_type+"_"+selected_spawner_name).cost
	if ally_base.buy(cost):
		selected_spawner.spawn_unit(unit_type+"_"+selected_spawner_name)
			
func _on_SpawnerButton_pressed(spawner, button):
	# Reset the style of the previously selected button
	var style = selected_button.get("theme_override_styles/normal")
	selected_button.get
	style = style.duplicate(true)
	style.border_width_left = 0
	style.border_width_top = 0
	style.border_width_right = 0
	style.border_width_bottom = 0
	selected_button.set("theme_override_styles/normal", style)

	# Update the selected spawner and button
	selected_spawner = spawner
	selected_button = button

	# Apply a new style to the selected button
	style = selected_button.get("theme_override_styles/normal")
	style = style.duplicate(true)
	style.border_width_left = 2
	style.border_width_top = 2
	style.border_width_right = 2
	style.border_width_bottom = 2
	selected_button.set("theme_override_styles/normal", style)
