extends Node2D


var Obstacle = preload("res://Obstacle.tscn")

var Enemy = preload("res://Enemy.tscn")
var cursor

# Called when the node enters the scene tree for the first time.
var path_cost_dict: Dictionary = {}
var obstacles: Dictionary = {}
var is_placeable = false
var enemies: Array[CharacterBody2D] = []


func calculate_path_costs():
  var tile_map: TileMap = get_node("TileMap");
  tile_map.get_used_cells(1)

  for tile in tile_map.get_used_cells(1):
    path_cost_dict[tile] = 1_000_000

func _init():
  print_debug("init game")
  for i in 100:
    var enemy = Enemy.instantiate()
    enemies.append(enemy)
    add_child(enemy)
  print_debug(enemies.size())


func _ready():
  #Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
  cursor = Obstacle.instantiate()
  cursor.get_node("CollisionShape2D").disabled = true
  add_child(cursor)
  pass # Replace with function body.

func build_walls():
  if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
    calculate_path_costs()
    var obstacle = Obstacle.instantiate()
    obstacle.position = Vector2(cursor.position)


    if get_global_mouse_position().x < 0:
      obstacle.position.x -= 8
    else:
      obstacle.position.x += 8

    if get_global_mouse_position().y < 0:
      obstacle.position.y -= 8
    else:
      obstacle.position.y += 8

    for child in get_children():
      if (child != cursor && is_collision(get_global_mouse_position(), child.position)):
        return #space is not empty


    path_cost_dict[obstacle.position] = 1_000_000

    add_child(obstacle)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
  cursor.position = get_global_mouse_position()
  cursor.position.x = cursor.position.x - fmod(cursor.position.x, 16 * scale.x) 
  cursor.position.y = cursor.position.y - fmod(cursor.position.y, 16 * scale.x) 
  build_walls()

  if get_global_mouse_position().x < 0:
    cursor.position.x -= 8
  else:
    cursor.position.x += 8

  if get_global_mouse_position().y < 0:
    cursor.position.y -= 8
  else:
    cursor.position.y += 8

func is_collision(v1: Vector2, v2: Vector2):
  var v1_bottom = v1 + Vector2(15, 15)
  var v2_bottom = v2 + Vector2(15, 15)
  return (v1.x + 1 < v2_bottom.x && v1_bottom.x > v2.x &&
    v1.y + 1 < v2_bottom.y && v1_bottom.y > v2.y)
