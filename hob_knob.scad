//design variables
height = 				24; // mm
shaft_diameter = 	 6.1; // mm
D_width = 			 4.7; // mm
outer_diameter = 	36; // mm
wall_thickness =    3; // mm
inner_diameter = 	14; // mm
shaft_length = 		11; // mm
plunge_depth = 		 7; // mm 
clearance_height =  8; // mm
point_size = 		 6; // mm
point_angle = 		90; // degrees
no_sides = 			11;
stiffener_thickness = 2; // mm
$fn = 	100;

difference() {
	// main shape
	difference(){
		union() {
			difference() {
				// overall form
				union() {
					cylinder(h=height, r=outer_diameter/2, $fn=no_sides);
					translate([0,0,height]) cylinder(h=(plunge_depth), r=(inner_diameter/2));
				}
				// hollow torus
				translate([0,0,(wall_thickness)]) difference() {
					cylinder(h=height, r=(outer_diameter/2)-wall_thickness);
					translate([0,0,-1]) cylinder(h=height+2, r=inner_diameter/2);
				}
			}
			// internal supports
			translate([0,0,height/2]) cube(size=[outer_diameter-wall_thickness, stiffener_thickness, height], center=true);
			translate([0,0,height/2]) cube(size=[stiffener_thickness, outer_diameter-wall_thickness, height], center=true);
		}
		// D-shaft hole
		rotate([0,0,-90-point_angle]) {
			translate([0,0,(height-shaft_length)]) difference() {
				cylinder(h=(shaft_length+plunge_depth+2), r=shaft_diameter/2);
				translate([-shaft_diameter/2,(D_width-shaft_diameter/2),-1]) cube(size=[shaft_diameter,shaft_diameter,shaft_length+plunge_depth+4]);
			}
		}
	}
	translate([0,0,height-clearance_height]) difference() {
		cylinder(h=height, r=(outer_diameter/2)-wall_thickness);
		translate([0,0,-1]) cylinder(h=height+2, r=inner_diameter/2);
	}
};

// zero marker
translate([36/2,0,0]) {
	polyhedron(
		points=[
			[point_size,0,24],[-1,-3,24],[-1,3,24],
			[0,0,0]
		],
		triangles=[
			[0,1,2],
			[0,3,1],
			[0,2,3],
			[2,1,3]
		]
	);
};