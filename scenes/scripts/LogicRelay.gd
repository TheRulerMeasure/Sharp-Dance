extends Node

signal on_trigger

export var clk: bool = true setget set_clk


func set_clk(t: bool) -> void:
    clk = t
    trigger()


func trigger(_a = null, _b = null, _c = null, _d = null) -> void:
    emit_signal("on_trigger")
