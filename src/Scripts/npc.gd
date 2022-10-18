extends CharacterBody3D


const VEL_SPEED = 3 #speed
const ROT_SPEED = 0.01 #rotation
const GRAVITY = 0.3 #gravity speed

var vel = Vector3() #velocity
var timer = 0 
var waiting

# Called when the node enters the scene tree for the first time.
func _ready(): #used from SkanerSoft's script
	randomize()
	waiting = 5
	Common.npc = self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var state = $AnimationPlayer.current_animation #state is determined as animation
	timer += delta
	
	if state == '939_Idle':
		if transform.origin.distance_to(Common.player.transform.origin) < 5.5:
			set_state('939_Running')
	
	
	elif state == '939_Running':
		if transform.origin.distance_to(Common.player.transform.origin) >= 5.5:
			set_state('939_Idle')
		elif transform.origin.distance_to(Common.player.transform.origin) < 2:
			set_state('939_Attack1')
		var to_player = position.direction_to(Common.player.position)
		set_velocity(to_player * VEL_SPEED)
		move_and_slide()
		self.look_at(Common.player.position, Vector3.UP)
	
	elif state == '939_Attack1':
		if transform.origin.distance_to(Common.player.transform.origin) >= 2:
			set_state('939_Running')
		Common.player.damage(0.34)

func set_state(s): #animation state (from SkanerSoft)
	if $AnimationPlayer.current_animation == s:
		return
	$AnimationPlayer.play(s, 0.3)
	timer = 0
