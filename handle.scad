/*
 * Copyright (c) 2023 Peter Piwowarski <peterjpiwowarski@gmail.com>
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

$fn = 128;
followthrough = 0.01;

socket_pad = 0.5;
tee_y = 4.5;
center_z = 2.25;
tee_z = 0.5;
chamfer = 0.125;
// *not* multiplied by two like the "clearances"
handle_slop = 0.012;

module chamfer_square(x, y, chamfer, z)
{
	linear_extrude(z)
	{
		polygon([
			[0, chamfer],
			[chamfer, 0],
			[x - chamfer, 0],
			[x, chamfer],
			[x, y - chamfer],
			[x - chamfer, y],
			[chamfer, y],
			[0, y - chamfer]
		]);
	}
}

module t_handle(
	blade_wingspan = blade_wingspan,
	blade_base_dia = blade_base_dia,
	tee_y = tee_y,
	center_z = center_z,
	tee_z = tee_z,
	chamfer = chamfer,
	blade_clearance = handle_slop,
	socket_pad = socket_pad
)
{
	x = blade_wingspan + socket_pad;
	center_y = blade_base_dia + socket_pad;
	union()
	{
		difference()
		{
			chamfer_square(x, center_y, chamfer, center_z);
			translate([x / 2, center_y / 2, -followthrough])
			{
				xcelite_99_blade_socket(
					blade_base_dia + blade_clearance,
					blade_wingspan + blade_clearance,
					blade_wing_thickness + blade_clearance,
					center_z - 0.25 + followthrough
				);
			}
		}
		translate([0, (tee_y + center_y) / 2, center_z - tee_z + chamfer])
		{
			rotate([90, 0, 0])
			{
				chamfer_square(x, tee_z, chamfer, tee_y);
			}
		}
	}
}

t_handle();
