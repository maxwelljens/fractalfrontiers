extends Camera2D

@onready var player: Player = get_parent()

func _process(_delta: float) -> void:
  position = get_local_mouse_position()
  var one := Vector2.ONE * 300.0
  var clamped := position.clamp(-one, one)
  position = clamped
