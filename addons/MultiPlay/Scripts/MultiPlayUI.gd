@tool
extends RefCounted
class_name MultiPlayUI

# Animation variables
var animation_time = 0.0

# UI control references structure
class UIControls:
	var instance_count_spin: SpinBox
	var status_label: Label
	var launch_button: Button
	var close_all_button: Button

func style_window_background(window: Window):
	# Style the window directly instead of using a blocking panel
	var window_panel = Panel.new()
	window.add_child(window_panel)
	window_panel.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	window_panel.z_index = -100  # Put it way behind everything
	window_panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	var glass_bg = StyleBoxFlat.new()
	glass_bg.bg_color = Color(0.08, 0.05, 0.15, 0.95)
	# Set all corners to 20
	glass_bg.corner_radius_top_left = 5
	glass_bg.corner_radius_top_right = 5
	glass_bg.corner_radius_bottom_left = 5
	glass_bg.corner_radius_bottom_right = 5
	glass_bg.border_width_left = 2
	glass_bg.border_width_right = 2
	glass_bg.border_width_top = 2
	glass_bg.border_width_bottom = 2
	glass_bg.border_color = Color(0.5, 0.3, 0.8, 0.4)
	glass_bg.shadow_color = Color(0.2, 0.1, 0.4, 0.8)
	glass_bg.shadow_size = 20
	glass_bg.shadow_offset = Vector2(0, 10)
	window_panel.add_theme_stylebox_override("panel", glass_bg)

func setup_main_ui(window: Window) -> UIControls:
	# Main container with padding - this should be the main interactive container
	var main_container = MarginContainer.new()
	window.add_child(main_container)
	main_container.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	main_container.add_theme_constant_override("margin_left", 20)
	main_container.add_theme_constant_override("margin_right", 20)
	main_container.add_theme_constant_override("margin_top", 35)  # Leave space for title bar
	main_container.add_theme_constant_override("margin_bottom", 20)
	# Ensure main container allows mouse events
	main_container.mouse_filter = Control.MOUSE_FILTER_PASS
	
	# Main vertical container
	var main_vbox = VBoxContainer.new()
	main_container.add_child(main_vbox)
	main_vbox.add_theme_constant_override("separation", 20)
	main_vbox.mouse_filter = Control.MOUSE_FILTER_PASS
	
	# Create UI sections and collect controls
	var controls = UIControls.new()
	
	_create_header(main_vbox)
	_create_config_section(main_vbox, controls)
	_create_status_section(main_vbox, controls)
	_create_action_buttons(main_vbox, controls)
	
	return controls

