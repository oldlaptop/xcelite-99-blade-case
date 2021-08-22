include <common.scad>

module xcelite_99_blade_case_cap(
	no_blades = no_blades_def,
	blade_base_dia = blade_base_dia_def,
	/*
	 * wingspan: max distance from one wing's outer surface to the other:
	 *
	 *      ___
	 *  ___/ ^ \_______
	 * |___  |  _______--------
	 *     \_v_/
	 */
	blade_wingspan = blade_wingspan_def,
	blade_wing_thickness = blade_wing_thickness_def,
	// 0 is wingtip-to-wingtip, 90 is flat-to-flat.
	blade_angle = blade_angle_def,
	socket_clearance = socket_clearance_def,
	tool_spacing = tool_spacing_def,

	thickness = cap_thickness,
	height = blade_overall_length_def - (socket_depth_def - cap_overlap) + 0.125,
	clearance = cap_clearance,
	// switch to 'true' to make a solid block printable in vase mode
	solid = false,
	followthrough = 0.01
)
{
	slop = 2 * clearance;
	walls = 2 * thickness;
	width = no_blades * (tool_spacing + socket_width(blade_base_dia, blade_wingspan, blade_angle) + 2 * socket_clearance) + tool_spacing + slop;
	depth = 2 * tool_spacing + socket_height(blade_base_dia, blade_wingspan, blade_angle) + 2 * socket_clearance + slop;

	difference()
	{
		cube([width + walls, depth + walls, height + thickness]);
		if (!solid)
		{
			translate([thickness, thickness, -followthrough])
			{
				cube([width, depth, height + followthrough]);
			}
		}
	}
}

xcelite_99_blade_case_cap(solid = true);
