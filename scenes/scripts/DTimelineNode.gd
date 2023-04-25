extends Node


signal attack_appended(attack_pack)


var sliders_node: Node2D


func _ready() -> void:
    sliders_node = get_node("../Sliders")

    var _c: int = connect(
        "attack_appended",
        get_node("../.."),
        "_on_attack_appended"
    )

    _c = GlobalComm.connect("timeline_packed", self, "_on_timeline_packed")


func pack_timeline() -> void:
    var count: int = 0
    
    for i in sliders_node.get_child_count():
        var area: Area2D = sliders_node.get_child(i)
        if area.get("entered_count") > 0:
            printerr("error timeline overlapped.")
            return
        if area.get("glue_inst_id") >= 0:
            count += 1

    if count <= 0:
        printerr("no cards in the slider")
        return

    for i in count:
        var area: Area2D = sliders_node.get_child(i)
        var res: Resource = area.get("cur_resource")
        if not res:
            continue
        var attack_pack: PackedScene = res.get("attack_pack")
        var real_seconds: float = area.call("get_start_point")
        real_seconds *= (6.0 / 512.0)
        emit_signal(
            "attack_appended",
            attack_pack,
            real_seconds,
            area.call("get_target_cell_pos"),
            count
        )


func _on_timeline_packed() -> void:
    pack_timeline()