func _create_header(parent: VBoxContainer):
	var header_panel = Panel.new()
	parent.add_child(header_panel)
	header_panel.custom_minimum_size.y = 120
	# Allow mouse events to pass through header panel
	header_panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	# Purple gradient header background
	var header_bg = StyleBoxFlat.new()
	header_bg.bg_color = Color(0.15, 0.1, 0.3, 0.9)
	# Set all corners to 16
	header_bg.corner_radius_top_left = 16
	header_bg.corner_radius_top_right = 16
	header_bg.corner_radius_bottom_left = 16
	header_bg.corner_radius_bottom_right = 16
	header_bg.border_width_top = 2
	header_bg.border_width_bottom = 1
	header_bg.border_color = Color(0.6, 0.4, 1.0, 0.7)
	header_bg.shadow_color = Color(0.3, 0.2, 0.6, 0.5)
	header_bg.shadow_size = 10
	header_bg.shadow_offset = Vector2(0, 4)
	header_panel.add_theme_stylebox_override("panel", header_bg)
	
	var header_vbox = VBoxContainer.new()
	header_panel.add_child(header_vbox)
	header_vbox.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	header_vbox.add_theme_constant_override("separation", 8)
	header_vbox.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	# Main title with purple glow
	var title_container = HBoxContainer.new()
	header_vbox.add_child(title_container)
	title_container.alignment = BoxContainer.ALIGNMENT_CENTER
	title_container.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	var icon_label = Label.new()
	title_container.add_child(icon_label)
	icon_label.text = "🎮"
	icon_label.add_theme_font_size_override("font_size", 36)
	icon_label.name = "IconLabel"
	icon_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	var title_label = Label.new()
	title_container.add_child(title_label)
	title_label.text = " MultiPlayer Test Runner"
	title_label.add_theme_font_size_override("font_size", 28)
	title_label.add_theme_color_override("font_color", Color(0.95, 0.9, 1.0))
	title_label.add_theme_color_override("font_shadow_color", Color(0.4, 0.2, 0.8, 0.9))
	title_label.add_theme_constant_override("shadow_offset_x", 2)
	title_label.add_theme_constant_override("shadow_offset_y", 2)
	title_label.name = "TitleLabel"
	title_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	# Animated subtitle with purple theme
	var subtitle = Label.new()
	header_vbox.add_child(subtitle)
	subtitle.text = "✨ Launch multiple instances for seamless multiplayer testing ✨"
	subtitle.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	subtitle.add_theme_font_size_override("font_size", 15)
	subtitle.add_theme_color_override("font_color", Color(0.8, 0.7, 0.95, 0.9))
	subtitle.name = "SubtitleLabel"
	subtitle.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _create_config_section(parent: VBoxContainer, controls: UIControls):
	# Purple card-style configuration
	var config_card = Panel.new()
	parent.add_child(config_card)
	config_card.custom_minimum_size.y = 140
	# Allow mouse events to pass through to children
	config_card.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	var card_bg = StyleBoxFlat.new()
	card_bg.bg_color = Color(0.12, 0.08, 0.2, 0.8)
	# Set all corners to 15
	card_bg.corner_radius_top_left = 15
	card_bg.corner_radius_top_right = 15
	card_bg.corner_radius_bottom_left = 15
	card_bg.corner_radius_bottom_right = 15
	card_bg.border_width_left = 1
	card_bg.border_width_top = 1
	card_bg.border_color = Color(0.4, 0.25, 0.6, 0.5)
	card_bg.shadow_color = Color(0.2, 0.1, 0.4, 0.4)
	card_bg.shadow_size = 6
	card_bg.shadow_offset = Vector2(0, 3)
	config_card.add_theme_stylebox_override("panel", card_bg)
	
	var card_margin = MarginContainer.new()
	config_card.add_child(card_margin)
	card_margin.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	card_margin.add_theme_constant_override("margin_left", 25)
	card_margin.add_theme_constant_override("margin_right", 25)
	card_margin.add_theme_constant_override("margin_top", 20)
	card_margin.add_theme_constant_override("margin_bottom", 20)
	# Ensure margin container allows mouse events
	card_margin.mouse_filter = Control.MOUSE_FILTER_PASS
	
	var config_vbox = VBoxContainer.new()
	card_margin.add_child(config_vbox)
	config_vbox.add_theme_constant_override("separation", 15)
	config_vbox.mouse_filter = Control.MOUSE_FILTER_PASS
	
	# Section title with purple theme
	var section_title = Label.new()
	config_vbox.add_child(section_title)
	section_title.text = "🎯 Test Configuration"
	section_title.add_theme_font_size_override("font_size", 18)
	section_title.add_theme_color_override("font_color", Color(0.9, 0.8, 1.0))
	section_title.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	# Instance count with purple styling
	var count_container = HBoxContainer.new()
	config_vbox.add_child(count_container)
	count_container.add_theme_constant_override("separation", 20)
	count_container.mouse_filter = Control.MOUSE_FILTER_PASS
	
	# Left side - label and icon
	var left_side = HBoxContainer.new()
	count_container.add_child(left_side)
	left_side.add_theme_constant_override("separation", 12)
	left_side.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	var players_icon = Label.new()
	left_side.add_child(players_icon)
	players_icon.text = "👥"
	players_icon.add_theme_font_size_override("font_size", 28)
	players_icon.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	var count_label = Label.new()
	left_side.add_child(count_label)
	count_label.text = "Number of Players:"
	count_label.add_theme_font_size_override("font_size", 16)
	count_label.add_theme_color_override("font_color", Color(0.85, 0.75, 0.95))
	count_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	count_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	# Right side - spinner with explicit mouse handling
	controls.instance_count_spin = SpinBox.new()
	count_container.add_child(controls.instance_count_spin)
	controls.instance_count_spin.min_value = 2
	controls.instance_count_spin.max_value = 8
	controls.instance_count_spin.value = 2
	controls.instance_count_spin.step = 1
	controls.instance_count_spin.custom_minimum_size = Vector2(150, 45)
	controls.instance_count_spin.editable = true
	# Ensure SpinBox receives mouse events
	controls.instance_count_spin.mouse_filter = Control.MOUSE_FILTER_PASS
	
	# Style the SpinBox properly
	_style_spinbox(controls.instance_count_spin)

