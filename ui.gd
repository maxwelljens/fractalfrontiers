class_name UI extends CanvasLayer

@onready var ui_speed: Label = %Speed
@onready var ui_targets: Label = %Targets
@onready var ui_cargo: Label = %Cargo
static var instance: UI

func _ready() -> void:
  if is_multiplayer_authority(): 
    instance = self
