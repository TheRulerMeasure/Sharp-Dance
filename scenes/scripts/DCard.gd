extends Area2D


signal card_selected
signal card_released


export var attack_resource: Resource

var must_follow_mouse: bool = false
var relative_mouse_pos: Vector2 = Vector2.ZERO
var cur_tar_cell_pos: Vector2 = Vector2.ZERO
var original_pos: Vector2 = Vector2.ZERO
var sprite_node: Sprite


func _ready() -> void:
    sprite_node = get_node("Sprite")
    original_pos = position
    var _c: int = connect("card_selected", get_parent(), "_on_card_selected")

    put_icon()


func _process(_delta: float) -> void:
    if not must_follow_mouse:
        return

    position = get_global_mouse_position() - relative_mouse_pos


func put_icon() -> void:
    var texture: Texture = attack_resource.get("card_icon")
    sprite_node.texture = texture


func mouse_pressed_action() -> void:
    must_follow_mouse = true
    relative_mouse_pos = to_local(get_global_mouse_position())
    emit_signal("card_selected", self)


func mouse_released_action() -> void:
    must_follow_mouse = false
    emit_signal("card_released")


func _input_event(_viewport: Object, event: InputEvent, _shape_idx: int) -> void:
    if not (event is InputEventMouseButton):
        return

    var m_event: InputEventMouseButton = event

    if m_event.pressed and m_event.button_index == BUTTON_LEFT:
        mouse_pressed_action()
    elif (not m_event.pressed) and m_event.button_index == BUTTON_LEFT:
        mouse_released_action()
