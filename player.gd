extends CharacterBody2D


const TOP_SPEED = 500


@export var camera: Camera2D
@export var input_control: InputControl
@export var velocity_component: Velocity


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
  velocity = velocity_component.velocity
  velocity = velocity.clamp(Vector2(-TOP_SPEED, -TOP_SPEED), Vector2(TOP_SPEED, TOP_SPEED))
  rotation = input_control.rotation
  move_and_slide()

func _enter_tree():
  set_multiplayer_authority(name.to_int())
