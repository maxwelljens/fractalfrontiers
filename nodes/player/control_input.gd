class_name InputControl extends Node

@onready var player: CharacterBody2D = get_parent()
@onready var ship: Rig = player.find_child("Rig")

const EULER := 2.71828183

var acceleration_time := 0.0
var speed := 0.0

func _process(delta: float) -> void:
  if Input.is_action_pressed("forward"):
    acceleration_time += delta
  else:
    acceleration_time = max(0, acceleration_time - delta)
  if Input.is_action_pressed("backward"):
    acceleration_time -= delta
  if Input.is_action_pressed("right"):
    player.rotation += (ship.inertia_mod - speed / ship.max_speed) * delta
  if Input.is_action_pressed("left"):
    player.rotation += -(ship.inertia_mod - speed / ship.max_speed) * delta
  $"../UI/Bottom/HBoxContainer/Speed".text = "SPEED: %d m/s" % speed
  _move()

func _move() -> void:
  var t := acceleration_time
  var v_max := ship.max_speed
  var i := ship.inertia_mod
  var m := ship.mass
  speed = v_max * (1 - EULER ** ((-t * 10 ** 6) / (i * m)))
  var forward := Vector2.RIGHT.rotated(player.rotation) * speed
  player.velocity = forward
