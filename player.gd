extends CharacterBody2D

const TOP_SPEED = 100

@export var camera: Camera2D
@export var input_control: InputControl

func _ready():
  if not is_multiplayer_authority():
    input_control.set_physics_process(false)
    return
  ## This scope determines that we actually own the ship.
  camera.make_current()

func _physics_process(_delta):
  if is_multiplayer_authority():
    if Input.is_action_just_released("ui_accept"):
      $MiningLaser/TextureRect.visible = false
  velocity = velocity.clamp(Vector2(-TOP_SPEED, -TOP_SPEED), Vector2(TOP_SPEED, TOP_SPEED))
  move_and_slide()

func _enter_tree():
  set_multiplayer_authority(name.to_int())
