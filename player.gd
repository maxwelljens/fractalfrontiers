extends CharacterBody2D

@export var camera: Camera2D
@export var input_control: InputControl

@onready var targets = %Targets
@onready var ui = $UI

func _ready():
  if not is_multiplayer_authority():
    input_control.set_process(false)
    ui.queue_free()
    return
  ## This scope determines that we actually own the ship.
  camera.make_current()

func _physics_process(_delta):
  if Input.is_action_pressed("ui_accept") and targets != null:
    $Line2D.add_point(global_position)
    $Line2D.add_point(TargetHolder.instance.targets[0].global_position)
  if Input.is_action_just_released("ui_accept"):
    $Line2D.clear_points()
  if targets != null:
    targets.text = "TARGETS: %s" % [TargetHolder.instance.targets]
  move_and_slide()

func _enter_tree():
  set_multiplayer_authority(name.to_int())
