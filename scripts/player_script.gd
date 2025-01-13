extends CharacterBody2D

var direction: Vector2 = Vector2()

func input_to_direction():
  var movement = Vector2.ZERO
  if !Input.is_anything_pressed():
      movement = Vector2.ZERO
  if Input.is_action_pressed("up"):
      movement.y -= 1
      direction = Vector2.UP
  if Input.is_action_pressed("down"):
      movement.y += 1;
      direction = Vector2.DOWN
  if Input.is_action_pressed("left"):
      movement.x -= 1
      direction = Vector2.LEFT
  if Input.is_action_pressed("right"):
      movement.x += 1;
      direction = Vector2.RIGHT
  velocity = movement

func animate():
  var sprite: AnimatedSprite2D = get_node("Sprite")
  if velocity == Vector2.ZERO:
    if direction == Vector2.UP:
      sprite.play("idle_up")
    if direction == Vector2.DOWN:
      sprite.play("idle_down")
    if direction == Vector2.LEFT:
      sprite.play("idle_left")
    if direction == Vector2.RIGHT:
      sprite.play("idle_right")
    return

  if direction == Vector2.UP:
      sprite.play("walking_up")
  if direction == Vector2.DOWN:
      sprite.play("walking_down")
  if direction == Vector2.LEFT:
    sprite.play("walking_left")
  if direction == Vector2.RIGHT:
      sprite.play("walking_right")



func _physics_process(delta):
  input_to_direction()
  velocity = velocity.normalized() * 100
  velocity += velocity * delta
  animate()
  move_and_slide()


func _on_area_2d_area_entered(area: Area2D) -> void:
  print_debug(area)
