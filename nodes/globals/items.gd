class_name ItemsDB extends Resource

const FUNC_MINE: String = "mine"
const ITEMS := {
  "ferroaster": {
    "icon": "res://art/icons/ore_minerals/ferroaster.tres",
    "volume": 0.2,
    "mineral": "illidenium", 
  },
  "illdenium": {
    "icon": "res://art/icons/ore_minerals/illidenium.tres",
    "volume": 0.01,
  },
  "mining_cannon": {
    "icon": "res://art/icons/turrets/mining/mining_cannon.tres",
    "function": FUNC_MINE
  }
}
