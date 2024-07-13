class_name Selector extends Node2D

var selection: Node2D
static var instance: Selector 

func _ready() -> void:
  if is_multiplayer_authority():
    instance = self

func select(target: Node2D) -> void:
  selection = target
  print("Selected: %s" % selection)

func deselect() -> void:
  print("Deselected")
  selection = null
