extends CharacterBody2D

class_name Ranged



const RANGED = {
	"SpawnerGround":preload("res://ressources/unit_ressources/ranged_ground.tres"),
	"SpawnerAir":preload("res://ressources/unit_ressources/ranged_air.tres"),
	"SpawnerWater":preload("res://ressources/unit_ressources/ranged_water.tres")
}

signal died

var damage 
var health
var cost 
var type
var speed
var direction
var range_distance

@onready var spawner_name = get_parent().get_name()
@onready var base_name = get_parent().get_parent().get_name()

var current_target = null
var attack_cooldown = 3.0  # The attack cooldown in seconds
var attack_timer = 0.0  # The current time since the last attack


func _ready():
	damage = RANGED[spawner_name].damage
	health = RANGED[spawner_name].health
	cost = RANGED[spawner_name].cost
	type = RANGED[spawner_name].type
	speed = RANGED[spawner_name].speed
	if base_name == "enemybase":
		$Icon.flip_v= true
		$Icon.rotation = deg_to_rad(180)
		direction = RANGED[spawner_name].direction * -1
	else:
		direction = RANGED[spawner_name].direction
	range_distance = RANGED[spawner_name].range_distance

	$Icon/attack_range.connect("body_entered",_on_Area2D_body_entered)
	$Icon/attack_range.connect("body_exited", _on_Area2D_body_exited)
	connect("died", _on_died)

	$LifeBar.max_value = RANGED[spawner_name].health
	$LifeBar.value = health

func take_damage(damage_taken: int):
	health -= damage_taken
	$LifeBar.value = health
	if health <= 0:
		died.emit()

func make_damage(target):
	target.take_damage(damage)
	
func _on_Area2D_body_entered(body):
	var valid_body = false
	if body is Base || body.base_name != base_name :
		valid_body = true
	if body.has_method("take_damage") && valid_body:
		speed = 0
		current_target = body
		if attack_timer>=attack_timer:
			make_damage(body)
			attack_timer = 0.0

func _on_Area2D_body_exited():
	print("called")
	speed = RANGED[spawner_name].speed
	current_target = null

func _process(delta):
	attack_timer += delta
	position.x += direction.x * speed * delta
	if current_target == null or current_target.is_queued_for_deletion():
		var bodies = $Icon/attack_range.get_overlapping_bodies()  # Get the bodies that are still in range
		for b in bodies:
			if b is Base || b.base_name != base_name:  # Check if the body is the enemy base
				current_target = b  # Set the current target to the base
				speed = 0
				return
		speed = RANGED[spawner_name].speed
		current_target = null
	else:
		if attack_timer >= attack_cooldown:
			make_damage(current_target)
			attack_timer = 0.0  # Reset the attack timer
			if not current_target is Base :
				if current_target.health <= 0:  # Check if the target has died
					current_target = null

func _on_died():
	self.queue_free()
