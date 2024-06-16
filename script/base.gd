extends CharacterBody2D

class_name Base

@onready var loosing_screen = get_parent().get_node("LoosingScreen/Label")
@onready var winning_screen = get_parent().get_node("WinningScreen/Label")
@onready var tile_map = $"../TileMap"

@onready var spawner_ground = $"../allybase/SpawnerGround"
@onready var spawner_water = $"../allybase/SpawnerWater"
@onready var spawner_air = $"../allybase/SpawnerAir"


@onready var test_button = $TestButton
@onready var money_timer = $MoneyTimer

signal win()
signal loose()

@export var player:bool
@export var base_health:int = 500
@export var base_money:int =50000
@export var current_health:int
@export var current_money:int

@export var current_spawner:Spawner

func _ready():
	current_health=base_health
	current_money=base_money
	
	var timer = get_node("MoneyTimer")
	timer.connect("timeout", _on_Timer_timeout)
	
	if global_position[0] <1000:
		player = true
	else :
		player = false
		
	var button = get_node("TestButton")
	button.connect("pressed", _on_Button_pressed)
	connect("loose", _on_loose)
	connect("win", _on_win)
	
func take_damage(damage_taken: int):
	current_health -= damage_taken

	if current_health <= 0:
		if player:
			loose.emit()
		else : win.emit()

func buy(cost:int):
	if current_money >= cost:
		current_money -= cost
		return true
	return false	

func _on_Timer_timeout():
	current_money += 50
	#print("money counter: ", current_money)	

func _on_Button_pressed():
	take_damage(250)

func _on_loose():
	get_tree().change_scene_to_file("res://scenes/loosing_screen.tscn")
	print('lost')

func _on_win():
	get_tree().change_scene_to_file("res://scenes/winning_screen.tscn")
	print('won')
