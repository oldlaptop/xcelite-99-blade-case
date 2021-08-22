include <MCAD/constants.scad>

no_blades_def = 6;
blade_base_dia_def = 0.280;
blade_wingspan_def = 0.410; // See xcelite-99-blade-case.scad
blade_wing_thickness_def = 0.110;
blade_angle_def = 90; // 0 for minimum depth, 90 for minimum width
blade_overall_length_def = 5;
wall_thickness = 0.075;

// Increase for tools with heads bigger than the handle's socket.
tool_spacing_def = wall_thickness;


cap_thickness = 0.45 / mm_per_inch;
cap_clearance = 0.004;
cap_overlap = 1;

socket_clearance_def = 0.006;
socket_depth_def = 1.5;

function socket_width(blade_base_dia, blade_wingspan, blade_angle)
	= max(blade_base_dia, cos(blade_angle) * blade_wingspan);

function socket_height(blade_base_dia, blade_wingspan, blade_angle)
	= max(blade_base_dia, sin(blade_angle) * blade_wingspan);
