class_name UIFittings extends PanelContainer

@export_category("Resources")
@export var ui: UI 
@export var globals: Globals = preload("res://nodes/globals/globals.tres")
@export var items_db: ItemsDB = preload("res://nodes/globals/items.tres")

@onready var player: Player = ui.player
@onready var hs: HBoxContainer = %HighSlots
@onready var ms: HBoxContainer = %MidSlots
@onready var ls: HBoxContainer = %LowSlots

var hs_slots: Array[CenterContainer]
var ms_slots: Array[CenterContainer]
var ls_slots: Array[CenterContainer]

func _ready() -> void:
  _populate_slot_arrays()
  _update_slots()

func _update_slots() -> void:
  var rig: Rig = player.rig
  # Make slots visible according to slots in Rig
  for x in range(rig.high_slots):
    hs_slots[x].visible = true
  for x in range(rig.mid_slots):
    ms_slots[x].visible = true
  for x in range(rig.low_slots):
    ls_slots[x].visible = true
    
  # Reflect current fittings on Rig
  for fitting in rig.fittings.keys():
    var button: Button
    if fitting in globals.HS_INDEX:
      button = hs_slots[fitting].get_node("Button")
    elif fitting in globals.MS_INDEX:
      button = ms_slots[fitting - 8].get_node("Button")
    elif fitting in globals.LS_INDEX:
      button = ls_slots[fitting - 16].get_node("Button")
    else:
      push_error("Invalid index %s on provided fitting" % fitting)
    var fitting_name = rig.fittings[fitting]["name"]
    var icon = items_db.ITEMS[fitting_name]["icon"]
    button.disabled = false
    button.icon = load(icon)

func _populate_slot_arrays() -> void:
  var template: CenterContainer
  for s in [hs, ms, ls]:
    while s.get_child_count() < 8:
      template = s.get_child(0).duplicate()
      match s:
        hs:
          hs.add_child(template)
          hs_slots.append(template)
        ms: 
          ms.add_child(template)
          ms_slots.append(template)
        ls:
          ls.add_child(template)
          ls_slots.append(template)

# TODO: Do the cycling logic for each button
func button_pressed(button: Button) -> void:
  var cycler: SceneTreeTimer 
  var cycle_max_time: float
  button.get_node("../CycleBar").value = cycle_max_time - cycler.time_left
  player.rig.mine()
