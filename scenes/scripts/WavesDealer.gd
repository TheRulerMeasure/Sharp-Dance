extends Node


signal waves_begun
signal waves_ended


const EXECUTE_WAVE: String = "execute_wave"

var waves_node: Node
var attack_packs: Array = []
var seconds_takes: Array = []
var target_cell_positions: PoolVector2Array = []
var cur_wave_index: int = 0
var timer: Timer
var f_seconds_timer: Timer


func _ready() -> void:
    timer = get_node("Timer")
    f_seconds_timer = get_node("FinalSecondsTimer")
    waves_node = get_node("Waves")

    var _c: int = waves_node.connect(
        "child_entered_tree",
        self,
        "_on_waves_node_child_entered_tree"
    )
    _c = timer.connect("timeout", self, "_on_timer_timeout")
    _c = f_seconds_timer.connect("timeout", self, "_on_f_seconds_timer_timeout")

    _c = GlobalComm.connect(
        "append_attack_pack_to_waves_dealer",
        self,
        "_on_attack_pack_appended"
    )


func end_waves() -> void:
    emit_signal("waves_ended")
    GlobalComm.emit_signal("phase_moved_next")


func clean_waves() -> void:
    attack_packs.clear()
    seconds_takes.clear()
    target_cell_positions = []
    for i in waves_node.get_child_count():
        var node: Node = waves_node.get_child(i)
        var _c: int = node.connect("tree_exited", self, "_on_node_exited")
        node.queue_free()


func start_wave() -> void:
    if cur_wave_index >= waves_node.get_child_count():
        f_seconds_timer.start()
        return

    var real_seconds: float = seconds_takes[cur_wave_index]
    real_seconds -= seconds_takes[cur_wave_index-1]
    timer.start(real_seconds)


func begin_waves() -> void:
    cur_wave_index = 0
    emit_signal("waves_begun")
    GlobalComm.emit_signal("phase_moved_next")
    timer.start(seconds_takes[cur_wave_index])


func load_waves() -> void:
    if waves_node.get_child_count() >= attack_packs.size():
        begin_waves()
        return

    var attack_pack: PackedScene = attack_packs[waves_node.get_child_count()]
    var attack: Node = attack_pack.instance()
    attack.set("target_cell_pos", target_cell_positions[waves_node.get_child_count()])
    waves_node.add_child(attack)


func attack_pack_append(

    attack_pack: PackedScene,
    seconds_take: float,
    target_cell_pos: Vector2,
    target_count: int

) -> void:

    if seconds_takes.empty():
        seconds_takes.append(seconds_take)
        attack_packs.append(attack_pack)
        target_cell_positions.append(target_cell_pos)
    else:
        var inserted: bool = false

        for i in seconds_takes.size():
            var secs: float = seconds_takes[i]
            if seconds_take < secs:
                seconds_takes.insert(i, seconds_take)
                attack_packs.insert(i, attack_pack)
                var _vec_in: int = target_cell_positions.insert(i, target_cell_pos)
                inserted = true
                break

        if not inserted:
            seconds_takes.append(seconds_take)
            attack_packs.append(attack_pack)
            target_cell_positions.append(target_cell_pos)

    if attack_packs.size() >= target_count:
        load_waves()


func _on_attack_pack_appended(

    attack_pack: PackedScene,
    seconds_take: float,
    target_cell_pos: Vector2,
    target_count: int

) -> void:

    attack_pack_append(attack_pack, seconds_take, target_cell_pos, target_count)


func _on_waves_node_child_entered_tree(_node: Node) -> void:
    load_waves()


func _on_timer_timeout() -> void:
    var cur_wave: Node = waves_node.get_child(cur_wave_index)
    cur_wave.call(EXECUTE_WAVE)
    cur_wave_index += 1
    start_wave()


func _on_f_seconds_timer_timeout() -> void:
    clean_waves()


func _on_node_exited() -> void:
    if waves_node.get_child_count() > 0:
        return
    end_waves()
