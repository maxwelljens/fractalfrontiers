class_name Drag extends Node


@export var drag_scale: float
@export var velocity: Velocity


func _physics_process(delta: float) -> void:
    var vel := velocity.velocity.move_toward(Vector2.ZERO, drag_scale * delta)
    velocity.velocity = vel
