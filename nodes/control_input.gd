class_name InputControl extends Node
## Node controlling player ship.

signal thrust_forward_started
signal thrust_forward_ended
signal thrust_backward_started
signal thrust_backward_ended
signal rotate_right_started
signal rotate_right_ended
signal rotate_left_started
signal rotate_left_ended

const NORM_FACTOR := 100_000

@export_category("Resources")
@export var player: Player

@export_category("Settings")
@export var thrust_strength: float = 0.5
@export var drag: float = 0.08
@export var rotation_strength: float = 50
@export var rotation_drag: float = 0.12

var inertia := Vector2(0.0, 0.0)
var rotation_inertia := 0.0

func _ready() -> void:
  player.collided.connect(_on_player_collided)

func _on_player_collided() -> void:
  inertia = Vector2.ZERO
  rotation_inertia = 0.0

func _process(delta: float) -> void:
  
  # Thrust forward
  if Input.is_action_pressed("forward"):
    _thrust_forward()
  if Input.is_action_just_pressed("forward"):
    emit_signal("thrust_forward_started")
  if Input.is_action_just_released("forward"):
    emit_signal("thrust_forward_ended")
    
  # Thrust backward
  if Input.is_action_pressed("backward"):
    _thrust_backward()
  if Input.is_action_just_pressed("backward"):
    emit_signal("thrust_backward_started")
  if Input.is_action_just_released("backward"):
    emit_signal("thrust_backward_ended")
    
  # Rotate right
  if Input.is_action_pressed("right"):
    _rotate_right(delta)
  if Input.is_action_just_pressed("right"):
    emit_signal("rotate_right_started")
  if Input.is_action_just_released("right"):
    emit_signal("rotate_right_ended")
    
  # Rotate left
  if Input.is_action_pressed("left"):
    _rotate_left(delta)
  if Input.is_action_just_pressed("left"):
    emit_signal("rotate_left_started")
  if Input.is_action_just_released("left"):
    emit_signal("rotate_left_ended")
  
  # Apply dampening
  inertia = inertia.move_toward(Vector2.ZERO, drag)
  rotation_inertia = move_toward(rotation_inertia, 0.0, (rotation_drag / NORM_FACTOR))
  player.velocity = inertia
  player.rotation += move_toward(rotation_inertia, 0.0, (rotation_drag / NORM_FACTOR))

func _thrust_forward() -> void:
  inertia += Vector2.RIGHT.rotated(player.rotation) * thrust_strength

func _thrust_backward() -> void:
  inertia += Vector2.RIGHT.rotated(player.rotation + PI) * thrust_strength

func _rotate_right(delta: float) -> void:
  rotation_inertia += (rotation_strength / NORM_FACTOR) * delta

func _rotate_left(delta: float) -> void:
  rotation_inertia += -(rotation_strength / NORM_FACTOR) * delta
