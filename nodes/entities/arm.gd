extends RayCast2D


@export var player: Player
@export var arm_speed: float = 300
@export var arm_visuals: Node2D


@onready var max_extension := target_position.x
@onready var base: float = position.x
@onready var extension: float = base
@onready var visuals_base: float = arm_visuals.position.x


var direction: float = 0


func set_direction(v: float) -> void:
    direction = v


func _physics_process(delta: float) -> void:
  extension += direction * delta * arm_speed
  if is_colliding():
    extension = to_local(get_collision_point()).x
  extension = clamp(extension, base, max_extension)
  arm_visuals.position.x = (extension - base) - visuals_base
  target_position.x = extension
