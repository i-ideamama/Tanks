extends CharacterBody2D

var speed = 3000
var direction

func _ready():
	self.add_collision_exception_with(get_parent().get_node("Player"))

func init():
	self.direction=direction
	velocity = speed * direction


func _physics_process(_delta):
	move_and_slide()

