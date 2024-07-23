class_name FittingContainer extends CenterContainer

@export var fittings: UIFittings
@onready var cycle_bar: TextureProgressBar = $CycleBar
var index := -1

func _on_button_pressed():
  if index == -1:
    push_error("How?")
  var ui_signal: Signal = fittings.ui.fitting_button_pressed
  ui_signal.emit(index)
