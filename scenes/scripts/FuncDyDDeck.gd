extends Node


func hide_dynamic_deck() -> void:
    GlobalComm.emit_signal("hid_dynamic_deck")


func show_dynamic_deck() -> void:
    GlobalComm.emit_signal("showed_dynamic_deck")


func clear_deck() -> void:
    GlobalComm.emit_signal("deck_cleared")


func lay_decks() -> void:
    GlobalComm.emit_signal("decks_laying_started")


func hide_ui_deck() -> void:
    GlobalComm.emit_signal("hid_ui_deck")


func show_ui_deck() -> void:
    GlobalComm.emit_signal("showed_ui_deck")
