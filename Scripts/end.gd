extends Control

@onready var global = get_node("/root/Global")

func _ready():
	# displaying text on the end screen
	if(global.win==true):
		if(global.high==false):
			$Label.text="{s} secs taken to clear level".format({"s": global.elapsed_time})
		else:
			if global.current_level==1:
				$Label.text="{s} secs high score in level 1".format({"s": global.elapsed_time})
			elif global.current_level==2:
				$Label.text="{s} secs high score in level 2".format({"s": global.elapsed_time})
	else:
		$Label.text="mission failed"
