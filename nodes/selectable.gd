extends Node

var parent_node: Node

func _ready():
  parent_node = get_parent()
  parent_node.input_event.connect(_on_parent_input_event)

func _on_parent_input_event(viewport, event, shape_idx):
  if event is InputEventMouseMotion:
    if Input.is_action_just_pressed("left_click"):
      if parent_node:
        print("CLICK")
