extends CharacterBody2D

@export var camera: Camera2D
@export var input_control: InputControl

func _ready():
  if not is_multiplayer_authority():
    input_control.set_physics_process(false)
    return
  ## This scope determines that we actually own the ship.
  camera.make_current()

func _physics_process(_delta):
  $UI/Bottom/HBoxContainer/Targets.text = "TARGETS: %s" % Targets.targets
  move_and_slide()

func _enter_tree():
  set_multiplayer_authority(name.to_int())
