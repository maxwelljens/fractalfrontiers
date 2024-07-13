class_name TargetHolder extends Node2D


var targets: Array[Node2D]


static var instance: TargetHolder


func _ready() -> void:
    if is_multiplayer_authority():
        instance = self


func append_target(target: Node2D) -> void:
    targets.append(target)


func remove_target(target: Node2D) -> void:
    targets.erase(target)
