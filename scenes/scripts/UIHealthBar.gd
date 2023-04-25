extends CanvasLayer


enum {
    PLAYER,
    ENEMY
}

const PLAYER_HP_CONTAINER_PATH: String = "MarginContainer/CenterContainer/VBoxContainer/Player"
const ENEMY_HP_CONTAINTER_PATH: String = "MarginContainer/CenterContainer/VBoxContainer/Enemy"

var player_hp_container: Control
var enemy_hp_containter: Control
var cur_player_hp_count: int = 20
var cur_enemy_hp_count: int = 20


func _ready() -> void:
    player_hp_container = get_node(PLAYER_HP_CONTAINER_PATH)
    enemy_hp_containter = get_node(ENEMY_HP_CONTAINTER_PATH)

    var _c: int = GlobalComm.connect("health_changed", self, "_on_health_changed")


func set_player_health(new_health: int) -> void:
    if new_health == cur_player_hp_count:
        return

    if new_health > cur_player_hp_count:
        for i in range(cur_player_hp_count, new_health, 1):
            var hp: Control = player_hp_container.get_child(i)
            hp.show()
        return

    for i in range(cur_player_hp_count - 1, new_health - 1, -1):
        var hp: Control = player_hp_container.get_child(i)
        hp.hide()
    cur_player_hp_count = new_health


func set_enemy_health(new_health: int) -> void:
    if new_health == cur_enemy_hp_count:
        return

    if new_health > cur_enemy_hp_count:
        for i in range(cur_enemy_hp_count, new_health, 1):
            var hp: Control = enemy_hp_containter.get_child(i)
            hp.show()
        return

    for i in range(cur_enemy_hp_count - 1, new_health - 1, -1):
        var hp: Control = enemy_hp_containter.get_child(i)
        hp.hide()
    cur_enemy_hp_count = new_health


func _on_health_changed(index: int, new_health: int) -> void:
    match index:
        PLAYER:
            set_player_health(new_health)
        ENEMY:
            set_enemy_health(new_health)
