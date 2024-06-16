extends Camera2D

var speed = 700

func _process(delta):
	var velocity = Vector2()
	if Input.is_action_pressed('left'):
		velocity.x -= 100
	if Input.is_action_pressed('right'):
		velocity.x += 100
		
	velocity = velocity.normalized() * speed * delta

	position += velocity
