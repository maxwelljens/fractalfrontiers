class_name Mineable extends Node

@export_enum("Ferroaster", "Alucianite", "Tenebrite") var type: String = "Ferroaster"
@export_range(0, 50000, 50) var quantity: int = 1000
@export var items_data: ItemsDB = preload("res://nodes/items.tres")
@onready var items: Dictionary = items_data.items
@onready var parent_node: Node2D = get_parent()
@onready var selectable_node: Selectable = parent_node.find_child("Selectable")

func _ready() -> void:
  print("Asteroid contains: %s" % items[type.to_lower()]["mineral"])

func excavate(amount: int) -> int:
  quantity -= amount
  if quantity <= 0:
    _destroy.rpc()
    return quantity + amount
  return amount

@rpc("call_local", "any_peer")
func _destroy():
  parent_node.queue_free()
