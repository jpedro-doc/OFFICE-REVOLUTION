extends Label

@onready var dissapear_timer: Timer = $dissapearTimer
@onready var appear_timer: Timer = $appearTimer
@export var blink_timer:float = 0.3
@export var blick_timer_faster:float = 0.05

func _ready() -> void:
	dissapear_timer.wait_time = blink_timer
	appear_timer.wait_time = blink_timer
	dissapear_timer.timeout.connect(blink)

func blink() -> void:
	self.visible = false
	appear_timer.start()
	await appear_timer.timeout
	self.visible = true
	dissapear_timer.start()
	
func blink_faster() -> void:
	dissapear_timer.wait_time = blick_timer_faster
	appear_timer.wait_time = blick_timer_faster
	
	
