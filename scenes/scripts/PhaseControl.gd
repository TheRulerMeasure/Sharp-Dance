extends Node

enum Cells {
    GOOD_CELLS,
    BAD_CELLS
}

enum Phase {
    Player_Assemble,
    Enemy_Dodging,
    Enemy_Assemble,
    Player_Dodging
}


export(
    int,
    "Player Assemble, Enemy Dodging, Enemy Assemble, Player Dodging"
) var cur_phase: int = 0

var func_ddeck_node: Node


func _ready() -> void:
    func_ddeck_node = get_node("FuncDyDDeck")

    var _c: int = GlobalComm.connect("phase_moved_next", self, "_on_phase_moved_next")


func next_phase() -> void:
    cur_phase += 1
    if cur_phase > 3:
        cur_phase = 0
    protest(cur_phase)


func protest(phase: int) -> void:
    match phase:
        Phase.Player_Assemble:
            init_player_assemble()
        Phase.Enemy_Dodging:
            init_enemy_dodging()
        Phase.Enemy_Assemble:
            init_enemy_assemble()
        Phase.Player_Dodging:
            init_player_dodging()


func protest_current() -> void:
    protest(cur_phase)


func init_player_assemble() -> void:
    GlobalComm.emit_signal("gridmover_move_disallowed")
    func_ddeck_node.call("show_dynamic_deck")
    func_ddeck_node.call("show_ui_deck")
    func_ddeck_node.call("lay_decks")


func init_enemy_dodging() -> void:
    GlobalComm.emit_signal("cells_spawner_disabled", Cells.GOOD_CELLS)
    GlobalComm.emit_signal("cells_spawner_enabled", Cells.BAD_CELLS)

    GlobalComm.emit_signal("gridmover_move_allowed")
    func_ddeck_node.call("clear_deck")
    func_ddeck_node.call("hide_dynamic_deck")
    func_ddeck_node.call("hide_ui_deck")


func init_enemy_assemble() -> void:
    GlobalComm.emit_signal("gridmover_move_disallowed")
    GlobalComm.emit_signal("enemy_attack_append_started")


func init_player_dodging() -> void:
    GlobalComm.emit_signal("cells_spawner_disabled", Cells.BAD_CELLS)
    GlobalComm.emit_signal("cells_spawner_enabled", Cells.GOOD_CELLS)

    GlobalComm.emit_signal("gridmover_move_allowed")


func _on_phase_moved_next() -> void:
    next_phase()
