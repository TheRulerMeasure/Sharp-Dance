extends Node


const CELL_SIZE: float = 48.0

export var target_node_np: NodePath
export(int, "Good Cells, Bad Cells") var cells_side: int = 0
export var active: bool = false

var target_node: Node2D


func _ready() -> void:
    target_node = get_node(target_node_np)

    var _c: int = GlobalComm.connect(
        "spawned_attack_to_cells",
        self,
        "_on_spawned_attack_to_cells"
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


func _on_spawned_attack_to_cells(attack_pack: PackedScene, cell_pos: Vector2) -> void:
    if not active:
        return
    var attack: Node2D = attack_pack.instance()
    attack.position = cell_pos * CELL_SIZE
    target_node.add_child(attack)


func _on_spawner_disabled(index: int) -> void:
    if index == cells_side:
        active = false


func _on_spawner_enabled(index: int) -> void:
    if index == cells_side:
        active = true
