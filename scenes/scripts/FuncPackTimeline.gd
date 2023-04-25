extends Node


func pack_timeline() -> void:
    GlobalComm.emit_signal("timeline_packed")
