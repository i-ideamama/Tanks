extends Node2D

func apply_cam_shake():
	$Camera.apply_shake()

func _physics_process(_delta):
	if(has_node("Delta") && has_node("Alpha") && has_node("Beta")):
		$Delta.target.x = ($Alpha.position.x+$Beta.position.x)/2
		$Delta.target.y = ($Alpha.position.y+$Beta.position.y)/2

func trigger_aggression_mode():
	pass
