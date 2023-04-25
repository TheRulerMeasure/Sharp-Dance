extends Node2D


signal show_tar_cell_pos_at(cell_pos)
signal attached_crosshair(crosshair)
signal started_connecting_all_cells


const DCARD: PackedScene = preload("res://scenes/decks/DCard.tscn")
const MAX_COLUMNS: int = 6
const CELL_SIZE: float = 48.0

var cur_selected_card: Area2D
var connected_to_cells: bool = false
var cur_card_index: int = 0


func _ready() -> void:
    var _c: int = GlobalComm.connect("deck_cleared", self, "_on_comm_deck_cleared")
    _c = GlobalComm.connect("deck_layed", self, "_on_deck_layed")


func _on_card_selected(card_area: Area2D) -> void:
    cur_selected_card = card_area

    var res: Resource = cur_selected_card.get("attack_resource")

    emit_signal("attached_crosshair", res.get("crosshair_pack"))
    emit_signal("show_tar_cell_pos_at", card_area.get("cur_tar_cell_pos"))

    if not connected_to_cells:
        emit_signal("started_connecting_all_cells")

    connected_to_cells = true


func to_2d_vector(index: int) -> Vector2:
    var x: int = index % MAX_COLUMNS
    var y: int = int(floor(float(index) / MAX_COLUMNS))
    return Vector2(x, y)


func clear_cards() -> void:
    for i in get_children():
        i.queue_free()


func _on_comm_deck_cleared() -> void:
    clear_cards()


func lay_deck(attack_resource: Resource) -> void:
    cur_card_index += 1
    if cur_card_index > 8:
        cur_card_index = 0

    var d_card: Node2D = DCARD.instance()
    d_card.set("attack_resource", attack_resource)
    d_card.position = Vector2(
        100.0,
        100.0 + cur_card_index * 40.0
    )
    add_child(d_card)


func _on_deck_layed(attack_resource: Resource) -> void:
    lay_deck(attack_resource)


func _on_cell_input_event(

    _viewport: Node,
    event: InputEvent,
    _shape_index: int,
    cell_index: int

) -> void:

    if not (event is InputEventMouseButton):
        return

    var m_event: InputEventMouseButton = event

    if not m_event.pressed:
        return
    if m_event.button_index != BUTTON_LEFT:
        return

    var vec: Vector2 = to_2d_vector(cell_index)
    cur_selected_card.set("cur_tar_cell_pos", vec)
    emit_signal("show_tar_cell_pos_at", vec)


func _on_cell_selected(cell_pos: Vector2) -> void:
    cur_selected_card.set("cur_tar_cell_pos", cell_pos)
