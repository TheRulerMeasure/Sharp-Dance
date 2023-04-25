extends Node


export(Array, Resource) var attack_resources: Array = []
export(int, 1, 8) var decks_count: int = 8

var rand: RandomNumberGenerator


func _ready() -> void:
    rand = RandomNumberGenerator.new()
    rand.randomize()

    var _c: int = GlobalComm.connect("decks_laying_started", self, "_on_decks_laying_started")


func lay_decks() -> void:
    for i in decks_count:
        var index: int = rand.randi_range(0, attack_resources.size()-1)
        var res: Resource = attack_resources[index]
        GlobalComm.emit_signal("deck_layed", res)


func _on_decks_laying_started() -> void:
    lay_decks()
