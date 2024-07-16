class_name InputControl extends Node

const EULER := 2.71828183
@onready var player: Player = get_parent()
@onready var ship: Rig = player.find_child("Rig")
var acceleration_time := 0.0
var speed := 0.0

func _process(delta: float) -> void:
  if not is_multiplayer_authority(): return
  if Input.is_action_pressed("forward"):
    acceleration_time += delta
  else:
    acceleration_time = max(0, acceleration_time - delta)
  if Input.is_action_pressed("backward"):
    acceleration_time -= delta
  if Input.is_action_pressed("right"):
    player.rotation += (ship.inertia_mod * 1.5 - speed / ship.max_speed) * delta
  if Input.is_action_pressed("left"):
    player.rotation += -(ship.inertia_mod * 1.5 - speed / ship.max_speed) * delta
  player.speed = speed
  _move()

func _move() -> void:
  var t := acceleration_time
  var v_max := ship.max_speed
  var i := ship.inertia_mod
  var m := ship.mass
  speed = v_max * (1 - EULER ** ((-t * 10 ** 6) / (i * m)))
  var forward := Vector2.RIGHT.rotated(player.rotation) * speed
  player.velocity = forward
