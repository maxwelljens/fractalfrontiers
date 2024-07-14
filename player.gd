extends CharacterBody2D

@export var camera: Camera2D
@export var input_control: InputControl
var ore: int = 0

var selection: Node2D:
  get: return Selector.instance.selection
var ui: UI:
  get: return UI.instance

func _ready():
  if not is_multiplayer_authority():
    input_control.set_process(false)
    ui.queue_free()
    return
  ## This scope determines that we actually own the ship.
  camera.make_current()

func _physics_process(_delta):
  if not is_multiplayer_authority(): return
  if Input.is_action_pressed("ui_accept") and selection:
    _draw_line()
  if Input.is_action_just_released("ui_accept") and selection:
    $Line2D.clear_points()
    ore += Selector.instance.selection.find_child("Mineable").excavate(200)
    ui.ui_cargo.text = "%d/2700 m3" % ore
  if selection:
    ui.ui_targets.text = "SELECTED: %s" % selection
  else:
    ui.ui_targets.text = "-***-"
  move_and_slide()

func update_speed(speed: float) -> void:
  ui.ui_speed.text = "SPEED: %d m/s" % speed

func _enter_tree():
  set_multiplayer_authority(name.to_int())

func _draw_line() -> void:
  if Selector.instance.selection == null:
    return
  var line := $Line2D as Line2D
  if line.get_point_count() < 2:
    line.add_point(Vector2.ZERO)
    line.add_point(to_local(Selector.instance.selection.global_position))
  line.set_point_position(1, to_local(Selector.instance.selection.global_position))
