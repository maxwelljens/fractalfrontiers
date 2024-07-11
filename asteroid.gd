extends Area2D

var health: float = 100

const WHITE = Color(1, 1, 1)
const RED = Color(0.898, 0, 0)

func damage(amount: float):
  health -= amount
  modulate.lerp(RED, health-100)
  if health <= 0:
    queue_free()
  $Label.text = str(health).pad_decimals(0)
