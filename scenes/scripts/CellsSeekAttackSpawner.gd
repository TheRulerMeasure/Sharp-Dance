extends Node


export var owner_np: NodePath
export var target_node_np: NodePath
export(int, "Good Cells, Bad Cells") var cells_side: int = 0
export var active: bool = false

var owner_node: Node2D
var target_node: Node2D


func _ready() -> void:
    owner_node = get_node(owner_np)
    target_node = get_node(target_node_np)

    var _c: int = GlobalComm.connect(
        "spawned_seek_attack_to_cells",
        self,
        "_on_spawned_seek_attack_to_cells"
    )
    _c = GlobalComm.connect(
        "cells_spawner_disabled",
        self,
        "_on_spawner_disabled"
    )
    _c = GlobalComm.connect(
        "cells_spawner_enabled",
        self,
        "_on_spawner_enabled"
    )


func _on_spawned_seek_attack_to_cells(attack_pack: PackedScene) -> void:
    if not active:
        return
    var attack: Node2D = attack_pack.instance()
    var node: Node2D = owner_node.get_child(0)
    attack.position = node.position
    target_node.add_child(attack)


func _on_spawner_disabled(index: int) -> void:
    if index == cells_side:
        active = false


func _on_spawner_enabled(index: int) -> void:
    if index == cells_side:
        active = true
