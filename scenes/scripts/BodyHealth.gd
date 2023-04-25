extends Node


signal health_changed(new_health)
signal died


export(int, 1, 20) var health: int = 10

var area_node: Area2D


func _ready() -> void:
    area_node = get_parent() as Area2D
    var _c: int = area_node.connect("area_entered", self, "_on_area_entered")


func _on_area_entered(_area: Area2D) -> void:
    health -= 1
    if health < 0:
        health = 0
    emit_signal("health_changed", health)
    if health > 0:
        return
    emit_signal("died")
