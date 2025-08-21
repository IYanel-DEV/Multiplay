@tool
extends EditorPlugin

var toolbar_button: Button
var multiplay_window: MultiPlayWindow

func _enter_tree():
	# Create the toolbar button
	toolbar_button = Button.new()
	toolbar_button.text = "🎮 MultiPlay"
	toolbar_button.tooltip_text = "Launch multiple game instances for multiplayer testing"
	toolbar_button.pressed.connect(_open_multiplay_window)
	
	# Style the toolbar button to match Godot's theme
	var button_style = StyleBoxFlat.new()
	button_style.bg_color = Color(0.4, 0.2, 0.8, 0.8)
	button_style.set_corner_radius_all(6)
	button_style.border_width_bottom = 1
	button_style.border_color = Color(0.3, 0.1, 0.6)
	toolbar_button.add_theme_stylebox_override("normal", button_style)
	
	var hover_style = StyleBoxFlat.new()
	hover_style.bg_color = Color(0.5, 0.3, 0.9, 0.9)
	hover_style.set_corner_radius_all(6)
	hover_style.border_width_bottom = 1
	hover_style.border_color = Color(0.4, 0.2, 0.7)
	toolbar_button.add_theme_stylebox_override("hover", hover_style)
	
	toolbar_button.add_theme_color_override("font_color", Color(0.95, 0.9, 1.0))
	toolbar_button.add_theme_font_size_override("font_size", 12)
	
	# Add to the main toolbar (top right area)
	add_control_to_container(CONTAINER_TOOLBAR, toolbar_button)

func _exit_tree():
	# Clean up
	if toolbar_button:
		remove_control_from_container(CONTAINER_TOOLBAR, toolbar_button)
		toolbar_button = null
	
	if multiplay_window and is_instance_valid(multiplay_window):
		multiplay_window.queue_free()
		multiplay_window = null

func _open_multiplay_window():
	# Close existing window if it exists
	if multiplay_window and is_instance_valid(multiplay_window):
		multiplay_window.queue_free()
	
	# Create new MultiPlay window
	multiplay_window = MultiPlayWindow.new()
	
	# Add to the scene tree so it can be displayed
	EditorInterface.get_base_control().add_child(multiplay_window)
	
	# Show the window
	multiplay_window.popup_centered()
	print("MultiPlay: Window opened successfully!")
