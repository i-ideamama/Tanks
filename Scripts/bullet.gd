extends CharacterBody2D

var speed = 3
var dir = Vector2.ZERO
var bounce_count=0
var max_bounce_count=3

func _ready():
	# adding collision exceptions
	self.add_collision_exception_with(get_parent().get_node("Player"))
	self.add_collision_exception_with(get_parent().get_node("Alpha"))
	self.add_collision_exception_with(get_parent().get_node("Beta"))
	self.add_collision_exception_with(get_parent().get_node("Gamma"))
	self.add_collision_exception_with(get_parent().get_node("Delta"))
	

func init():
	var angle = get_angle_to(dir)
	self.rotation+=angle

func _physics_process(_delta):
	# implementing bullet reflection
	var v = move_and_collide(speed*dir)
	if v != null:
		if (v.get_collider() is TileMap):
			dir=dir.reflect(v.get_normal())
			dir.x*=-1
			dir.y*=-1
			self.rotation=dir.angle()+(PI/2)
			bounce_count+=1
			if(bounce_count>=max_bounce_count):
				queue_free()

func _on_area_2d_body_entered(body):
	# making bullet disappear on collision with enemy
	if (body.name in ["Alpha","Beta","Gamma","Delta"]):
		queue_free()
