class_name UI extends CanvasLayer

@onready var ui_speed: Label = %Speed
@onready var ui_targets: Label = %Targets
@onready var ui_cargo: Label = %Cargo
static var instance: UI

var selection: Selector:
  get: return Selector.instance.selection
var player: Player:
  get: return Player.instance

func _ready() -> void:
  instance = self

func _physics_process(_delta):
  if player == null: return
  ui_cargo.text = "%s/2700 m3" % player.ore
  if selection == null:
    ui_targets.text = "-***-"
  if selection:
    ui_targets.text = "SELECTED: %s" % selection
  else:
    ui_targets.text = "-***-" 
  ui_speed.text = "SPEED: %d m/s" % player.speed