func _style_spinbox(spinbox: SpinBox):
	# Style the line edit part of the spinbox
	var line_edit = spinbox.get_line_edit()
	if line_edit:
		# Ensure line edit can receive mouse events
		line_edit.mouse_filter = Control.MOUSE_FILTER_PASS
		
		var spin_normal = StyleBoxFlat.new()
		spin_normal.bg_color = Color(0.15, 0.1, 0.25, 0.9)
		# Set all corners to 8
		spin_normal.corner_radius_top_left = 8
		spin_normal.corner_radius_top_right = 8
		spin_normal.corner_radius_bottom_left = 8
		spin_normal.corner_radius_bottom_right = 8
		spin_normal.border_width_left = 1
		spin_normal.border_width_right = 1
		spin_normal.border_width_top = 1
		spin_normal.border_width_bottom = 1
		spin_normal.border_color = Color(0.5, 0.3, 0.8, 0.6)
		line_edit.add_theme_stylebox_override("normal", spin_normal)
		line_edit.add_theme_stylebox_override("focus", spin_normal)
		line_edit.add_theme_color_override("font_color", Color(0.95, 0.9, 1.0))
		line_edit.add_theme_font_size_override("font_size", 16)

func _create_status_section(parent: VBoxContainer, controls: UIControls):
	var status_card = Panel.new()
	parent.add_child(status_card)
	status_card.custom_minimum_size.y = 80
	status_card.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	var status_bg = StyleBoxFlat.new()
	status_bg.bg_color = Color(0.08, 0.05, 0.12, 0.8)
	# Set all corners to 12
	status_bg.corner_radius_top_left = 12
	status_bg.corner_radius_top_right = 12
	status_bg.corner_radius_bottom_left = 12
	status_bg.corner_radius_bottom_right = 12
	status_bg.border_width_left = 3
	status_bg.border_color = Color(0.5, 0.3, 0.8, 0.7)
	status_bg.shadow_color = Color(0.2, 0.1, 0.4, 0.4)
	status_bg.shadow_size = 4
	status_card.add_theme_stylebox_override("panel", status_bg)
	
	var status_margin = MarginContainer.new()
	status_card.add_child(status_margin)
	status_margin.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	status_margin.add_theme_constant_override("margin_left", 20)
	status_margin.add_theme_constant_override("margin_right", 20)
	status_margin.add_theme_constant_override("margin_top", 15)
	status_margin.add_theme_constant_override("margin_bottom", 15)
	status_margin.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	var status_hbox = HBoxContainer.new()
	status_margin.add_child(status_hbox)
	status_hbox.add_theme_constant_override("separation", 12)
	status_hbox.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	var status_icon = Label.new()
	status_hbox.add_child(status_icon)
	status_icon.text = "💜"
	status_icon.add_theme_font_size_override("font_size", 24)
	status_icon.name = "StatusIcon"
	status_icon.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	controls.status_label = Label.new()
	status_hbox.add_child(controls.status_label)
	controls.status_label.text = "Ready to launch multiplayer test! 🚀"
	controls.status_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	controls.status_label.add_theme_color_override("font_color", Color(0.8, 0.6, 0.9))
	controls.status_label.add_theme_font_size_override("font_size", 15)
	controls.status_label.name = "StatusLabel"
	controls.status_label.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _create_action_buttons(parent: VBoxContainer, controls: UIControls):
	var button_section = VBoxContainer.new()
	parent.add_child(button_section)
	button_section.add_theme_constant_override("separation", 12)
	# Ensure button section receives mouse events
	button_section.mouse_filter = Control.MOUSE_FILTER_PASS
	
	# Primary purple launch button
	controls.launch_button = _create_hero_button("🚀 Launch Test Instances", Color(0.4, 0.2, 0.8))
	button_section.add_child(controls.launch_button)
	controls.launch_button.custom_minimum_size.y = 60
	
	# Secondary purple buttons
	var secondary_row = HBoxContainer.new()
	button_section.add_child(secondary_row)
	secondary_row.add_theme_constant_override("separation", 12)
	secondary_row.mouse_filter = Control.MOUSE_FILTER_PASS
	
	controls.close_all_button = _create_secondary_button("🛑 Close All", Color(0.8, 0.3, 0.6))
	secondary_row.add_child(controls.close_all_button)
	controls.close_all_button.disabled = true

