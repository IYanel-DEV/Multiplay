@tool
extends Window
class_name MultiPlayWindow

# Core components
var instance_count_spin: SpinBox
var running_processes = []
var status_label: Label
var launch_button: Button
var close_all_button: Button
var particle_timer: Timer

# UI components
var ui_builder: MultiPlayUI
var process_manager: MultiPlayProcessManager

func _init():
	# Initialize components
	ui_builder = MultiPlayUI.new()
	process_manager = MultiPlayProcessManager.new()
	
	# Setup window
	_setup_window()
	
	# Call setup after the window is ready
	call_deferred("_setup_ui")
	call_deferred("_setup_animations")

func _setup_window():
	# Restore default window with standard title bar
	title = "MultiPlay - Multiplayer Test Runner"
	borderless = false  # Enable default window decorations
	unresizable = false
	always_on_top = false
	min_size = Vector2i(700, 600)
	size = Vector2i(700, 600)
	
	# Remove transparent flag
	set_flag(Window.FLAG_TRANSPARENT, false)
	
	# Connect window close signal
	close_requested.connect(_on_window_close_requested)
	
	# Style the window background (without the top corners since we have a title bar)
	ui_builder.style_window_background(self)

func _setup_ui():
	# Setup main UI
	var controls = ui_builder.setup_main_ui(self)
	
	# Store references to key controls
	instance_count_spin = controls.instance_count_spin
	status_label = controls.status_label
	launch_button = controls.launch_button
	close_all_button = controls.close_all_button
	
	# Connect button signals
	launch_button.pressed.connect(_launch_instances)
	close_all_button.pressed.connect(_close_all_instances)

func _setup_animations():
	# Setup floating animation timer
	particle_timer = Timer.new()
	add_child(particle_timer)
	particle_timer.wait_time = 0.05
	particle_timer.autostart = true
	particle_timer.timeout.connect(_animate_elements)

var animation_time = 0.0
func _animate_elements():
	animation_time += 0.05
	
	# Animate title icon with gentle rotation
	var icon = find_child("IconLabel", true, false)
	if icon:
		var rotation_angle = sin(animation_time * 1.5) * 0.1
		icon.rotation = rotation_angle
	
	# Pulse effect for status icon
	var status_icon = find_child("StatusIcon", true, false)
	if status_icon:
		var scale_factor = 1.0 + sin(animation_time * 2.0) * 0.05
		status_icon.scale = Vector2(scale_factor, scale_factor)
	
	# Purple glow animation for subtitle
	var subtitle = find_child("SubtitleLabel", true, false)
	if subtitle:
		var alpha = 0.8 + sin(animation_time * 1.2) * 0.1
		var color = Color(0.8, 0.7, 0.95, alpha)
		subtitle.add_theme_color_override("font_color", color)

func _launch_instances():
	if not instance_count_spin:
		_update_status("❌ Error: SpinBox not found!", Color(1.0, 0.4, 0.4))
		return
	
	var count = int(instance_count_spin.value)
	_update_status("🚀 Launching " + str(count) + " instances...", Color(0.9, 0.7, 0.9))
	
	# Disable launch button during launch
	launch_button.disabled = true
	launch_button.text = "🔄 Launching..."
	
	# Use process manager to launch instances
	running_processes = await process_manager.launch_instances(count, _update_status)
	
	# Re-enable button
	launch_button.disabled = false
	launch_button.text = "🚀 Launch Test Instances"
	close_all_button.disabled = false
	
	if running_processes.size() > 0:
		_update_status("✅ Successfully launched " + str(running_processes.size()) + " instances!", Color(0.7, 0.5, 0.9))
	else:
		_update_status("❌ Failed to launch any instances", Color(1.0, 0.4, 0.4))

func _close_all_instances():
	if running_processes.is_empty():
		_update_status("🤷 No instances to close", Color(0.7, 0.6, 0.8))
		return
	
	_update_status("🛑 Closing all instances...", Color(0.9, 0.5, 0.8))
	close_all_button.disabled = true
	close_all_button.text = "🔄 Closing..."
	
	var closed_count = process_manager.close_all_instances(running_processes)
	running_processes.clear()
	
	close_all_button.disabled = true
	close_all_button.text = "🛑 Close All"
	
	_update_status("✅ Closed " + str(closed_count) + " instances", Color(0.7, 0.5, 0.9))

func _close_panel():
	# Close all instances before closing the panel
	if not running_processes.is_empty():
		_close_all_instances()
		await get_tree().create_timer(1.0).timeout
	
	queue_free()

func _on_window_close_requested():
	_close_panel()

func _update_status(message: String, color: Color = Color(0.8, 0.6, 0.9)):
	if status_label:
		status_label.text = message
		status_label.add_theme_color_override("font_color", color)
		
		# Update status icon based on message type with purple theme
		var status_icon = find_child("StatusIcon", true, false)
		if status_icon:
			if "Launching" in message or "🚀" in message:
				status_icon.text = "🚀"
			elif "✅" in message:
				status_icon.text = "💜"
			elif "🛑" in message or "Closing" in message:
				status_icon.text = "🛑"
			elif "❌" in message or "Failed" in message:
				status_icon.text = "❌"
			elif "🤷" in message:
				status_icon.text = "🤷"
			else:
				status_icon.text = "💜"
	
	print("MultiPlay: " + message)

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		_on_window_close_requested()
