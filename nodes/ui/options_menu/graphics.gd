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
  Vector2i(1152, 648), # Godot Default
  Vector2i(1280, 720),
  Vector2i(1440, 900),
  Vector2i(1366, 768),
  Vector2i(1920, 1080),
  Vector2i(2560, 1440),
  Vector2i(3840, 2160),
]

@onready var screen_mode_ob: OptionButton = %ScreenModeOB
@onready var resolution_ob: OptionButton = %ResolutionOB
@onready var vsync_cb: CheckButton = %VSyncCB

func _ready() -> void:
  screen_mode_ob.item_selected.connect(_on_screen_mode_selected)
  resolution_ob.item_selected.connect(_on_resolution_ob_item_selected)
  vsync_cb.toggled.connect(_on_vsync_cb_toggled)
  _populate_screen_mode_options()
  _update_screen_mode_selection()
  _populate_resolution_options()
  _update_vsync_mode()

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
  resolution_ob.select(2)

func _on_resolution_ob_item_selected(index: int) -> void:
  get_window().size = RESOLUTIONS[index]

func _on_vsync_cb_toggled(toggled_on: bool) -> void:
  if toggled_on:
    DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ADAPTIVE)
    print(DisplayServer.window_get_vsync_mode())
  else:
    DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

func _update_vsync_mode() -> void:
  if DisplayServer.window_get_vsync_mode() == DisplayServer.VSYNC_DISABLED:
    vsync_cb.button_pressed = false
  else:
    vsync_cb.button_pressed = true
