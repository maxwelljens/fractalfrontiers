class_name CockpitView extends CanvasLayer

@export var stick: PathFollow3D
@export var end_stick: Node3D
@export var sensitivity = 0.005  # Подстройка чувствительности движения

var stick_moving: bool
var stick_move_position: Vector3

var dragging = false
var mouse_start_x = 0
var progress_start = 0

func _input(event):
  if event is InputEventMouseButton:
    if event.button_index == MOUSE_BUTTON_LEFT:
      if event.pressed:
        dragging = true
        mouse_start_x = event.position.x
        progress_start = stick.progress_ratio
      else:
        dragging = false
    
  if event is InputEventMouseMotion and dragging:
    var delta = event.position.x - mouse_start_x
    stick.progress_ratio = clamp(progress_start + delta * sensitivity, 0.0, 1.0)
