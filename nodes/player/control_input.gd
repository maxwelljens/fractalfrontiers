class_name InputControl extends Node

@onready var player: CharacterBody2D = get_parent()
@onready var ship := player.find_child("Rig") as Rig

const EULER := 2.718281828459045235360287471352

var acceleration_time := 0.0

func _process(delta: float) -> void:
    if Input.is_action_pressed("forward"):
      acceleration_time += delta
    else: acceleration_time = max(0, acceleration_time - delta)
    if Input.is_action_pressed("backward"):
      pass
    if Input.is_action_pressed("right"):
      player.rotation += 0.5 * delta
    if Input.is_action_pressed("left"):
      player.rotation += -0.5 * delta
    _forward()

func _forward() -> void:
  var t := acceleration_time
  var v_max := ship.max_speed
  var i := ship.inertia_mod
  var m := ship.mass
  var speed := v_max * (1 - EULER ** ((-t * 10 ** 6) / (i * m)))
  var forward := Vector2.RIGHT.rotated(player.rotation) * speed
  player.velocity = forward
  print(speed)
