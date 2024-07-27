extends Camera2D

@export var player: Player
@export var deadzone: float

func _process(_delta: float) -> void:
  position = get_local_mouse_position()
  var one := Vector2.ONE * deadzone
  var clamped := position.clamp(-one, one)
  position = clamped
