extends Area2D

signal timeline_overlapped
signal timeline_unoverlapped


const TIMELINE_WIDTH: float = 512.0

var glue_inst_id: int = -1
var node_to_track_to: Node2D
var area_node: Node2D
var col: CollisionShape2D
var entered_count: int = 0
var cur_resource: Resource
var label_node: Node2D
var label: Label


func _ready() -> void:
    label_node = get_node("LabelNode")
    label = get_node("LabelNode/Label")
    hide()
    area_node = get_node("../..")
    col = get_node("CollisionShape2D") as CollisionShape2D
    var rect_shape2d: RectangleShape2D = RectangleShape2D.new()
    rect_shape2d.extents = Vector2(8.0, 70.0)
    col.shape = rect_shape2d

    var _c: int = connect("area_entered", self, "_on_area_entered")
    _c = connect("area_exited", self, "_on_area_exited")


func _process(_delta: float) -> void:
    if not node_to_track_to:
        return

    position = Vector2(
        area_node.to_local(node_to_track_to.position).x,
        position.y
    )
    var rect: RectangleShape2D = col.shape
    label_node.position = Vector2(-rect.extents.x, -100.0)
    var real_seconds: float = get_start_point()
    real_seconds *= (6.0 / 512.0)
    label.text = "At seconds: \n"
    label.text += "%10.2f" % real_seconds


func _draw() -> void:
    var rect: RectangleShape2D = col.shape
    draw_rect(
        Rect2(-rect.extents.x, -rect.extents.y, rect.extents.x*2.0, rect.extents.y*2.0),
        Color.webgray
    )


func resize_col_to_seconds(secs: float) -> void:
    var rect: RectangleShape2D = col.shape
    rect.extents = Vector2(
        ((secs*0.5) * 512.0) / 6.0,
        rect.extents.y
    )
    update()


func latch_to_node(node: Node2D) -> void:
    show()
    glue_inst_id = node.get_instance_id()
    node_to_track_to = node

    var res: Resource = node.get("attack_resource")
    cur_resource = res
    resize_col_to_seconds(res.get("seconds_take"))

    col.set_deferred("disabled", false)


func unlatch() -> void:
    hide()
    glue_inst_id = -1
    node_to_track_to = null
    cur_resource = null
    col.set_deferred("disabled", true)


func get_start_point() -> float:
    var rect: RectangleShape2D = col.shape
    var x: float = position.x - rect.extents.x
    x += TIMELINE_WIDTH
    return x


func get_target_cell_pos() -> Vector2:
    return node_to_track_to.get("cur_tar_cell_pos")


func _on_area_entered(_area: Area2D) -> void:
    entered_count += 1
    if entered_count == 1:
        modulate = Color.red
        emit_signal("timeline_overlapped")


func _on_area_exited(_area: Area2D) -> void:
    entered_count -= 1
    if entered_count <= 0:
        modulate = Color.white
        emit_signal("timeline_unoverlapped")
