class_name Mineable extends Node

@export_enum("Ferroaster", "Alucianite", "Tenebrite") var type: String = "Ferroaster"
@export_range(0, 50000, 50) var quantity: int = 1000
@onready var parent_node: Node2D = get_parent()
@onready var selectable_node: Selectable = parent_node.find_child("Selectable")

func excavate(amount: int) -> int:
  quantity -= amount
  if quantity <= 0:
    parent_node.queue_free()
    return quantity + amount
  return amount
