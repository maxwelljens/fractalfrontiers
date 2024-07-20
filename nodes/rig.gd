class_name Rig extends Node
## The node that constitutes the player's ship.

const ITEMS: Dictionary = items_data.ITEMS

@export_category("Resources")
@export var player: Player
@export var items_data: ItemsDB = preload("res://nodes/globals/items.tres")

@export_category("Fittings")
@export var powergrid: float
@export var processor: float
@export var capacitor: float
@export_range(0, 8) var high_slots: int = 2
@export_range(0, 8) var mid_slots: int = 2
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
var fittings := {
  0: {
    "name": "mining_cannon",
    "function": "mine",
    "cycle": 60.0,
    "cpu": 60.0,
    "powergrid": 2.0,
  }
}

func mine() -> SceneTreeTimer:
  if Selector.instance.selection != null and Selector.instance.selection.has_node("Mineable"):
    return cycle(2.0)
  elif Selector.instance.selection != null and not Selector.instance.selection.has_node("Mineable"):
    print("Not mineable")
  elif Selector.instance.selection == null:
    print("Nothing selected")
  return null

func cycle(time: float) -> SceneTreeTimer:
  return get_tree().create_timer(time)

## Add fitting to Rig
func add_fitting(to_add: String) -> void:
  
  player.fitting_updated.emit()

## Add items to the cargohold of the rig
func add_items(to_add: Dictionary) -> void:
  for key in to_add.keys():
    if key in cargo:
      cargo[key]["icon"] = ITEMS[key]["icon"]
      cargo[key]["amount"] += to_add[key]
      # Calculate volume for convenience
      cargo[key]["volume"] = _calculate_volume(key, cargo[key]["amount"])
    else:
      # Make new entry
      cargo[key] = {"amount": to_add[key]}
      cargo[key]["icon"] = ITEMS[key]["icon"]
      cargo[key]["volume"] = _calculate_volume(key, cargo[key]["amount"])
  player.cargo_updated.emit()

func _calculate_volume(item_name: String, amount: int) -> int:
  # Calculate volume of item from ItemDB
  return amount * ITEMS[item_name]["volume"]
