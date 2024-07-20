class_name UIInventory extends PanelContainer

@export var ui: UI 
@onready var player: Player = ui.player
@onready var cargo_volume: Label = %CargoVolume
@onready var list: VBoxContainer = %List
@onready var entry: MarginContainer = %Entry
@onready var entry_icon: TextureRect = %EntryIcon
@onready var entry_name: Label = %EntryName
@onready var entry_details: RichTextLabel = %EntryDetails

func _ready() -> void:
  player.cargo_updated.connect(_update_interface)
  _update_interface()

func _update_interface() -> void:
  # Make sure template Entry stays invisible
  entry.visible = false
  # Refresh list
  for child in list.get_children():
    if child == entry: continue 
    child.queue_free()
    
  # Update UI from information of a Rig.cargo
  var cargo: Dictionary = player.rig.cargo
  var total_item_volume := 0.0
  for item_key in cargo.keys():
    var item_name: String = item_key.capitalize()
    var item_icon: Resource = load(cargo[item_key]["icon"])
    var item_amount: int = cargo[item_key]["amount"]
    var item_volume: float = cargo[item_key]["volume"]
    total_item_volume += item_volume
    # Set up invisible Entry with relevant information, then duplicate and parent to List
    entry_name.text = item_name 
    entry_icon.texture = item_icon
    entry_details.text = "[right]%s [color=#a89984]/ %s m³[/color][/right]" % [item_amount, item_volume]
    var new_entry = entry.duplicate()
    list.add_child(new_entry)
    # Make new entry visible
    new_entry.visible = true 
  
  # Update total cargo volume / cargo capacity label
  cargo_volume.text = "%s/%s m³" % [total_item_volume, player.rig.cargo_capacity]
