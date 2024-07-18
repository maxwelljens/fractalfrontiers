class_name UI extends CanvasLayer

@export var player: Player
@onready var ui_speed: RichTextLabel = %Speed
@onready var ui_speedbar: ProgressBar = %SpeedBar
@onready var ui_target: Label = %Target

func _physics_process(_delta):
  if player.selector.selection is Node:
    ui_target.text = player.selector.selection.name
  else:
    ui_target.text = "" 
  ui_speed.text = "%d [color=orange]m/s[/color]" % player.control.speed
  ui_speedbar.max_value = player.rig.max_speed
  ui_speedbar.value = player.control.speed
  
  # Camera zoom (experiment)
  #var is_ui_in_focus: bool
  #for child in get_children():
    #if child is Control and child.has_focus():
      #is_ui_in_focus = true
  #if Input.is_action_just_released("wheel_forward") and not is_ui_in_focus:
    #player.camera.zoom += Vector2(0.1, 0.1)
  #if Input.is_action_just_released("wheel_backward"):
    #player.camera.zoom -= Vector2(0.1, 0.1)
  #player.camera.zoom = player.camera.zoom.clamp(Vector2(0.3, 0.3), Vector2(1.0, 1.0))
