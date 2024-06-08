extends Camera2D

@onready var camera = $"."
@onready var main_menu = $"../MainMenu"
@onready var section_triggers = $"../SectionTriggers"


func move_camera_to_position(target_position: Vector2, move_duration: float):
	print("move_camera_to_position")
	perform_camera_movement(target_position, move_duration)

# Called when the node enters the scene tree for the first time.
func _ready():
	# Connect to signals that will move the camera
	main_menu.move_camera_to_position.connect(move_camera_to_position)
	for section_trigger in section_triggers.get_children():
		if section_trigger.has_signal("move_camera_to_level_section"):
			section_trigger.move_camera_to_level_section.connect(move_camera_to_level_section)
	
func move_camera_to_level_section(target_position: Vector2, move_duration: float):
	print("move_camera_to_level_section")
	perform_camera_movement(target_position, move_duration)
	
func perform_camera_movement(target_position: Vector2, move_duration: float):
	# Move camera smoothly to target position
	var tween = create_tween()
	tween.tween_property(camera, "position", target_position, move_duration)
