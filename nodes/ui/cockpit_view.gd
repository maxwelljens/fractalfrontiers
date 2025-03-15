class_name CockpitView extends CanvasLayer

func _physics_process(delta):
  pass

func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
  if event:
    print("Anything")
