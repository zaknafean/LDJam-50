extends Node2D

class_name BaseLevel, "res://assets/icons/theater-curtains.png"

onready var player := $Player
onready var camera = $Player/Camera2D
onready var playerLine := $Line2D
onready var statLabel := $CanvasLayer/StatsLabel
onready var tilemap : TileMap = $Navigation2D/TileMap

var currentEvent : Interactable = null
var queuedEvent : Interactable = null

var gapMargin = 1

onready var nav2d = $Navigation2D
var isHighlightAll = false
export (bool) var freezeInput = false


# Called when the node enters the scene tree for the first time.
func _ready():
	var clickables = $Interactables.get_children()
	var _err = player.connect("arrived", self, '_on_player_arrived')
	
	for event in clickables:
		_err = event.connect('mouse_entered', self, '_on_Area2D_mouse_entered', [event])
		_err = event.connect('mouse_exited', self, '_on_Area2D_mouse_exited', [event])
		_err = event.connect('reroute_player', self, '_on_reroute_player')
	
	isHighlightAll = false
	tilemap.modulate = Color(.5, .5, .5, 1)


func _on_Area2D_mouse_entered(clickable):
	if clickable != currentEvent:
		_on_Area2D_mouse_exited(currentEvent)
	if clickable.canClick:
		currentEvent = clickable
	if clickable.canHighlight:
		currentEvent.sprite.get_material().set_shader_param("brightness", 2)


func _on_Area2D_mouse_exited(clickable):
	if clickable == null:
		return
	if currentEvent == clickable:
		if clickable.canHighlight:
			clickable.sprite.get_material().set_shader_param("brightness", 1)
			currentEvent = null


func toggleHighlightAll():
	var clickables = $Interactables.get_children()
	
	for event in clickables:
		if event == currentEvent:
			continue
		if isHighlightAll and event.canHighlight:
			event.sprite.get_material().set_shader_param("brightness", 2)
		elif event.canHighlight:
			event.sprite.get_material().set_shader_param("brightness", 1)
		
	isHighlightAll = !isHighlightAll


# Called if an Interactable reroutres player to their interaction point
func _on_reroute_player(event : Interactable, lockControl : bool = false):
	var path = nav2d.get_simple_path(player.global_position, event.interactionPosition)
	playerLine.points = path
	playerLine.default_color =  Color( 0.84, 0.9, .13, 1 )
	player.path = path
	
	if !event.reroute_after_dialog:
		queuedEvent = event
	else:
		var _retVal = process_event(event)
	
	if lockControl:
		freezeInput = true


func _on_player_arrived():
	if queuedEvent == null:
		pass
	else:
		var _isComplete = process_event(queuedEvent)
		if queuedEvent.facing_direction != 'default':
			player.sprite_dir = queuedEvent.facing_direction
			player.anim_switch('idle')
		queuedEvent = null
		
	if freezeInput:
		freezeInput = false
		
	playerLine.points = []


func process_event(event : Interactable) -> bool: 
	var eventResult = false
	
	if player.global_position.distance_to(event.interactionPosition) < gapMargin or event.reroute_after_dialog:
		event.runEvent()
		eventResult = true
		
	return eventResult

func _process(_delta):
	statLabel.text = str('Alert: ', Settings.alertnessValue, '\n', 'Sanity: ', Settings.sanityValue, '\n', 'Score: ', Settings.score);
	
	if Settings.sanityValue <= 0 or Settings.alertnessValue <= 0:
		print('you have lost')

func _unhandled_input(event):
	if freezeInput or Settings.curGameState != Settings.GAME_STATES.PLAY:
		return
		
	if event.is_echo():
		return
		
	if event.is_action_pressed("ui_secondaryclick"):
		toggleHighlightAll()
		return
	
	if event.is_action_pressed("ui_primaryclick"):
		if currentEvent != null:
			var isComplete = process_event(currentEvent)
			
			if isComplete:
				return
			else:
				_on_reroute_player(currentEvent)
		elif event.button_index == BUTTON_LEFT and event.pressed:
			var path = nav2d.get_simple_path(player.global_position, get_global_mouse_position())
			playerLine.points = path
			playerLine.default_color =  Color( 0.13, 0.66, .9, 1 )
			player.path = path
