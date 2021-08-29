/*
 * Copyright (c) 2021 Peter Piwowarski <peterjpiwowarski@gmail.com>
 *
 * Permission to use, copy, modify, and distribute this model for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE MODEL IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS MODEL INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS MODEL.
 */

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
	no_blades = no_blades,
	// Increase for tools with heads bigger than the handle's socket.
	tool_spacing_x = tool_spacing_x,
	tool_spacing_y = tool_spacing_y,
	// Increase for small values of tool_spacing_*
	outside_pad = outside_pad,
	wall_z = wall_thickness,
	cap_inset_depth = cap_thickness + cap_clearance,
	cap_inset_height = cap_overlap,

	blade_base_dia = blade_base_dia,
	/*
	 * wingspan: max distance from one wing's outer surface to the other:
	 *
	 *      ___
	 *  ___/ ^ \_______
	 * |___  |  _______--------
	 *     \_v_/
	 */
	blade_wingspan = blade_wingspan,
	blade_wing_thickness = blade_wing_thickness,
	// 0 is wingtip-to-wingtip, 90 is flat-to-flat.
	blade_angle = blade_angle,
	socket_depth = socket_depth,
	socket_clearance = 0.006,
	followthrough = 0.01
)
{
	slop = 2 * socket_clearance;
	swidth = socket_width(blade_base_dia, blade_wingspan, blade_wing_thickness, blade_angle) + slop;
	sheight = socket_height(blade_base_dia, blade_wingspan, blade_wing_thickness, blade_angle) + slop;
	sidewall_x = max(tool_spacing_x, outside_pad);
	sidewall_y = max(tool_spacing_y, outside_pad);
	bottom_sidewall_x = sidewall_x + cap_inset_depth;
	bottom_sidewall_y = sidewall_y + cap_inset_depth;

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
						swidth * no_blades + (no_blades - 1) * tool_spacing_x + 2 * sidewall_x,
						sheight + 2 * sidewall_y,
						cap_inset_height + followthrough
					]);
				}
			}
			cube([
				swidth * no_blades + tool_spacing_x * (no_blades - 1) + 2 * bottom_sidewall_x,
				sheight + 2 * bottom_sidewall_y,
				socket_depth + wall_z - cap_inset_height
			]);
		}
		union()
		{
			for (offs = [
				bottom_sidewall_x + swidth / 2 :
				swidth + tool_spacing_x :
				bottom_sidewall_x + no_blades * (swidth + tool_spacing_x)
			])
			{
				translate([
					offs,
					bottom_sidewall_y + sheight / 2,
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
