extends CharacterBody2D

var speed = 3000
var dir = Vector2.ZERO

func _ready():
	self.add_collision_exception_with(get_parent().get_node("Player"))


func _physics_process(delta):
	var v = move_and_collide(30*dir)
	if v != null:
		if (v.get_collider() is TileMap):
			dir=dir.reflect(v.get_normal())
			dir.x*=-1
			dir.y*=-1
