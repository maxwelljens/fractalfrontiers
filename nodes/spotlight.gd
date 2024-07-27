extends PointLight2D

func _process(delta):
  var target = get_global_mouse_position()
  var angle = (target - global_position).angle()
  global_rotation = lerp_angle(global_rotation, angle, delta)
