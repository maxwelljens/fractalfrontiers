class_name CockpitView extends CanvasLayer


@export var stick: PathFollow3D
@export var end_stick: Node3D
@export var sensitivity = 0.01


@onready var lever_area: Area3D = %LeverArea


var stick_moving: bool
var stick_move_position: Vector3


var dragging = false
var mouse_start_x = 0
var progress_start = 0


signal lever_changed(v: float)


func _ready() -> void:
    lever_area.input_event.connect(_lever_input)


func _input(event: InputEvent) -> void:
  if event is InputEventMouseButton:
    if event.button_index == MOUSE_BUTTON_LEFT and event.is_released():
      dragging = false
  if event is InputEventMouseMotion and dragging:
    var delta = -event.position.y - mouse_start_x
    stick.progress_ratio = clamp(progress_start + delta * sensitivity, 0.0, 1.0)
    lever_changed.emit(2 * stick.progress_ratio - 1)
    

func _lever_input(
    camera: Node, 
    event: InputEvent, 
    event_position: Vector3, 
    normal: Vector3, 
    shape_idx: int) -> void:
  if event is InputEventMouseButton:
    if event.button_index == MOUSE_BUTTON_LEFT:
      if event.pressed:
        dragging = true
        mouse_start_x = -event.position.y
        progress_start = stick.progress_ratio
        lever_changed.emit()
