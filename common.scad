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

include <MCAD/constants.scad>

no_blades = 6;
blade_base_dia = 0.280;
blade_wingspan = 0.410; // See xcelite-99-blade-case.scad
blade_wing_thickness = 0.110;
blade_angle = 90; // 0 for minimum depth, 90 for minimum width
blade_overall_length = 5;
wall_thickness = 0.075;

/*
 * Increase for tools with heads bigger than the handle's socket. Set negative
 * to pack tools closer together for angles other than 0 or 90.
 */
tool_spacing_x = 0.025;
tool_spacing_y = wall_thickness;

// Increase for small values of tool_spacing_*_def
outside_pad = wall_thickness;


// Single perimeter with a 0.4mm nozzle, for vase mode
// cap_thickness = 0.45 / mm_per_inch;
cap_thickness = 0.075;
cap_clearance = 0.003;
cap_overlap = 1;
solid_cap = 0;

socket_clearance = 0.007;
socket_depth = 1.5;

function socket_width(blade_base_dia, blade_wingspan, blade_wing_thickness, blade_angle)
	= max(blade_base_dia, cos(blade_angle) * blade_wingspan + cos(90 - blade_angle) * blade_wing_thickness);

function socket_height(blade_base_dia, blade_wingspan, blade_wing_thickness, blade_angle)
	= max(blade_base_dia, sin(blade_angle) * blade_wingspan + sin(90 - blade_angle) * blade_wing_thickness);
