extends CharacterBody2D

const TOP_SPEED = 500
const SPEED_MULTIPLIER = 10
const DRAG = 5

@export var camera: Camera2D

func _ready():
  if not is_multiplayer_authority():
    return
  ## This scope determines that we actually own the ship.
  camera.make_current()

func _physics_process(delta):
  if is_multiplayer_authority():
    if Input.is_action_pressed("forward"):
      velocity += Vector2.RIGHT.rotated(rotation) * SPEED_MULTIPLIER
    if Input.is_action_pressed("backward"):
      velocity += Vector2.RIGHT.rotated(rotation + PI) * SPEED_MULTIPLIER
    if Input.is_action_pressed("right"):
      rotation += 0.05
    if Input.is_action_pressed("left"):
      rotation += -0.05
  velocity = velocity.move_toward(Vector2(0, 0), DRAG)
  velocity = velocity.clamp(Vector2(-TOP_SPEED, -TOP_SPEED), Vector2(TOP_SPEED, TOP_SPEED))
  move_and_slide()

func _enter_tree():
  set_multiplayer_authority(name.to_int())
