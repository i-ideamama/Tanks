extends RigidBody2D


func save(content):
	var file = FileAccess.open("user://level2_score.dat", FileAccess.WRITE)
	file.store_string(content)

func l():
	var file = FileAccess.open("user://level2_score.dat", FileAccess.READ)
	var content = file.get_as_text()
	return content

func _ready():
	save(str(100))
