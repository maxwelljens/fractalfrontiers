class_name InputControl extends Node
## Node controlling player ship.

@export var player: Player 
@onready var ship: Rig = player.rig

func _process(delta: float) -> void:
  pass
