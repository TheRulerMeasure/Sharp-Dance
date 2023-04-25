extends Area2D


var sliders_node: Node2D


func _ready() -> void:
    sliders_node = get_node("Sliders")
    var _c: int = connect("area_entered", self, "_on_area_entered")
    _c = connect("area_exited", self, "_on_area_exited")


func _draw() -> void:
    draw_rect(
        Rect2(-512.0, -72.0, 1024.0, 144.0),
        Color.gray,
        false,
        2.7
    )


func _on_area_entered(area: Area2D) -> void:
    for i in sliders_node.get_child_count():
        var slider: Node2D = sliders_node.get_child(i)
        if slider.get("glue_inst_id") >= 0:
            continue
        slider.call("latch_to_node", area)
        return


func _on_area_exited(area: Area2D) -> void:
    for i in sliders_node.get_child_count():
        var slider: Node2D = sliders_node.get_child(i)
        if slider.get("glue_inst_id") != area.get_instance_id():
            continue
        slider.call("unlatch")
        return
