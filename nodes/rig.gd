class_name Rig extends Node
## The node that constitutes the player's ship.

const items: Dictionary = items_data.ITEMS

@export_category("Resources")
@export var player: Player
@export var items_data: ItemsDB = preload("res://nodes/globals/items.tres")

@export_category("Fittings")
@export var powergrid: float
@export var processor: float
@export var capacitor: float
@export_range(0, 8) var high_slots: int = 2
@export_range(0, 8) var medium_slots: int = 2
@export_range(0, 8) var low_slots: int = 2

@export_category("Navigation")
@export var max_speed: int
@export var inertia_mod: float
@export var warp_speed: float

@export_category("Structure")
@export var hitpoints: int
@export var mass: int
@export var volume: int
@export var cargo_capacity: int

var cargo: Dictionary

## Add items to the cargohold of the rig
func add_items(to_add: Dictionary) -> void:
  for key in to_add.keys():
    if key in cargo:
      cargo[key]["icon"] = items[key]["icon"]
      cargo[key]["amount"] += to_add[key]
      # Calculate volume for convenience
      cargo[key]["volume"] = _calculate_volume(key, cargo[key]["amount"])
    else:
      # Make new entry
      cargo[key] = {"amount": to_add[key]}
      cargo[key]["icon"] = items[key]["icon"]
      cargo[key]["volume"] = _calculate_volume(key, cargo[key]["amount"])
  player.cargo_updated.emit()

func _calculate_volume(item_name: String, amount: int) -> int:
  # Calculate volume of item from ItemDB
  return amount * items[item_name]["volume"]
