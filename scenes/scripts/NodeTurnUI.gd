extends Node


func _ready() -> void:
    var _c: int = GlobalComm.connect("hid_ui_deck", self, "_on_hid_ui_deck")
    _c = GlobalComm.connect("showed_ui_deck", self, "_on_showed_ui_deck")


func _on_hid_ui_deck() -> void:
    var ui: CanvasLayer = get_parent()
    ui.hide()


func _on_showed_ui_deck() -> void:
    var ui: CanvasLayer = get_parent()
    ui.show()
