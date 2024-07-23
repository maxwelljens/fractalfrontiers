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
  0: "mining_cannon",
}
var cycles: Dictionary

func _ready() -> void:
  player.ui.fitting_button_pressed.connect(_receive_action)

func _physics_process(_delta) -> void:
  if cycles.is_empty(): return
  for x in cycles.keys():
    if cycles[x].time_left == 0:
      player.cycle_ended.emit(x)

func _receive_action(slot: int) -> void:
  var slot_fitting: String = fittings[slot]
  var function: StringName = items_data.ITEMS[slot_fitting]["function"]
  var function_callable := Callable(self, function)
  function_callable.call(slot)

func _cycle(slot: int, time: float) -> float:
  # Check if a cycle already exists, cancel it (if cancellable)
  if cycles.has(slot) and cycles[slot].time_left != 0.0:
    player.cycle_ended.emit(slot)
    var last_time_left: float = cycles[slot].time_left
    cycles[slot].time_left = 0.0
    return last_time_left
  # Otherwise create new cycle
  var new_cycle = get_tree().create_timer(time)
  cycles[slot] = new_cycle
  player.cycle_started.emit(slot, new_cycle)
  await new_cycle.timeout
  player.cycle_ended.emit(slot)
  return cycles[slot].time_left

func mine(slot: int) -> void:
  if Selector.instance.selection != null and Selector.instance.selection.has_node("Mineable"):
    var cycle_time = items_data.ITEMS[fittings[slot]]["cycle"]
    var time_left = await _cycle(slot, cycle_time)
  elif Selector.instance.selection != null and not Selector.instance.selection.has_node("Mineable"):
    print("Not mineable")
  elif Selector.instance.selection == null:
    print("Nothing selected")

## Add fitting to Rig
func _add_fitting(to_add: String) -> void:
  player.fitting_updated.emit()

## Add items to the cargohold of the rig
func _add_items(to_add: Dictionary) -> void:
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
