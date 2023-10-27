extends Node2D

@onready var global = get_node("/root/Global")

var corner_points = [1,2,3,4]
var time= Time.get_ticks_msec()
var elapsed_time
var enemy_count = 4

func _ready():
	corner_points[0]=$corner0.position
	corner_points[1]=$corner1.position
	corner_points[2]=$corner2.position
	corner_points[3]=$corner3.position
	$Alpha.init()
	$Beta.init()
	$Gamma.init()
	$Delta.init()
	

func apply_cam_shake():
	$Camera.apply_shake()

func _physics_process(_delta):
	if(has_node("Delta") && has_node("Alpha") && has_node("Beta")):
		$Delta.target.x = ($Alpha.position.x+$Beta.position.x)/2
		$Delta.target.y = ($Alpha.position.y+$Beta.position.y)/2
#timer
func _process(delta):
	elapsed_time = snapped((Time.get_ticks_msec() - time)/1000.0, 0.1)
	$CanvasLayer/Label.text = "{s} secs".format({"s": elapsed_time})

# aggression mode for enemy tanks
func trigger_aggression_mode():
	if(self.has_node("Alpha")):
		$Alpha.agg()
	if(self.has_node("Beta")):
		$Beta.agg()
	if(self.has_node("Gamma")):
		$Gamma.agg()
	if(self.has_node("Delta")):
		$Delta.agg()


func _on_agg_timer_timeout():
	$Alpha.agg()
	$Beta.agg()
	$Gamma.agg()
	$Delta.agg()

func check_win():
	if(enemy_count == 0):
		win()

func lose():
	global.win=false
	get_tree().change_scene_to_file("res://Scenes/end.tscn")

func win():
	global.win=true
	var old_high_score = l()
	var new_score = elapsed_time
	
	
	global.current_level = 1
	
	if ((int(old_high_score)==0) or (new_score<int(old_high_score))):
		save(str(new_score))
		global.lvl1_high = str(new_score)
		global.high = true
	else:
		global.high = false
	
	global.elapsed_time = elapsed_time
	get_tree().change_scene_to_file("res://Scenes/end.tscn")
	
# read and write to files
func save(content):
	var file = FileAccess.open("user://level1_score.dat", FileAccess.WRITE)
	file.store_string(content)

func l():
	var file = FileAccess.open("user://level1_score.dat", FileAccess.READ)
	var content = file.get_as_text()
	return content
