extends CharacterBody2D

# movement variables
var speed = 200
var rotation_speed = 2.5
var rotation_dir = 0

# preload scenes
var bullet = load("res://Scenes/bullet.tscn")

func get_input():
	rotation_dir = 0
	velocity = Vector2.ZERO
	if Input.is_action_pressed('right'):
		rotation_dir += 1
	if Input.is_action_pressed('left'):
		rotation_dir -= 1
	if Input.is_action_pressed('down'):
		velocity -= transform.y * speed
	if Input.is_action_pressed('up'):
		velocity += transform.y * speed
	if Input.is_action_just_pressed("shoot"):
		shoot()

func _physics_process(delta):
	# movement
	get_input()
	rotation += rotation_dir * rotation_speed * delta
	move_and_slide()
	
	# barrel control
	$Barrel.look_at(get_global_mouse_position())

func shoot():
	var b = bullet.instantiate()
	b.position = Vector2(60,0)
	var direction_to_mouse = self.global_position.direction_to(get_global_mouse_position()).normalized()
	print(direction_to_mouse )
	$Barrel.add_child(b)
	
	b.direction = direction_to_mouse
	
