class_name InputControl extends Node


var rotation: float


@export var rotation_speed: float = PI
@export var speed: float
@export var velocity_component: Velocity


func _process(delta: float) -> void:
    var current_velocity := velocity_component.velocity
    if Input.is_action_pressed("forward"):
      var forward := Vector2.RIGHT.rotated(rotation) * speed
      var v := current_velocity.move_toward(forward, speed)
      velocity_component.velocity = v
    if Input.is_action_pressed("backward"):
      velocity_component.velocity += Vector2.RIGHT.rotated(rotation + PI) * (speed / 6)
    if Input.is_action_pressed("right"):
      rotation += rotation_speed * delta
    if Input.is_action_pressed("left"):
      rotation += -rotation_speed * delta
