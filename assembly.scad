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
use <xcelite-99-blade-case.scad>
use <xcelite-99-blade-case-cap.scad>

cutaway_x = false;
cutaway_y = false;

difference()
{
	union()
	{
		xcelite_99_blade_case();
		color("blue", 0.5)
		{
			translate([0, 0, (socket_depth + wall_thickness  - cap_overlap)])
			{
				xcelite_99_blade_case_cap();
			}
		}
	}
	union()
	{
		if (cutaway_x)
		{
			translate([(socket_width(
				blade_base_dia,
				blade_wingspan,
				blade_wing_thickness,
				blade_angle
			) * no_blades + tool_spacing_x * (no_blades - 1)) / 2 + no_blades * socket_clearance + max(tool_spacing_x, outside_pad) + cap_thickness + cap_clearance, -0.1, -0.1])
			{
				cube([10, 10, 10]);
			}
		}
		if (cutaway_y)
		{
			halfdepth = 
				socket_height(
					blade_base_dia,
					blade_wingspan,
					blade_wing_thickness,
					blade_angle
				) / 2 + socket_clearance + max(
					tool_spacing_y,
					outside_pad
				) + cap_thickness + cap_clearance;
			translate([-0.1, -0.1, -0.1])
			{
				cube([100, halfdepth + 0.1, 100]);
			}
		}
	}
}
