extends Node

#@export var camera: Camera2D
#@export var move_duration: float = 4.0
#@export var level_start_position: Vector2


#func move_camera_to_position():
	#var tween = Tween.new()
	#add_child(tween)
	#tween.tween_property(camera, "position", level_start_position, move_duration, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	#tween.start()
	#tween.connect("finished", tween, "queue_free")
#
#func _on_menu_button_pressed():
	#move_camera_to_level()

# Called when the node enters the scene tree for the first time.
func _ready():
	# Connect signal to button
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
