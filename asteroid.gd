extends Area2D

var health: float = 100

const RED = Color(0.898, 0, 0)

func damage(amount: float):
  health -= amount
  $Sprite2D.modulate = $Sprite2D.modulate.lerp(RED, 1 - (health/100))
  if health <= 0:
    queue_free()
  $Label.text = str(health).pad_decimals(0)
