extends Area2D
class_name Hitbox

@export var health: Health


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  # let the parent controll the collision layer
  for i in range(1, 33):
    self.set_collision_layer_value(i, get_parent().get_collision_layer_value(i))
    self.set_collision_mask_value(i, get_parent().get_collision_mask_value(i))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
  pass


func _on_area_entered(area: Area2D) -> void:
  print_debug("body entered")
  health.hit(5)
