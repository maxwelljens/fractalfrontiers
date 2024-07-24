class_name Rig extends Node

const ITEMS: Dictionary = items_data.ITEMS

@export_category("Resources")
@export var player: Player
@export var items_data: ItemsDB = preload("res://nodes/globals/items.tres")

func _ready() -> void:
  pass

func _physics_process(_delta) -> void:
  pass
