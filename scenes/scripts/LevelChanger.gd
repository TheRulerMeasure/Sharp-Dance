extends Node


export(String, FILE, "*.tscn") var level_file_path


func change_level() -> void:
    var _c: int = get_tree().change_scene(level_file_path)
