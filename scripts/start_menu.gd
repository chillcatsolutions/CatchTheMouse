extends Control

@export var move_duration: float = 4.0
@export var target_position: Vector2
@onready var button = $VBoxContainer/Button

# Declare signal to move the camera to the beggining of the level
signal move_camera_to_position(target_position, move_duration)

func _on_button_pressed():
	button.release_focus()
	move_camera_to_position.emit(target_position, move_duration)
	

	
