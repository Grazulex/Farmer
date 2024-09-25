extends CharacterBody2D

var current_states = player_states.MOVE
enum player_states {MOVE, AXE}
var input_movement = Vector2.ZERO
var direction = Vector2.ZERO

@export var speed = 40

# Called when the node enters the scene tree for the first time.
func _ready():
	direction = Vector2(0, 1)


func _physics_process(delta):
	#move()
	#update_move_anim()
	
	match current_states:
		player_states.MOVE:
			move()
		player_states.AXE:
			axe()

func move():
	input_movement = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if input_movement != Vector2.ZERO:
		update_move_anim()
		velocity = input_movement * speed
		$Axe/CollisionShape2D.disabled = true
		
	if input_movement == Vector2.ZERO:
		update_move_anim()
		velocity = Vector2.ZERO
		$Axe/CollisionShape2D.disabled = true
		
	if Input.is_action_just_pressed("ui_axe"):
		current_states = player_states.AXE
		
	move_and_slide()
	
func axe():
	update_axe_anim()
	
func axe_finish():
	current_states = player_states.MOVE
	
func update_move_anim():
	if input_movement != Vector2.ZERO:
		$Idle.hide()
		$Axe2.hide()
		$Walk.show()
		if Input.is_action_pressed("ui_right"):
			direction = Vector2(1, 0)
			$anim.play('WalkRight')
		if Input.is_action_pressed("ui_left"):
			direction = Vector2(-1, 0)
			$anim.play("WalkLeft")
		if Input.is_action_pressed("ui_up"):
			direction = Vector2(0, -1)
			$anim.play("WalkUp")
		if Input.is_action_just_pressed("ui_down"):
			direction = Vector2(0, 1)
			$anim.play("WalkDown")
			
	if input_movement == Vector2.ZERO:
		$Walk.hide()
		$Axe2.hide()
		$Idle.show()
		if direction.x > 0 :
			$anim.play("IdleRight")
		if direction.x < 0:
			$anim.play("IdleLeft")
		if direction.y > 0:
			$anim.play("IdleDown")
		if direction.y < 0:
			$anim.play("IdleUp")

func update_axe_anim():
	$Walk.hide()
	$Axe2.show()
	$Idle.hide()	
	if direction.x > 0 :
		$anim.play("AxeRight")
	if direction.x < 0:
		$anim.play("AxeLeft")
	if direction.y > 0:
		$anim.play("AxeDown")
	if direction.y < 0:
		$anim.play("AxeUp")	

