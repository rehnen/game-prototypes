extends CharacterBody2D


@onready var player = get_parent().get_node("Player")

var normalized_direction: Vector2 = Vector2.ZERO;

func _init():
  var position_jitter = Vector2(randi_range(-300, 300), randi_range(-300, 300))
  var spawn = randi_range(1, 4)
  if spawn == 1:
    position = Vector2(0, -700) + position_jitter
  if spawn == 2:
    position = Vector2(700, 0) + position_jitter
  if spawn == 3:
    position = Vector2(0, 700) + position_jitter
  if spawn == 4:
    position = Vector2(-700, 0) + position_jitter

func animate(movement_direction: Vector2):
  var sprite: AnimatedSprite2D = get_node("Sprite")
  var up = -movement_direction.y;
  var down = movement_direction.y;
  var left = -movement_direction.x;
  var right = movement_direction.x;
  var max_val = max(up, down, left, right)
  if max_val == up:
    sprite.play("move_up")
  if max_val == down:
    sprite.play("move_down")
  if max_val == left:
    sprite.play("move_left")
  if max_val == right:
    sprite.play("move_right")


func _physics_process(delta):
  var movement_direction = position.direction_to(player.position)
  animate(movement_direction)
  velocity = movement_direction
  velocity = velocity.normalized() * 50
  velocity += velocity * delta
  move_and_slide()
