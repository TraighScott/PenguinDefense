extends CharacterBody2D


@export var speed := 600
var direction := Vector2(0,1)


func _ready() -> void:
	direction = get_launch_direction()
	await get_tree().create_timer(3).timeout
	queue_free()


func _physics_process(delta: float) -> void:
	move_and_collide(direction * delta * speed)


func get_launch_direction():
	var tower = get_parent()
	if tower == null:
		return
	else:
		return Vector2(1,0).rotated(tower.global_rotation + TAU)
