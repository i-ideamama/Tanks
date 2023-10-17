extends CharacterBody2D


var speed = 200
var rotation_speed = 2.5

var rotation_dir = 0

func _ready():
	pass
	
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

func _physics_process(delta):
	# movement
	get_input()
	rotation += rotation_dir * rotation_speed * delta
	move_and_slide()
	
	# barrel control
	$Barrel.look_at(get_global_mouse_position())
	
