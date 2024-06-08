extends Area2D

@export var move_duration: float = 1
@export var above_position: Vector2
@export var below_position: Vector2

# Declare signal to move the camera to the beggining of the level
signal move_camera_to_level_section(target_position, move_duration)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if(body.is_in_group("player")):
		# Get velocity to check if the body is entering from above or below
		var velocity = body.velocity
		
		# If y velocity is positive the body is moving down
		if velocity.y > 0:
			print("El cuerpo ha entrado desde arriba")
			move_camera_to_level_section.emit(below_position, move_duration)
		else:
			print("El cuerpo ha entrado desde abajo")
			move_camera_to_level_section.emit(above_position, move_duration)
	else:
		print("_on_body_entered No player")
