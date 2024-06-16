extends Node

class_name UnitSystem

signal died
signal damage_taken(current_health: int)


@export var damage:int
@export var base_health:int
@export var cost:int
@export var type:String
var current_health

func _ready():
	current_health=base_health
	
func take_damage(damage: int):
	current_health -= damage
	damage_taken.emit(current_health)
	if current_health <= 0:
		died.emit()
		
func make_damage(damage:int,target:UnitSystem):
	target.take_damage(damage)
	


