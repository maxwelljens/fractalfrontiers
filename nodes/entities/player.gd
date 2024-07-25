class_name Player extends CharacterBody2D

@export var camera: Camera2D
@export var rig: Rig
@export var control: InputControl
@export var selector: Selector
var speed: float

func _ready():
  camera.make_current()

func _physics_process(_delta):
  move_and_slide()
