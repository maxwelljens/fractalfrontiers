class_name ButtonTest extends Button

@export var fittings: UIFittings

func _on_pressed():
  fittings.button_pressed(self)
