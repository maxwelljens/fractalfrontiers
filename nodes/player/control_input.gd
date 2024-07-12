class_name InputControl extends Node

@onready var player: CharacterBody2D = get_parent()
@onready var ship: Node = player.find_child("Rig")

func _process(delta: float) -> void:
    if Input.is_action_pressed("forward"):
      var speed: float = ship.max_speed * (1 - 2.71828 * (-delta * pow(10, 6) / ship.inertia_mod * ship.mass))
      var forward := Vector2.RIGHT.rotated(player.rotation) * speed
      forward = forward/pow(10, 12)
      player.velocity = forward
      print(player.velocity)
    if Input.is_action_pressed("backward"):
      pass
    if Input.is_action_pressed("right"):
      player.rotation += 0.5 * delta
    if Input.is_action_pressed("left"):
      player.rotation += -0.5 * delta
