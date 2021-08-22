include <common.scad>

$fn = 128;

module xcelite_99_blade_socket(
	blade_base_dia,
	blade_wingspan,
	blade_wing_thickness,
	depth
)
{
	blade_base_rad = blade_base_dia / 2;
	translate([0, 0, depth / 2])
	{
		union()
		{
			cylinder(d = blade_base_dia, h = depth, center = true);
			cube([
				blade_wingspan,
				blade_wing_thickness,
				depth
			], center = true);
		}
	}
}

module xcelite_99_blade_case(
	no_blades = no_blades_def,
	// Increase for tools with heads bigger than the handle's socket.
	tool_spacing = tool_spacing_def,
	wall_z = wall_thickness,
	cap_inset_depth = cap_thickness + cap_clearance,
	cap_inset_height = cap_overlap,

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
	socket_depth = socket_depth_def,
	socket_clearance = 0.006,
	followthrough = 0.01
)
{
	slop = 2 * socket_clearance;
	swidth = socket_width(blade_base_dia, blade_wingspan, blade_angle) + slop;
	sheight = socket_height(blade_base_dia, blade_wingspan, blade_angle) + slop;
	bottom_sidewall = tool_spacing + cap_inset_depth;

	difference()
	{
		union()
		{
			if(cap_inset_height > 0)
			{
				translate([
					cap_inset_depth,
					cap_inset_depth,
					socket_depth + wall_z - cap_inset_height - followthrough
				])
				{
					cube([
						(swidth + tool_spacing) * no_blades + tool_spacing,
						sheight + 2 * tool_spacing,
						cap_inset_height + followthrough
					]);
				}
			}
			cube([
				swidth * no_blades + tool_spacing * (no_blades - 1) + 2 * bottom_sidewall,
				sheight + 2 * bottom_sidewall,
				socket_depth + wall_z - cap_inset_height
			]);
		}
		union()
		{
			for (offs = [bottom_sidewall + swidth / 2 : swidth + tool_spacing : bottom_sidewall + no_blades * (swidth + tool_spacing)])
			{
				translate([
					offs,
					bottom_sidewall + sheight / 2,
					wall_z
				])
				{
					rotate([0, 0, blade_angle])
					{
						xcelite_99_blade_socket(
							blade_base_dia + slop,
							blade_wingspan + slop,
							blade_wing_thickness + slop,
							socket_depth + followthrough
						);
					}
				}
			}
		}
	}
}

xcelite_99_blade_case();
