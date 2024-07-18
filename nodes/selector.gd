class_name Selector extends Node2D
## Node that holds all selections.
##
## Selector is intended to be used as a singleton, which makes it easier to access its contents from anywhere in the
## scene.

var selection: Node2D
static var instance: Selector 

func _ready() -> void:
  instance = self

func select(target: Node2D) -> void:
  selection = target

func deselect() -> void:
  selection = null
