class_name Mineable extends Node

@export_category("Resources")
@export var parent_node: Node2D
@export var selectable_node: Selectable
@export var sprite_node: Sprite2D
@export var items_data: ItemsDB = preload("res://nodes/globals/items.tres")

@export_category("Mining Info")
@export_enum("Ferroaster", "Alucianite", "Tenebrite") var type: String = "Ferroaster"
@export_range(0, 50000, 50) var quantity: int = 1000

@onready var items: Dictionary = items_data.ITEMS

func excavate(amount: int) -> Dictionary:
  quantity -= amount
  if quantity <= 0:
    parent_node.queue_free()
    return {type.to_lower(): quantity + amount}
  return {type.to_lower(): amount}
