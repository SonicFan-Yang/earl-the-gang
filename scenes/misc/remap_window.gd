extends Window

var key_pad_toggle := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process_unhandled_input(false)
	$up.grab_focus()

func _unhandled_input(event: InputEvent) -> void:
	
	for button : Button in get_children():
		if button != gui_get_focus_owner():
			button.focus_mode = button.FocusMode.FOCUS_NONE
			button.focus_behavior_recursive = button.FocusBehaviorRecursive.FOCUS_BEHAVIOR_DISABLED
	
	if key_pad_toggle == true:
	
		if event is InputEventJoypadMotion and round(abs(event.axis_value)) == 1 && (event.axis == 0 or event.axis == 1):
			
			gui_get_focus_owner().text = gui_get_focus_owner().name + "= a: " + str(event.axis) + ", " + str(round(event.axis_value))
			
			match gui_get_focus_owner().name:
				"up":
					InputMap.action_erase_events("ui_up")
					InputMap.action_add_event("ui_up", event)
				"down":
					InputMap.action_erase_events("ui_down")
					InputMap.action_add_event("ui_down", event)
				"left":
					InputMap.action_erase_events("ui_left")
					InputMap.action_add_event("ui_left", event)
				"right":
					InputMap.action_erase_events("ui_right")
					InputMap.action_add_event("ui_right", event)
				"jump":
					InputMap.action_erase_events("ui_accept")
					InputMap.action_add_event("ui_accept", event)
				"attack":
					InputMap.action_erase_events("ui_cancel")
					InputMap.action_add_event("ui_cancel", event)
				"run":
					InputMap.action_erase_events("ui_select")
					InputMap.action_add_event("ui_select", event)
			
			for button : Button in get_children():
				button.focus_mode = button.FocusMode.FOCUS_ALL
				button.focus_behavior_recursive = button.FocusBehaviorRecursive.FOCUS_BEHAVIOR_INHERITED
			gui_get_focus_owner().button_pressed = false
		
		if event is InputEventJoypadButton:
			
			gui_get_focus_owner().text = gui_get_focus_owner().name + "= " + event.as_text()
			for button : Button in get_children():
				button.focus_mode = button.FocusMode.FOCUS_ALL
				button.focus_behavior_recursive = button.FocusBehaviorRecursive.FOCUS_BEHAVIOR_INHERITED
			gui_get_focus_owner().button_pressed = false
		
	else:
	
		if event is InputEventKey:
			
			match gui_get_focus_owner().name:
				"up":
					InputMap.action_erase_events("ui_up")
					InputMap.action_add_event("ui_up", event)
				"down":
					InputMap.action_erase_events("ui_down")
					InputMap.action_add_event("ui_down", event)
				"left":
					InputMap.action_erase_events("ui_left")
					InputMap.action_add_event("ui_left", event)
				"right":
					InputMap.action_erase_events("ui_right")
					InputMap.action_add_event("ui_right", event)
				"jump":
					InputMap.action_erase_events("ui_accept")
					InputMap.action_add_event("ui_accept", event)
				"attack":
					InputMap.action_erase_events("ui_cancel")
					InputMap.action_add_event("ui_cancel", event)
				"run":
					InputMap.action_erase_events("ui_select")
					InputMap.action_add_event("ui_select", event)
			
			gui_get_focus_owner().text = gui_get_focus_owner().name + "= " + event.as_text_key_label()
			for button : Button in get_children():
				button.focus_mode = button.FocusMode.FOCUS_ALL
				button.focus_behavior_recursive = button.FocusBehaviorRecursive.FOCUS_BEHAVIOR_INHERITED
			gui_get_focus_owner().button_pressed = false

func _on_up_toggled(toggled_on: bool) -> void:
	if toggled_on:
		set_process_unhandled_input(true)
	else:
		set_process_unhandled_input(false)

func _on_down_toggled(toggled_on: bool) -> void:
	if toggled_on:
		set_process_unhandled_input(true)
	else:
		set_process_unhandled_input(false)

func _on_left_toggled(toggled_on: bool) -> void:
	if toggled_on:
		set_process_unhandled_input(true)
	else:
		set_process_unhandled_input(false)

func _on_right_toggled(toggled_on: bool) -> void:
	if toggled_on:
		set_process_unhandled_input(true)
	else:
		set_process_unhandled_input(false)

func _on_jump_toggled(toggled_on: bool) -> void:
	if toggled_on:
		set_process_unhandled_input(true)
	else:
		set_process_unhandled_input(false)

func _on_attack_toggled(toggled_on: bool) -> void:
	if toggled_on:
		set_process_unhandled_input(true)
	else:
		set_process_unhandled_input(false)

func _on_run_toggled(toggled_on: bool) -> void:
	if toggled_on:
		set_process_unhandled_input(true)
	else:
		set_process_unhandled_input(false)

func _on_key_pad_toggled(toggled_on: bool) -> void:
	key_pad_toggle = toggled_on
	if toggled_on:
		$key_pad.text = "Controller"
	else:
		$key_pad.text = "Keyboard"
