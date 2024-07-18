class_name Inventory extends PanelContainer

@export var spawner: MultiplayerSpawner 
@onready var cargo_volume: Label = %CargoVolume
@onready var list: VBoxContainer = %List
@onready var entry: MarginContainer = %Entry
@onready var entry_name: Label = %EntryName
@onready var entry_details: RichTextLabel = %EntryDetails

var player: Player:
  get: return Player.instance

func _ready() -> void:
  if not multiplayer.is_server():
    spawner.spawned.connect(_connect_sig_to_player)
  else:
    spawner.find_child("Networked").child_entered_tree.connect(_connect_sig_to_player)

func _connect_sig_to_player(node: Node):
  if node is Player:
    await get_tree().process_frame
    player.rig.cargo_updated.connect(_update_interface)
    _update_interface(player.rig.cargo)

func _update_interface(cargo: Dictionary) -> void:
  # Refresh list
  for child in list.get_children():
    if child == entry: continue 
    child.queue_free()
    
  # Update UI from information of a Rig.cargo
  var total_item_volume: float
  for item_key in cargo.keys():
    var item_name: String = item_key.capitalize()
    var item_amount: int = cargo[item_key]["amount"]
    var item_volume: float = cargo[item_key]["volume"]
    total_item_volume += item_volume
    # Set up invisible Entry with relevant information, then duplicate and parent to List
    entry_name.text = item_name 
    entry_details.text = "[right]%s [color=darkgray]/ %s m³[/color][/right]" % [item_amount, item_volume]
    var new_entry = entry.duplicate()
    $VBoxContainer/ScrollContainer/List.add_child(new_entry)
    # Make new entry visible
    new_entry.visible = true 
  
  # Update total cargo volume / cargo capacity label
  cargo_volume.text = "%s/%s m³" % [total_item_volume, player.rig.cargo_capacity]
