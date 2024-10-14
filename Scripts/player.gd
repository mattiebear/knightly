extends CharacterBody2D

enum State {Idle, Walk}

var state: State = State.Idle
var speed: int = 200
var target = position

@onready var _sprite = $Sprite
@onready var _navigation_agent = $NavigationAgent2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_state(State.Idle)

func _physics_process(_delta: float) -> void:
	match state:
		State.Walk:
			velocity = position.direction_to(_navigation_agent.get_next_path_position()) * speed
			_sprite.flip_h = velocity.x < 0
			
			if _navigation_agent.is_navigation_finished():
				set_state(State.Idle)
			else:
				move_and_slide()

func _input(event):
	if event.is_action_pressed(&"right_click"):
		_navigation_agent.target_position = event.global_position
		set_state(State.Walk)


func set_state(new_state: State) -> void:
		self.state = new_state
		
		match new_state:
			State.Idle:
				_sprite.play("Idle")
			State.Walk:
				_sprite.play("Walk")
