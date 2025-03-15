extends CharacterBody2D

const MAX_EXTENSION := 65

@export var player: Player

var collision: KinematicCollision2D
var base: Vector2
var extension: Vector2

func _ready() -> void:
  base = get_position()
  extension = base

func _physics_process(delta) -> void:
  if Input.is_action_pressed("ui_down"):
    if extension.x > base.x:
      extension.x -= 1
  if Input.is_action_pressed("ui_up"):
    if extension.x >= base.x and extension.x < base.x + MAX_EXTENSION:
      extension.x += 1

  position = extension
  collision = move_and_collide(velocity * delta)
  if collision != null:
    player.emit_signal("collided")
    extension.x -= 2