func _create_hero_button(text: String, base_color: Color) -> Button:
	var btn = Button.new()
	btn.text = text
	btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	
	# Explicitly ensure button can receive all mouse events
	btn.mouse_filter = Control.MOUSE_FILTER_PASS
	btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	
	# Purple hero button with gradient and glow
	var normal_style = StyleBoxFlat.new()
	normal_style.bg_color = base_color
	# Set all corners to 15
	normal_style.corner_radius_top_left = 15
	normal_style.corner_radius_top_right = 15
	normal_style.corner_radius_bottom_left = 15
	normal_style.corner_radius_bottom_right = 15
	normal_style.border_width_bottom = 4
	normal_style.border_color = base_color.darkened(0.4)
	normal_style.shadow_color = base_color.lightened(0.3)
	normal_style.shadow_color.a = 0.7
	normal_style.shadow_size = 10
	normal_style.shadow_offset = Vector2(0, 3)
	btn.add_theme_stylebox_override("normal", normal_style)
	
	# Enhanced purple hover state
	var hover_style = StyleBoxFlat.new()
	hover_style.bg_color = base_color.lightened(0.2)
	# Set all corners to 15
	hover_style.corner_radius_top_left = 15
	hover_style.corner_radius_top_right = 15
	hover_style.corner_radius_bottom_left = 15
	hover_style.corner_radius_bottom_right = 15
	hover_style.border_width_bottom = 4
	hover_style.border_color = base_color.darkened(0.2)
	hover_style.shadow_color = base_color.lightened(0.5)
	hover_style.shadow_color.a = 0.9
	hover_style.shadow_size = 15
	hover_style.shadow_offset = Vector2(0, 4)
	btn.add_theme_stylebox_override("hover", hover_style)
	
	# Purple pressed state
	var pressed_style = StyleBoxFlat.new()
	pressed_style.bg_color = base_color.darkened(0.3)
	# Set all corners to 15
	pressed_style.corner_radius_top_left = 15
	pressed_style.corner_radius_top_right = 15
	pressed_style.corner_radius_bottom_left = 15
	pressed_style.corner_radius_bottom_right = 15
	pressed_style.border_width_top = 2
	pressed_style.border_color = base_color.darkened(0.5)
	btn.add_theme_stylebox_override("pressed", pressed_style)
	
	btn.add_theme_color_override("font_color", Color(0.95, 0.9, 1.0))
	btn.add_theme_font_size_override("font_size", 18)
	btn.add_theme_color_override("font_shadow_color", Color(0.2, 0.1, 0.4, 0.8))
	btn.add_theme_constant_override("shadow_offset_x", 2)
	btn.add_theme_constant_override("shadow_offset_y", 2)
	
	return btn

func _create_secondary_button(text: String, base_color: Color) -> Button:
	var btn = Button.new()
	btn.text = text
	btn.custom_minimum_size.y = 45
	btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	
	# Explicitly ensure button can receive all mouse events
	btn.mouse_filter = Control.MOUSE_FILTER_PASS
	btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	
	# Purple secondary button
	var normal_style = StyleBoxFlat.new()
	normal_style.bg_color = Color(base_color.r, base_color.g, base_color.b, 0.3)
	# Set all corners to 10
	normal_style.corner_radius_top_left = 10
	normal_style.corner_radius_top_right = 10
	normal_style.corner_radius_bottom_left = 10
	normal_style.corner_radius_bottom_right = 10
	normal_style.border_width_left = 1
	normal_style.border_width_right = 1
	normal_style.border_width_top = 1
	normal_style.border_width_bottom = 1
	normal_style.border_color = base_color.lightened(0.3)
	btn.add_theme_stylebox_override("normal", normal_style)
	
	# Purple hover effect
	var hover_style = StyleBoxFlat.new()
	hover_style.bg_color = Color(base_color.r, base_color.g, base_color.b, 0.5)
	# Set all corners to 10
	hover_style.corner_radius_top_left = 10
	hover_style.corner_radius_top_right = 10
	hover_style.corner_radius_bottom_left = 10
	hover_style.corner_radius_bottom_right = 10
	hover_style.border_width_left = 2
	hover_style.border_width_right = 2
	hover_style.border_width_top = 2
	hover_style.border_width_bottom = 2
	hover_style.border_color = base_color.lightened(0.3)
	hover_style.shadow_color = Color(base_color.r, base_color.g, base_color.b, 0.6)
	hover_style.shadow_size = 8
	btn.add_theme_stylebox_override("hover", hover_style)
	
	# Pressed effect
	var pressed_style = StyleBoxFlat.new()
	pressed_style.bg_color = base_color.darkened(0.3)
	# Set all corners to 10
	pressed_style.corner_radius_top_left = 10
	pressed_style.corner_radius_top_right = 10
	pressed_style.corner_radius_bottom_left = 10
	pressed_style.corner_radius_bottom_right = 10
	btn.add_theme_stylebox_override("pressed", pressed_style)
	
	# Text styling
	btn.add_theme_color_override("font_color", Color(0.95, 0.9, 1.0))
	btn.add_theme_font_size_override("font_size", 12)
	btn.add_theme_color_override("font_shadow_color", Color(0, 0, 0, 0.5))
	btn.add_theme_constant_override("shadow_offset_x", 1)
	btn.add_theme_constant_override("shadow_offset_y", 1)
	
	return btn

func _animate_elements():
	animation_time += 0.05
