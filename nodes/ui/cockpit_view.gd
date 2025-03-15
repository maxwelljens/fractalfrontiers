class_name CockpitView extends CanvasLayer

@export var stick: PathFollow3D
var stick_position: float
var stick_moving: bool

func _physics_process(delta: float):
  if stick_moving:
    stick.progress_ratio = stick_position
    stick.progress_ratio = move_toward(stick.progress_ratio, 1.0, delta)
    stick_position = stick.progress_ratio
    stick.progress_ratio = ease(stick.progress_ratio, 6)
  if stick.progress_ratio >= 1.0 and stick_moving:
    print("Done")
    stick_moving = false

func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
  var mouse_click = event as InputEventMouseButton
  if mouse_click and mouse_click.pressed:
    print("Moving")
    stick_moving = true
