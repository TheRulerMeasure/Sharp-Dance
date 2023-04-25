extends Node


export var gridmover_np: NodePath

var gridmover_node: Node


func _ready() -> void:
    gridmover_node = get_node(gridmover_np)


func _process(_delta: float) -> void:
    if Input.is_action_just_pressed("ui_left"):
        gridmover_node.call("move_to_dir", Vector2.LEFT)
    elif Input.is_action_just_pressed("ui_right"):
        gridmover_node.call("move_to_dir", Vector2.RIGHT)
    elif Input.is_action_just_pressed("ui_up"):
        gridmover_node.call("move_to_dir", Vector2.UP)
    elif Input.is_action_just_pressed("ui_down"):
        gridmover_node.call("move_to_dir", Vector2.DOWN)
