extends Node2D

class_name Spawner

const unit_scenes = {
	"tank_ground":preload("res://scenes/units/tank_ground.tscn"),
	"soldier_ground":preload("res://scenes/units/soldier_ground.tscn"),
	"ranged_ground":preload("res://scenes/units/ranged_ground.tscn"),
	"tank_air":preload("res://scenes/units/tank_air.tscn"),
	"soldier_air":preload("res://scenes/units/soldier_air.tscn"),
	"ranged_air":preload("res://scenes/units/ranged_air.tscn"),
	"tank_water":preload("res://scenes/units/tank_water.tscn"),
	"soldier_water":preload("res://scenes/units/soldier_water.tscn"),
	"ranged_water":preload("res://scenes/units/ranged_water.tscn")
}

const unit_infos = {
	"tank_ground":preload("res://ressources/unit_ressources/tank_ground.tres"),
	"soldier_ground":preload("res://ressources/unit_ressources/soldier_ground.tres"),
	"ranged_ground":preload("res://ressources/unit_ressources/ranged_ground.tres"),
	"tank_air":preload("res://ressources/unit_ressources/tank_air.tres"),
	"soldier_air":preload("res://ressources/unit_ressources/soldier_air.tres"),
	"ranged_air":preload("res://ressources/unit_ressources/ranged_air.tres"),
	"tank_water":preload("res://ressources/unit_ressources/tank_water.tres"),
	"soldier_water":preload("res://ressources/unit_ressources/soldier_water.tres"),
	"ranged_water":preload("res://ressources/unit_ressources/ranged_water.tres")
}

@onready var base_name = get_parent().get_name()
var spawn_timer = 0

func spawn_unit(unit_type):
	var unit = unit_scenes[unit_type].instantiate()
	add_child(unit)
	unit.global_position = global_position

func info_unit(unit_type):
	return unit_infos[unit_type]

func spawn_unit_enemy():
	var keys = unit_scenes.keys()
	var random_key_index = randi_range(0, keys.size() - 1)
	var random_key = keys[random_key_index]
	
	var unit = unit_scenes[random_key].instantiate()
	add_child(unit)
	unit.global_position = global_position

func _process(delta):
	if base_name =="enemybase":
		spawn_timer += delta
		if spawn_timer >= 5:  # spawn a unit every 5 seconds
			spawn_unit_enemy() 
			spawn_timer = 0


