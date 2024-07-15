class_name Rig extends Node

@export_category("Navigation")
@export var max_speed: int
@export var inertia_mod: float
@export var warp_speed: float

@export_category("Structure")
@export var hitpoints: int
@export var mass: int
@export var volume: int
@export var cargo_capacity: int

@export_category("Resources")
@export var items_data: ItemsDB = preload("res://nodes/items.tres")

var items: Dictionary = items_data.items
var cargo: Dictionary

func add_items(to_add: Dictionary) -> void:
  for key in to_add.keys():
    if key in cargo:
      cargo[key]["amount"] += to_add[key]
    else:
      cargo[key] = {"amount": to_add[key]}

func get_cargo(metadata := false) -> Dictionary:
  var cargo_get: Dictionary
  if metadata: pass
  for item in cargo:
    cargo_get[item] = cargo[item]["amount"]
  return cargo_get

func get_cargo_volume() -> Dictionary:
  var cargo_volume: int
  for item in cargo:
    cargo_volume += cargo[item]["amount"] * items[item]["volume"]
  return {
    "cargo_volume": cargo_volume,
    "cargo_capacity": cargo_capacity
  }
