extends CharacterBody2D

var speed = 3
var dir = Vector2.ZERO
var bounce_count=0
var max_bounce_count=5

func _ready():
	self.add_collision_exception_with(get_parent().get_node("Player"))


func _physics_process(_delta):
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
