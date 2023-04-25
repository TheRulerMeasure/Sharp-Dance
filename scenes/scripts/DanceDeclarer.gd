extends Node


func declare_bad() -> void:
    GlobalComm.emit_signal("declared_bad")


func declare_good() -> void:
    GlobalComm.emit_signal("declared_good")
