extends Node2D

var corner_points = [1,2,3,4]

func _ready():
	corner_points[0]=$corner0.position
	corner_points[1]=$corner1.position
	corner_points[2]=$corner2.position
	corner_points[3]=$corner3.position
	
	$Beta.init()

func apply_cam_shake():
	$Camera.apply_shake()

func _physics_process(_delta):
	if(has_node("Delta") && has_node("Alpha") && has_node("Beta")):
		$Delta.target.x = ($Alpha.position.x+$Beta.position.x)/2
		$Delta.target.y = ($Alpha.position.y+$Beta.position.y)/2

func trigger_aggression_mode():
	pass


func _on_agg_timer_timeout():
	$Alpha.agg()
	$Beta.agg()
	#$Gamma.agg()
	$Delta.agg()
