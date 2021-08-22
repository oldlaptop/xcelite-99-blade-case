include <common.scad>
use <xcelite-99-blade-case.scad>
use <xcelite-99-blade-case-cap.scad>

cutaway_x = false;
cutaway_y = true;

difference()
{
	union()
	{
		xcelite_99_blade_case();
		translate([0, 0, (socket_depth_def - cap_overlap)])
		{
			xcelite_99_blade_case_cap();
		}
	}
	union()
	{
		if (cutaway_x)
		{
			translate([1, -0.1, -0.1])
			{
				cube([10, 10, 10]);
			}
		}
		if (cutaway_y)
		{
			translate([-0.1, 0.25, -0.1])
			{
				cube([10, 10, 10]);
			}
		}
	}
}
