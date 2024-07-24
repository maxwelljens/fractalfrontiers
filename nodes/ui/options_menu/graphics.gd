class_name GraphicsUI extends ScrollContainer

const SCREEN_MODES: Array[StringName] = [
  "Fullscreen",
  "Windowed",
  "Borderless Windowed",
  "Borderless Fullscreen",
]

const RESOLUTIONS: Array[Vector2i] = [
  Vector2i(800, 600),
  Vector2i(1024, 600),
  Vector2i(1152, 648),
  Vector2i(1280, 720),
  Vector2i(1440, 900),
  Vector2i(1366, 768),
  Vector2i(1920, 1080),
  Vector2i(2560, 1440),
  Vector2i(3840, 2160),
]

@onready var screen_mode_ob: OptionButton = %ScreenModeOB
@onready var resolution_ob: OptionButton = %ResolutionOB
@onready var scale_slider: HSlider = %ScaleSlider
@onready var scale_percentage: Label = %ScalePercentage
@onready var scale_apply_button: Button = %ScaleApplyButton

func _ready() -> void:
  screen_mode_ob.item_selected.connect(_on_screen_mode_selected)
  resolution_ob.item_selected.connect(_update_resolution_options)
  scale_slider.value_changed.connect(_on_scale_slider_value_changed)
  scale_apply_button.pressed.connect(_on_scale_apply_button_pressed)
  _populate_screen_mode_options()
  _update_screen_mode_selection()
  _populate_resolution_options()
  _update_resolution_options()

func _process(_delta) -> void:
  pass

func _on_screen_mode_selected(index: int) -> void:
  match index:
    0: # Fullscreen
      DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
      DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
      resolution_ob.disabled = true
    1: # Windowed
      DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
      DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
      resolution_ob.disabled = false
    2: # Borderless Windowed
      DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
      DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
      resolution_ob.disabled = false
    3: # Borderless Fullscreen 
      DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
      DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
      resolution_ob.disabled = true

func _populate_screen_mode_options() -> void:
  for x in SCREEN_MODES:
    screen_mode_ob.add_item(x)

func _update_screen_mode_selection() -> void:
  if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
    if DisplayServer.window_get_flag(DisplayServer.WINDOW_FLAG_BORDERLESS):
      screen_mode_ob.select(3)
    else:
      screen_mode_ob.select(0)
  if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
    if DisplayServer.window_get_flag(DisplayServer.WINDOW_FLAG_BORDERLESS):
      screen_mode_ob.select(2)
    else:
      screen_mode_ob.select(1)

func _populate_resolution_options() -> void:
  for vec in RESOLUTIONS:
    var resolution_string := "%s x %s" % [vec.x, vec.y]
    resolution_ob.add_item(resolution_string)

func _update_resolution_options() -> void:
  var screen_size: Vector2i = DisplayServer.screen_get_size()

func _on_scale_slider_value_changed(_value: float) -> void:
  scale_percentage.text = "%s%%" % [scale_slider.value * 100]

func _on_scale_apply_button_pressed() -> void:
  get_window().content_scale_factor = scale_slider.value
