extends Node


signal good_declare_recieved
signal bad_declare_recieved


var declared: bool = false


func _ready() -> void:
    var _c: int = GlobalComm.connect("declared_bad", self, "_on_bad_declared")
    _c = GlobalComm.connect("declared_good", self, "_on_good_declared")


func _on_good_declared() -> void:
    if declared:
        return
    emit_signal("good_declare_recieved")
    declared = true


func _on_bad_declared() -> void:
    if declared:
        return
    emit_signal("bad_declare_recieved")
    declared = true
