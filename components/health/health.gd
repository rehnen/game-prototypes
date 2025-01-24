extends Node2D
class_name Health

signal health_depleted(node: Node2D)

@export var MAX_HEALTH: int= 10
var health: int
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
  health = MAX_HEALTH
  $Label.text = str("HP: ", health)
  pass # Replace with function body.



func hit(damage: int) -> void:
  health -= damage
  if (health <= 0):
    health_depleted.emit(self)
  
  $Label.text = str("HP: ", health)
    
