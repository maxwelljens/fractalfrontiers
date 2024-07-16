class_name Player extends CharacterBody2D

@export var camera: Camera2D
@export var input_control: InputControl
@onready var rig = $Rig
@onready var cargo_capacity: int = $Rig.cargo_capacity
@onready var control = $Control
static var instance: Player
var speed: float
var ore: int

var selection: Selector:
  get: return Selector.instance.selection
var ui: UI:
  get: return UI.instance

func _ready():
  if not is_multiplayer_authority():
    input_control.set_process(false)
    return
  ## This scope determines that we actually own the ship.
  instance = self
  camera.make_current()

func _physics_process(_delta):
  if not is_multiplayer_authority(): return
  if Input.is_action_pressed("ui_accept") and selection:
    _draw_line()
  if Input.is_action_just_released("ui_accept") and selection:
    $Line2D.clear_points()
    var mineable_node: Mineable = selection.find_child("Mineable")
    rig.add_items(mineable_node.excavate(200))
  move_and_slide()

func _enter_tree():
  set_multiplayer_authority(name.to_int())

func _draw_line() -> void:
  if selection == null: return
  var line := $Line2D as Line2D
  if line.get_point_count() < 2:
    line.add_point(Vector2.ZERO)
    line.add_point(to_local(selection.global_position))
  line.set_point_position(1, to_local(selection.global_position))
