extends Node


signal move_disallow_setted
signal move_allow_setted


const MAX_COLUMN: int = 6
const MAX_ROW: int = 6
const MAX_CELLS_COUNT: int = 36
const CELL_SIZE: float = 48.0

export var move_allowed: bool = false setget set_move_allowed

var mover_node: Node2D
var cur_cell_pos: Vector2 = Vector2.ZERO
var move_delay_timer: Timer


func _ready() -> void:
    move_delay_timer = get_node("MoveDelayTimer")
    mover_node = get_parent()

    var _c: int = move_delay_timer.connect(
        "timeout", self, "_on_move_delay_timer_timeout"
    )

    _c = GlobalComm.connect(
        "gridmover_move_allowed", self, "_on_gridmover_move_allowed"
    )
    _c = GlobalComm.connect(
        "gridmover_move_disallowed", self, "_on_gridmover_move_disallowed"
    )


func set_move_allowed(allowed: bool) -> void:
    move_allowed = allowed
    if move_allowed:
        emit_signal("move_allow_setted")
        return
    emit_signal("move_disallow_setted")


func move_to_dir(dir: Vector2) -> void:
    if not move_allowed:
        return
    if not move_delay_timer.is_stopped():
        return
    if not check_cell_available(cur_cell_pos + dir):
        return
    cur_cell_pos += dir
    mover_node.position = cur_cell_pos * CELL_SIZE
    move_delay_timer.start()


func check_cell_available(cell_pos: Vector2) -> bool:
    if cell_pos.x < 0:
        return false
    if cell_pos.y < 0:
        return false
    if cell_pos.x >= MAX_COLUMN:
        return false
    if cell_pos.y >= MAX_ROW:
        return false
    return true


func _on_gridmover_move_allowed() -> void:
    set_move_allowed(true)


func _on_gridmover_move_disallowed() -> void:
    set_move_allowed(false)


func _on_move_delay_timer_timeout() -> void:
    pass
