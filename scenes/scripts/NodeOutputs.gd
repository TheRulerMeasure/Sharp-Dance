extends Node

export var signal_name: String = ""
export var target_node: NodePath
export var method_name: String = ""
export var params: Array = []
export(int, FLAGS, "DEFERRED, PERSIST, ONESHOT, REF_COUNTED") var connect_flags: int = 0


func _ready() -> void:
    var _c: int = get_parent().connect(
        signal_name,
        get_node(target_node),
        method_name,
        params,
        connect_flags
    )
