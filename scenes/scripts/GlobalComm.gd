extends Node


func _ready() -> void:
    add_user_signal(
        "append_attack_pack_to_waves_dealer",
        [
            { "name": "attack_pack", "type": TYPE_OBJECT },
            { "name": "seconds_take", "type": TYPE_REAL },
            { "name": "target_cell_pos", "type": TYPE_VECTOR2 },
            { "name": "target_count", "type": TYPE_INT },
        ]
    )
    add_user_signal("timeline_packed")

    add_user_signal("hid_ui_deck")
    add_user_signal("showed_ui_deck")

    add_user_signal("hid_dynamic_deck")
    add_user_signal("showed_dynamic_deck")

    add_user_signal("deck_cleared")
    add_user_signal("deck_layed")
    add_user_signal("decks_laying_started")

    add_user_signal("spawned_attack_to_cells")
    add_user_signal("spawned_seek_attack_to_cells")

    add_user_signal("gridmover_move_allowed")
    add_user_signal("gridmover_move_disallowed")

    add_user_signal("phase_moved_next")

    add_user_signal("enemy_attack_append_started")

    add_user_signal("cells_spawner_enabled")
    add_user_signal("cells_spawner_disabled")

    add_user_signal("health_changed")

    add_user_signal("declared_bad")
    add_user_signal("declared_good")
