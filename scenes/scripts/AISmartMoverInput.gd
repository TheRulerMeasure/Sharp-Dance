extends Node


export var gridmover_np: NodePath
export(float, 0.02, 5.0, 0.02) var min_wait_time: float = 0.2
export(float, 0.02, 5.0, 0.02) var max_wait_time: float = 1.0

var gridmover_node: Node
var rand: RandomNumberGenerator
var timer: Timer


func _ready() -> void:
    rand = RandomNumberGenerator.new()
    rand.randomize()
    gridmover_node = get_node(gridmover_np)
    timer = get_node("Timer")
    var _c: int = timer.connect("timeout", self, "_on_timer_timeout")


func _on_timer_timeout() -> void:
    var num: int = rand.randi_range(0, 3)
    var moves: PoolVector2Array = [
        Vector2.LEFT,
        Vector2.RIGHT,
        Vector2.UP,
        Vector2.DOWN
    ]
    gridmover_node.call("move_to_dir", moves[num])
    timer.wait_time = rand.randf_range(min_wait_time, max_wait_time)
