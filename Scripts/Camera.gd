extends Camera2D

@export var random_strength: float = 30.0
@export var shake_fade: float = 5.0
var rng = RandomNumberGenerator.new()
var shake_strength: float = 0.0

func apply_shake():
	shake_strength = random_strength

func random_offset():
	return Vector2(rng.randf_range(-shake_strength,shake_strength),rng.randf_range(-shake_strength,shake_strength))

func _physics_process(delta):
	if(shake_strength > 0.0):
		shake_strength = lerpf(shake_strength,0,shake_fade*delta)
		offset = random_offset()
