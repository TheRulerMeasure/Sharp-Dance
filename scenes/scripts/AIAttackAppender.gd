extends Node


const MAX_COLUMN: int = 6
const MAX_ROW: int = 6

export(Array, Resource) var attack_resources: Array = []
export(int, 1, 29) var min_count: int = 2
export(int, 1, 29) var max_count: int = 3

var rand: RandomNumberGenerator


func _ready() -> void:
    rand = RandomNumberGenerator.new()
    rand.randomize()

    var _c: int = GlobalComm.connect(
        "enemy_attack_append_started", self, "_on_enemy_attack_append_started"
    )


func append_start() -> void:
    var count: int = rand.randi_range(min_count, max_count)
    var secs: float = 0.45
    for i in count:
        secs += rand.randf()*1.7
        var index: int = rand.randi_range(0, attack_resources.size()-1)
        var res: Resource = attack_resources[index]
        append_to_waves_dealer(res.get("attack_pack"), secs, count)
        secs += res.get("seconds_take")


func append_to_waves_dealer(

    attack_pack: PackedScene, seconds: float, count: int

) -> void:

    var cell_pos: Vector2 = Vector2(
        rand.randi_range(0, MAX_COLUMN - 1),
        rand.randi_range(0, MAX_ROW - 1)
    )

    GlobalComm.emit_signal(
        "append_attack_pack_to_waves_dealer",
        attack_pack,
        seconds,
        cell_pos,
        count
    )


func _on_enemy_attack_append_started() -> void:
    append_start()
