class_name Player extends CharacterBody2D

signal collided

@export var camera: Camera2D
@export var rig: Rig
@export var control: InputControl
@export var selector: Selector
var speed: float
var pressed: bool = false

func _ready():
  camera.make_current()

func _physics_process(delta):
  var collision = move_and_collide(velocity * delta)
  if collision != null:
    emit_signal("collided")
