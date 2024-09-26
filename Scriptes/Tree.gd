extends StaticBody2D

var quantity_hit = 0

@export var quantity_before_fall:int = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	$Shake.hide()
	$Fall.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_hitbox_area_entered(area):
	if area.name == "Axe":
		quantity_hit = quantity_hit + 1
		if quantity_hit == quantity_before_fall:
		#queue_free()
			$Shake.hide()
			$Fall.show()
			$anim.play("Fall")
			quantity_hit = 0
		else:
			$Fall.hide()
			$Shake.show()
			$anim.play("Shake")
