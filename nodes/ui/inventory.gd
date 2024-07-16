class_name Inventory extends PanelContainer

@onready var cargo_volume: Label = %CargoVolume
@onready var entry: MarginContainer = %Entry
@onready var entry_name: Label = %EntryName
@onready var entry_amount: RichTextLabel = %EntryAmount

func add_entry(xname: String, amount: int) -> void:
  entry_name.text = xname.capitalize()
  entry_amount.text = "[right]%s [color=orange]m³[/color][/right]" % amount
  entry.visible = true
  $VBoxContainer/List/VBoxContainer.add_child(entry.duplicate())
  entry.visible = false
