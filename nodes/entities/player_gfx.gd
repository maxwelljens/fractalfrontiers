class_name PlayerGFX extends Node2D

@export var input_control: InputControl

@onready var rear_thruster: GPUParticles2D = $RearThruster
@onready var front_thruster_r: GPUParticles2D = $FrontThrusterR
@onready var front_thruster_l: GPUParticles2D = $FrontThrusterL
@onready var left_thruster_f: GPUParticles2D = $LeftThrusterF
@onready var left_thruster_r: GPUParticles2D = $LeftThrusterR
@onready var right_thruster_f: GPUParticles2D = $RightThrusterF
@onready var right_thruster_r: GPUParticles2D = $RightThrusterR

func _ready() -> void:
  input_control.thrust_forward_started.connect(_on_input_control_thrust_forward_started)
  input_control.thrust_forward_ended.connect(_on_input_control_thrust_forward_ended)
  input_control.thrust_backward_started.connect(_on_input_control_thrust_backward_started)
  input_control.thrust_backward_ended.connect(_on_input_control_thrust_backward_ended)
  input_control.rotate_right_started.connect(_on_input_control_rotate_right_started)
  input_control.rotate_right_ended.connect(_on_input_control_rotate_right_ended)
  input_control.rotate_left_started.connect(_on_input_control_rotate_left_started)
  input_control.rotate_left_ended.connect(_on_input_control_rotate_left_ended)

func _on_input_control_thrust_backward_started() -> void:
  front_thruster_l.emitting = true
  front_thruster_r.emitting = true

func _on_input_control_thrust_backward_ended() -> void:
  front_thruster_l.emitting = false
  front_thruster_r.emitting = false

func _on_input_control_thrust_forward_started() -> void:
  rear_thruster.emitting = true

func _on_input_control_thrust_forward_ended() -> void:
  rear_thruster.emitting = false 

func _on_input_control_rotate_right_started() -> void:
  left_thruster_f.emitting = true
  right_thruster_r.emitting = true

func _on_input_control_rotate_right_ended() -> void:
  left_thruster_f.emitting = false
  right_thruster_r.emitting = false

func _on_input_control_rotate_left_started() -> void:
  left_thruster_r.emitting = true
  right_thruster_f.emitting = true

func _on_input_control_rotate_left_ended() -> void:
  left_thruster_r.emitting = false
  right_thruster_f.emitting = false
