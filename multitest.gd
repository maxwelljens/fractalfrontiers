class_name NetworkManager extends Node2D

static var peer = ENetMultiplayerPeer.new()
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
  $MultiplayerSpawner/Networked.add_child(player, true)

func _on_join_pressed():
  peer.create_client("localhost", 2010)
  multiplayer.multiplayer_peer = peer
  _remove_buttons()

func _remove_buttons():
  $Host.visible = false
  $Join.visible = false

func _on_multiplayer_spawner_spawned(node):
    print(node) 
