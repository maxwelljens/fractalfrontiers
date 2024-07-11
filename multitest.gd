extends Node2D

var peer = ENetMultiplayerPeer.new()
@export var player_scene: PackedScene

func _on_host_pressed():
  peer.create_server(2010)
  multiplayer.multiplayer_peer = peer
  multiplayer.peer_connected.connect(_add_player)
  _add_player()
  _remove_buttons()
  
func _add_player(id = 1):
  var player = player_scene.instantiate()
  player.name = str(id)
  add_child.call_deferred(player)

func _on_join_pressed():
  peer.create_client("localhost", 2010)
  multiplayer.multiplayer_peer = peer
  _remove_buttons()

func _remove_buttons():
  $Host.visible = false
  $Join.visible = false
