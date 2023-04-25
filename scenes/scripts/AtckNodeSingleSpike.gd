extends Node


const SINGLE_SPIKE: PackedScene = preload("res://scenes/attacks/AtckSingleSpike.tscn")

var target_cell_pos: Vector2 = Vector2.ZERO


func execute_wave() -> void:
    GlobalComm.emit_signal("spawned_attack_to_cells", SINGLE_SPIKE, target_cell_pos)
