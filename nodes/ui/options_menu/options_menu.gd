class_name OptionsMenuUI extends PanelContainer

@onready var go_back_button: Button = %GoBackButton

func _ready() -> void:
  go_back_button.pressed.connect(_on_go_back_button_pressed)
  
func _process(_delta):
  if Input.is_action_just_pressed("ui_cancel"):
    visible = false

func _on_go_back_button_pressed() -> void:
  visible = false
