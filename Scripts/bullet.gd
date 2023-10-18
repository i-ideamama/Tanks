extends Area2D

var speed = 30
var direction = Vector2.ZERO
var velocity = Vector2.ZERO

func _ready():
	velocity  = direction * speed

func _physics_process(_delta):
	velocity  = direction * speed
	global_position+=velocity


