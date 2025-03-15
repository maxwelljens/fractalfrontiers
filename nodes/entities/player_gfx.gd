class_name PlayerGFX extends Node2D

@export var input_control: InputControl

@onready var rear_thruster: GPUParticles2D = $Emitters/RearThruster
@onready var front_thruster_r: GPUParticles2D = $Emitters/FrontThrusterR
@onready var front_thruster_l: GPUParticles2D = $Emitters/FrontThrusterL
@onready var left_thruster_f: GPUParticles2D = $Emitters/LeftThrusterF
@onready var left_thruster_r: GPUParticles2D = $Emitters/LeftThrusterR
@onready var right_thruster_f: GPUParticles2D = $Emitters/RightThrusterF
@onready var right_thruster_r: GPUParticles2D = $Emitters/RightThrusterR
@onready var warning_light: PointLight2D = $Lights/EngineLight

func _ready() -> void:
  input_control.thrust_forward_started.connect(_on_input_control_thrust_forward_started)
  input_control.thrust_forward_ended.connect(_on_input_control_thrust_forward_ended)
  input_control.thrust_backward_started.connect(_on_input_control_thrust_backward_started)
  input_control.thrust_backward_ended.connect(_on_input_control_thrust_backward_ended)
  input_control.strafe_right_started.connect(_on_input_control_strafe_right_started)
  input_control.strafe_right_ended.connect(_on_input_control_strafe_right_ended)
  input_control.rotate_right_started.connect(_on_input_control_rotate_right_started)
  input_control.rotate_right_ended.connect(_on_input_control_rotate_right_ended)
  input_control.strafe_left_started.connect(_on_input_control_strafe_left_started)
  input_control.strafe_left_ended.connect(_on_input_control_strafe_left_ended)
  input_control.rotate_left_started.connect(_on_input_control_rotate_left_started)
  input_control.rotate_left_ended.connect(_on_input_control_rotate_left_ended)
  _blink_engine_light()

func _blink_engine_light() -> void:
  const INTENSITY := 3.0
  while true:
    warning_light.energy = INTENSITY
    await get_tree().create_timer(2.0).timeout
    warning_light.energy = 0.0
    await get_tree().create_timer(0.1).timeout
    warning_light.energy = INTENSITY

# Thrust

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

# Right

func _on_input_control_strafe_right_started() -> void:
  left_thruster_f.emitting = true
  left_thruster_r.emitting = true

func _on_input_control_strafe_right_ended() -> void:
  left_thruster_f.emitting = false
  left_thruster_r.emitting = false

func _on_input_control_rotate_right_started() -> void:
  left_thruster_f.emitting = true
  right_thruster_r.emitting = true

func _on_input_control_rotate_right_ended() -> void:
  left_thruster_f.emitting = false
  right_thruster_r.emitting = false

# Left

func _on_input_control_strafe_left_started() -> void:
  right_thruster_f.emitting = true
  right_thruster_r.emitting = true

func _on_input_control_strafe_left_ended() -> void:
  right_thruster_f.emitting = false
  right_thruster_r.emitting = false

func _on_input_control_rotate_left_started() -> void:
  left_thruster_r.emitting = true
  right_thruster_f.emitting = true

func _on_input_control_rotate_left_ended() -> void:
  left_thruster_r.emitting = false
  right_thruster_f.emitting = false
