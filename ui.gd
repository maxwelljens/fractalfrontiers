class_name UI extends CanvasLayer

@onready var ui_speed: Label = %Speed
@onready var ui_targets: Label = %Targets
@onready var ui_cargo: Label = %Cargo
static var instance: UI

var selection: Selector:
  get: return Selector.instance.selection
var player: Player:
  get: return Player.instance
var rig: Rig:
  get: return player.rig

func _ready() -> void:
  instance = self

func _physics_process(_delta):
  if player == null: return
  var cargo_info: Dictionary = rig.get_cargo_volume()
  ui_cargo.text = "%s/%s m3"  % [cargo_info["cargo_volume"], cargo_info["cargo_capacity"]]
  if selection is Node:
    ui_targets.text = "SELECTED: %s" % selection
  else:
    ui_targets.text = "-***-" 
  ui_speed.text = "SPEED: %d m/s" % player.control.speed
