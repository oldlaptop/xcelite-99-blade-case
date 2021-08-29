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

module xcelite_99_blade_case_cap(
	no_blades = no_blades,
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
	socket_clearance = socket_clearance,
	tool_spacing_x = tool_spacing_x,
	tool_spacing_y = tool_spacing_y,
	outside_pad = outside_pad,

	thickness = cap_thickness,
	height = blade_overall_length - (socket_depth - cap_overlap) + 0.125,
	clearance = cap_clearance,
	// switch to 'true' to make a solid block printable in vase mode
	solid = solid_cap,
	followthrough = 0.01
)
{
	slop = 2 * clearance;
	walls = 2 * thickness;
	pad_x = max(tool_spacing_x, outside_pad);
	pad_y = max(tool_spacing_y, outside_pad);
	width = no_blades * (socket_width(
		blade_base_dia,
		blade_wingspan,
		blade_wing_thickness,
		blade_angle
	) + 2 * socket_clearance) + (no_blades - 1) * tool_spacing_x + 2 * pad_x + slop;
	depth = 2 * pad_y + socket_height(
		blade_base_dia,
		blade_wingspan,
		blade_wing_thickness,
		blade_angle
	) + 2 * socket_clearance + slop;

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

xcelite_99_blade_case_cap();
