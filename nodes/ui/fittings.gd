class_name UIFittings extends PanelContainer

@export_category("Resources")
@export var ui: UI 
@export var globals: Globals = preload("res://nodes/globals/globals.tres")
@export var items_db: ItemsDB = preload("res://nodes/globals/items.tres")

@onready var player: Player = ui.player
@onready var rig: Rig = player.rig
@onready var fb_template: FittingContainer = %FittingContainer
@onready var hs: HBoxContainer = %HighSlots
@onready var ms: HBoxContainer = %MidSlots
@onready var ls: HBoxContainer = %LowSlots

var slots: Array[CenterContainer]

func _ready() -> void:
  player.cycle_started.connect(_process_cycle)
  _populate_slot_arrays()
  _update_slots()

func _update_slots() -> void:
  # Make slots visible according to slots in Rig
  for x in range(rig.high_slots):
    slots[x].visible = true
  for x in range(rig.mid_slots):
    slots[x + 8].visible = true
  for x in range(rig.low_slots):
    slots[x + 16].visible = true
    
  # Reflect current fittings on Rig
  for fitting in rig.fittings.keys():
    var button: Button = slots[fitting].get_node("Button")
    var fitting_name = rig.fittings[fitting]
    var icon = items_db.ITEMS[fitting_name]["icon"]
    button.disabled = false
    button.icon = load(icon)

func _populate_slot_arrays() -> void:
  var count := 0
  for s in [hs, ms, ls]:
    while s.get_child_count() < 8:
      var template: FittingContainer = fb_template.duplicate()
      template.index = count
      count += 1
      s.add_child(template)
      slots.append(template)

func _process_cycle(slot: int, cycle: SceneTreeTimer) -> void:
  var cycle_bar: TextureProgressBar = slots[slot].cycle_bar
  cycle_bar.max_value = cycle.time_left
  while cycle.time_left > 0:
    cycle_bar.value = cycle_bar.max_value - cycle.time_left
    await get_tree().physics_frame
  cycle_bar.value = 0
