extends CharacterBody2D

var movement_speed: float = 100.0
var movement_target_position = Vector2(1500,800)

@export var player: CharacterBody2D
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

var current_angle

var bullet = load("res://Scenes/enemy_bullet.tscn")
var explosion = load("res://Scenes/explosion.tscn")

func _ready():
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0
	call_deferred("actor_setup")
	current_angle = get_angle_to(movement_target_position)
	
func actor_setup():
	await get_tree().physics_frame
	set_movement_target(movement_target_position)

func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target


func _physics_process(delta):
	$Barrel.look_at(player.position)
	if navigation_agent.is_navigation_finished():
		return

	
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	var new_velocity: Vector2 = next_path_position - current_agent_position
	new_velocity = new_velocity.normalized()
	new_velocity = new_velocity * movement_speed
	
	dir_change(next_path_position)
	velocity = new_velocity
	move_and_slide()


func _on_timer_timeout():
	set_movement_target(player.position)
	
func dir_change(point):
	if (get_angle_to(point)!=current_angle):
		adj_dir()

func adj_dir():
	self.look_at(navigation_agent.get_next_path_position())
	self.rotate(-PI/2)
	#var tween
	#tween.tween_property(self, "rotation", tween_duration)



func _on_hit_box_body_entered(body):
	if ("Bullet" in body.name):
		queue_free()


func _on_shoot_timer_timeout():
	shoot()

func shoot():
	var pos = Vector2(60,0)
	# bullet
	var b = bullet.instantiate()
	get_parent().add_child(b)
	b.name="Eullet"
	b.global_position = $Barrel/BulletSpawn.global_position
	var direction_to_player = self.global_position.direction_to(player.position).normalized()
	b.dir = direction_to_player
	b.init()
