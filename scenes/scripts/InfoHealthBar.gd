extends Node


export(int, "Player, Enemy") var current_bar: int = 0
export(int, 1, 20) var start_value: int = 10


func _ready() -> void:
    var auto_update_value_timer: Timer = get_node("AutoUpdateValueTimer")
    var _c: int = auto_update_value_timer.connect("timeout", self, "_on_auto_timeout")
    auto_update_value_timer.start()


func update_cur_bar_health(new_value: int) -> void:
    GlobalComm.emit_signal("health_changed", current_bar, new_value)


func _on_auto_timeout() -> void:
    update_cur_bar_health(start_value)
