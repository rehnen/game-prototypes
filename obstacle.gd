extends StaticBody2D

@export var color = "red"
@export var hp: int = 10
var current_hp: int = hp


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
  pass


func hit(attack_power)-> void:
  current_hp -= attack_power
  $Sprite.modulate.a = float(current_hp) / float(hp)
  if current_hp <= 0:
    self.queue_free()
  
