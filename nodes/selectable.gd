class_name Selectable extends Node

@export var parent_node: Node2D

func _ready() -> void:
  parent_node.input_event.connect(_on_parent_input_event)
  parent_node.mouse_entered.connect(_on_parent_mouse_entered)
  parent_node.mouse_exited.connect(_on_parent_mouse_exited)

func _exit_tree() -> void:
  # If the Selectable scene is freed then make sure to deselect it
  if Selector.instance != null:
    Selector.instance.deselect()

func _on_parent_input_event(_viewport, _event, _shape_idx) -> void:
  var selector := Selector.instance
  if Input.is_action_just_pressed("left_click") and parent_node != selector.selection:
    selector.select(parent_node)
  elif Input.is_action_just_pressed("left_click") and parent_node == selector.selection:
    selector.deselect()

func _on_parent_mouse_entered() -> void:
  $Sprite2D.visible = true
  $Sprite2D.position = parent_node.position

func _on_parent_mouse_exited() -> void:
  $Sprite2D.visible = false 
