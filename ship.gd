extends CharacterBody2D

func _physics_process(delta):
  # if is_multiplayer_authority():
  velocity = Input.get_vector("left", "right", "forward", "backward") * 400
  move_and_slide()

func _enter_tree():
  set_multiplayer_authority(name.to_int())
