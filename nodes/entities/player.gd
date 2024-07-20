class_name Player extends CharacterBody2D

@export var camera: Camera2D
@export var rig: Rig
@export var control: InputControl
@export var selector: Selector
var speed: float
var ore: int

signal cycle_started(slot: int, cycler: SceneTreeTimer)
signal cargo_updated
signal fitting_updated

func _ready():
  camera.make_current()

func _physics_process(_delta):
  if Input.is_action_pressed("ui_accept") and selector.selection:
    _draw_line()
  if Input.is_action_just_released("ui_accept") and selector.selection:
    rig.mine()
    $Line2D.clear_points()
    var mineable_node: Mineable = selector.selection.find_child("Mineable")
    rig.add_items(mineable_node.excavate(200))
  move_and_slide()

func _enter_tree():
  set_multiplayer_authority(name.to_int())

func _draw_line() -> void:
  if selector.selection == null: return
  var line := $Line2D as Line2D
  if line.get_point_count() < 2:
    line.add_point(Vector2.ZERO)
    line.add_point(to_local(selector.selection.global_position))
  line.set_point_position(1, to_local(selector.selection.global_position))
