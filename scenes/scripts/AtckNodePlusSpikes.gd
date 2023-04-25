extends Node


const PLUS_SPIKES: PackedScene = preload("res://scenes/attacks/AtckPlusSpikes.tscn")

var target_cell_pos: Vector2 = Vector2.ZERO


func execute_wave() -> void:
    GlobalComm.emit_signal("spawned_attack_to_cells", PLUS_SPIKES, target_cell_pos)
