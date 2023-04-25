extends Node2D


func show_label() -> void:
    var anim_player: AnimationPlayer = get_node("AnimationPlayer")
    anim_player.play("show")
