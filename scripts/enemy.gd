extends CharacterBody2D


@export var player : CharacterBody2D

var normalized_direction: Vector2 = Vector2.ZERO;

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

