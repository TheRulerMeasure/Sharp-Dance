extends Node2D


const MAX_CELLS_COUNT: int = 36
const CELL_SIZE: float = 48.0

export var bad_tray_np: NodePath

var bad_tray_node: Node2D
var cell_marker_node: Node2D


func _ready() -> void:
    connect_d_cards()
    bad_tray_node = get_node(bad_tray_np)
    cell_marker_node = bad_tray_node.get_node("CellMarker")

    var _c = GlobalComm.connect("hid_dynamic_deck", self, "_on_hid_dynamic_deck")
    _c = GlobalComm.connect("showed_dynamic_deck", self, "_on_showed_dynamic_deck")


func connect_d_cards() -> void:
    var d_cards: Node2D = get_node("DCards")

    var _c: int = d_cards.connect(
        "started_connecting_all_cells",
        self,
        "_on_started_connecting_all_cells"
    )
    _c = d_cards.connect(
        "show_tar_cell_pos_at",
        self,
        "_on_show_tar_cell_pos_at"
    )
    _c = d_cards.connect(
        "attached_crosshair",
        self,
        "_on_attached_crosshair"
    )


func _on_started_connecting_all_cells() -> void:
    var cells_node: Node2D = bad_tray_node.get_node("Cells")

    var d_cards: Node2D = get_node("DCards")

    for i in MAX_CELLS_COUNT:
        var cell: Area2D = cells_node.get_child(i)
        var _c: int = cell.connect(
            "input_event",
            d_cards,
            "_on_cell_input_event",
            [cell.get_index()]
        )


func _on_show_tar_cell_pos_at(cell_pos: Vector2) -> void:
    cell_marker_node.position = cell_pos * CELL_SIZE


func _on_attached_crosshair(crosshair_pack: PackedScene) -> void:
    if cell_marker_node.get_child_count() >= 1:
        for i in cell_marker_node.get_children():
            i.queue_free()
    var crosshair: Node2D = crosshair_pack.instance()
    cell_marker_node.add_child(crosshair)


func _on_hid_dynamic_deck() -> void:
    hide()
    cell_marker_node.get_child(0).queue_free()


func _on_showed_dynamic_deck() -> void:
    show()


func _on_attack_appended(

    attack_pack: PackedScene,
    seconds_take: float,
    target_cell_pos: Vector2,
    target_count: int

) -> void:
    GlobalComm.emit_signal(
        "append_attack_pack_to_waves_dealer",
        attack_pack,
        seconds_take,
        target_cell_pos,
        target_count
    )
