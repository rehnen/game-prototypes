extends Node2D


var Obstacle = preload("res://Obstacle.tscn")
var cursor

# Called when the node enters the scene tree for the first time.
var path_cost_dict: Dictionary = {}
var obstacles: Dictionary = {}
var is_placeable = false

func calculate_path_costs():
  var player = get_node("Player")
  var tile_map: TileMap = get_node("TileMap");
  tile_map.get_used_cells(1)

  for tile in tile_map.get_used_cells(1):
    path_cost_dict[tile] = 1_000_000


func _ready():
  #Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
  cursor = Obstacle.instantiate()
  cursor.get_node("CollisionShape2D").disabled = true
  add_child(cursor)
  pass # Replace with function body.

func _input(event):
  if event is InputEventMouseButton && Input.is_action_pressed("left_click"):
    calculate_path_costs()
    var obstacle = Obstacle.instantiate()
    obstacle.position = get_global_mouse_position()

    obstacle.position.x = obstacle.position.x - fmod(obstacle.position.x, 16 * scale.x) 
    obstacle.position.y = obstacle.position.y - fmod(obstacle.position.y, 16 * scale.x) 

    if get_global_mouse_position().x < 0:
      obstacle.position.x -= 8
    else:
      obstacle.position.x += 8

    if get_global_mouse_position().y < 0:
      obstacle.position.y -= 8
    else:
      obstacle.position.y += 8

    var is_space_free= true

    for child in get_children():
      if (child != cursor && is_collision(cursor.position, child.position)):
        is_space_free = false

    if !is_space_free:
      return

    path_cost_dict[obstacle.position] = 1_000_000
    
    add_child(obstacle)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
  cursor.position = get_global_mouse_position()
  cursor.position.x = cursor.position.x - fmod(cursor.position.x, 16 * scale.x) 
  cursor.position.y = cursor.position.y - fmod(cursor.position.y, 16 * scale.x) 

  if get_global_mouse_position().x < 0:
    cursor.position.x -= 8
  else:
    cursor.position.x += 8

  if get_global_mouse_position().y < 0:
    cursor.position.y -= 8
  else:
    cursor.position.y += 8

  var is_space_free = true

  for child in get_children():
    if (child != cursor && is_collision(cursor.position, child.position)):
      is_space_free = false

  if is_space_free:
    cursor.get_node("Sprite").modulate.a = 1.0
  else:
    cursor.get_node("Sprite").modulate.a = 0.5
pass

func is_collision(v1: Vector2, v2: Vector2):
  var v1_bottom = v1 + Vector2(15, 15)
  var v2_bottom = v2 + Vector2(16, 16)
  return (v1.x + 1 < v2_bottom.x && v1_bottom.x > v2.x &&
    v1.y + 1 < v2_bottom.y && v1_bottom.y > v2.y)

  
