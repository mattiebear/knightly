extends CharacterBody2D

enum State {Idle, Walk}

var state: State = State.Idle
var speed: int = 200
var target = position

@onready var _sprite = $Sprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_state(State.Idle)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _physics_process(_delta: float) -> void:
	match state:
		State.Walk:
			velocity = position.direction_to(target) * speed
			_sprite.flip_h = velocity.x < 0
			
			if position.distance_to(target) > 10:
				move_and_slide()
			else:
				set_state(State.Idle)


func _input(event):
	if event.is_action_pressed(&"right_click"):
		target = get_global_mouse_position()
		set_state(State.Walk)


func set_state(new_state: State) -> void:
		self.state = new_state
		
		match new_state:
			State.Idle:
				_sprite.play("Idle")
			State.Walk:
				_sprite.play("Walk")
