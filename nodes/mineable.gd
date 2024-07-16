class_name Mineable extends Node

@export_enum("Ferroaster", "Alucianite", "Tenebrite") var type: String = "Ferroaster"
@export_range(0, 50000, 50) var quantity: int = 1000
@export var items_data: ItemsDB = preload("res://nodes/globals/items.tres")
@onready var items: Dictionary = items_data.ITEMS
@onready var parent_node: Node2D = get_parent()
@onready var selectable_node: Selectable = parent_node.find_child("Selectable")

func excavate(amount: int) -> Dictionary:
  quantity -= amount
  if quantity <= 0:
    _destroy.rpc()
    return {type.to_lower(): quantity + amount}
  return {type.to_lower(): amount}

@rpc("call_local", "any_peer")
func _destroy():
  parent_node.queue_free()
