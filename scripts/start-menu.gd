extends Control

@export var camera: Camera2D
@export var move_duration: float = 4.0
@export var target_position: Vector2
@onready var button = $VBoxContainer/Button

func _on_button_pressed():
	move_camera_to_position()
	
func move_camera_to_position():
	# Release button
	button.release_focus()
	
	# Move camera to start of the level
	var tween = create_tween()
	tween.tween_property(camera, "position", target_position, move_duration)
	
