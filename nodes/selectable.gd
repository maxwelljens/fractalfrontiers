extends Node

var parent_node: Node2D

func _ready():
  parent_node = get_parent()
  parent_node.input_event.connect(_on_parent_input_event)
  parent_node.mouse_entered.connect(_on_parent_mouse_entered)
  parent_node.mouse_exited.connect(_on_parent_mouse_exited)

func _on_parent_input_event(_viewport, _event, _shape_idx):
  var targets: TargetHolder = TargetHolder.instance
  if Input.is_action_just_pressed("left_click") and parent_node not in targets.targets:
    targets.append_target(parent_node)
  elif Input.is_action_just_pressed("left_click") and parent_node in targets.targets:
    targets.remove_target(parent_node)

func _on_parent_mouse_entered():
  $Sprite2D.visible = true
  $Sprite2D.position = parent_node.position

func _on_parent_mouse_exited():
  $Sprite2D.visible = false 
