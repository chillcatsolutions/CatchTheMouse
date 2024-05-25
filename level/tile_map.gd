extends TileMap


var secret_layer: int # You can have multiple layers if you make this an array.
var player_in_secret: bool
var layer_alpha := 1.0
var current_level := 1
var currentHeight := 245
const levelPositions := {
	1: Vector2(267, 230),
	2: Vector2(267, -216),
	3: Vector2(267, -680),
	4: Vector2(267, -1045)
}

@onready var camera_2d = $"../Camera2D"
@onready var player = $"../Player"


func _init() -> void:
	for i in get_layers_count(): # Find the secret layer by name.
		if get_layer_name(i) == "Secret":
			secret_layer = i


func _ready() -> void:
	set_process(false)


func _process(delta: float) -> void:
	if player_in_secret:
		if layer_alpha > 0.3:
			layer_alpha = move_toward(layer_alpha, 0.3, delta) # Animate the layer transparency.
			set_layer_modulate(secret_layer, Color(1, 1, 1, layer_alpha))
		else:
			set_process(false)
	else:
		if layer_alpha < 1.0:
			layer_alpha = move_toward(layer_alpha, 1.0, delta)
			set_layer_modulate(secret_layer, Color(1, 1, 1, layer_alpha))
		else:
			set_process(false)


func _use_tile_data_runtime_update(layer: int, _coords: Vector2i) -> bool:
	if layer == secret_layer:
		return true
	return false


func _tile_data_runtime_update(_layer: int, _coords: Vector2i, tile_data: TileData) -> void:
	tile_data.set_collision_polygons_count(0, 0) # Remove collision for secret layer.


func _on_secret_detector_body_entered(body: Node2D) -> void:
	if not body is CharacterBody2D: # Detect player only.
		return

	player_in_secret = true
	set_process(true)


func _on_secret_detector_body_exited(body: Node2D) -> void:
	if not body is CharacterBody2D:
		return

	player_in_secret = false
	set_process(true)
	
func _on_next_level_reached(body: Node2D) -> void:
	if not body is CharacterBody2D or body.name == "Enemy":
		return
	
	var move_duration = 1.0
	
	print("player.position.y")
	print(player.position.y)
	
	if ( player.position.y <= 8 and player.position.y > -464 ):
		current_level = 2
	
	if ( player.position.y <= -460 ):
		current_level = 3
	
	#camera_2d.translate(Vector2(0, -400))
	var target_position = levelPositions[current_level]
	var tween = create_tween()
	tween.tween_property(camera_2d, "position", target_position, move_duration)
	

func _on_next_level_lost(body: Node2D) -> void:
	if not body is CharacterBody2D or body.name == "Enemy":
		return
	
	current_level = 1
