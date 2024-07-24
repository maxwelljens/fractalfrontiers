class_name MainMenuUI extends CanvasLayer

@onready var new_game_button: Button = %NewGameButton
@onready var options_button: Button = %OptionsButton
@onready var options_menu: PanelContainer = %OptionsMenu
@onready var exit_game_button: Button = %ExitGameButton

func _ready() -> void:
  _connect_signals()
  options_menu.visible = false

func _connect_signals() -> void:
  options_button.pressed.connect(_on_options_button_pressed)
  exit_game_button.pressed.connect(_on_exit_game_button_pressed)

func _on_options_button_pressed() -> void:
  options_menu.visible = true

func _on_exit_game_button_pressed() -> void:
  get_tree().quit()
