@tool
extends RefCounted
class_name MultiPlayProcessManager

func launch_instances(count: int, status_callback: Callable) -> Array:
	var running_processes = []
	
	# Clear any existing processes
	running_processes.clear()
	
	# Get the current project executable path
	var executable_path = OS.get_executable_path()
	var project_path = ProjectSettings.globalize_path("res://")
	
	for i in range(count):
		# Launch each instance with the project path
		var args = ["--path", project_path]
		var pid = OS.create_process(executable_path, args)
		
		if pid > 0:
			running_processes.append(pid)
			print("MultiPlay: Launched instance " + str(i + 1) + " with PID: " + str(pid))
			status_callback.call("🚀 Launching instance " + str(i + 1) + "/" + str(count), Color(0.9, 0.7, 0.9))
		else:
			print("MultiPlay: Failed to launch instance " + str(i + 1))
			status_callback.call("❌ Failed to launch instance " + str(i + 1), Color(1.0, 0.4, 0.4))
		
		# Small delay between launches
		await Engine.get_main_loop().create_timer(0.5).timeout
	
	return running_processes

func close_all_instances(running_processes: Array) -> int:
	var closed_count = 0
	
	for pid in running_processes:
		if OS.kill(pid) == OK:
			closed_count += 1
			print("MultiPlay: Closed instance with PID: " + str(pid))
		else:
			print("MultiPlay: Failed to close instance with PID: " + str(pid))
	
	return closed_count
