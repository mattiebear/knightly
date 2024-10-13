extends Node2D

enum State {Idle, Walk}

var state: State = State.Idle

@onready var _sprite = $Sprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_state(State.Idle)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func set_state(new_state: State) -> void:
		self.state = new_state
		
		match new_state:
			State.Idle:
				_sprite.play("Idle")
			State.Walk:
				_sprite.play("Walk")
