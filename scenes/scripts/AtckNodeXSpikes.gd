extends Node


const X_SPIKES: PackedScene = preload("res://scenes/attacks/AtckXSpikes.tscn")

var target_cell_pos: Vector2 = Vector2.ZERO


func execute_wave() -> void:
    GlobalComm.emit_signal("spawned_attack_to_cells", X_SPIKES, target_cell_pos)
