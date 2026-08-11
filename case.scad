// units in mm


difference() {
    yeap();
    cutaway();
}

// This section is the head unit that I have.

// There are 3 bolts and 2 index holes:
// btop: bolt top
// bcorner: bolt corner
// bback: bolt back
// itop: index hole top
// iback: index hole back
// These are faces of the case and screen:
// ctop: case top
// cfront: case front
// stop: screen top
bback_bcorner = 40;
bcorner_btop = 28;
btop_itop = 10;
bback_iback = 10;

btop_ctop = 25;
btop_cfront = 45;

ctop_stop = 1.5;

// These are viewing it from inside the cab. "depth" is distance into the dashboard.
case_width = 178;
case_height = 70;
case_depth = 150;

screen_width = 213;
screen_depth = 17;
screen_height = 115;

// Diameters.
bolt_d = 5;
index_d = 3;

module yeap() {
    union() {
        difference() {
            // Case
            translate([0, -case_depth/2, -case_height/2])
            cube([case_width, case_depth, case_height], center=true);

            // Bolt, top
            translate([0, -btop_cfront, -btop_ctop])
            rotate([0,90,0])
            cylinder(h=case_width, d=bolt_d, center=true, $fn=15);

            // Index hole, top
            translate([0, -btop_cfront, -(btop_ctop+btop_itop)])
            rotate([0,90,0])
            cylinder(h=case_width, d=index_d, center=true, $fn=15);

            // Bolt, corner
            translate([0, -btop_cfront, -(btop_ctop+bcorner_btop)])
            rotate([0,90,0])
            cylinder(h=case_width, d=bolt_d, center=true, $fn=15);

            // Index hole, back
            translate([0, -(btop_cfront+bback_bcorner-bback_iback), -(btop_ctop+bcorner_btop)])
            rotate([0,90,0])
            cylinder(h=case_width, d=index_d, center=true, $fn=15);

            // Bolt, back
            translate([0, -(btop_cfront+bback_bcorner), -(btop_ctop+bcorner_btop)])
            rotate([0,90,0])
            cylinder(h=case_width, d=bolt_d, center=true, $fn=15);
        }

        // Screen
        translate([0, screen_depth/2, (-screen_height/2) + ctop_stop])
        cube([screen_width, screen_depth, screen_height], center=true);
    }
}

// This section is preparing it for my uses.

case_wall_thickness = 3;

module cutaway() {
    // Main cavity
    translate([0, -case_depth/2, -(case_height-case_wall_thickness)/2])
    cube([case_width-(case_wall_thickness*2), case_depth, case_height-case_wall_thickness], center=true);

    // Slope on back
    back_cut = [[0,0], [0,-(case_height-case_wall_thickness)], [-100,0]];
    translate([case_width/2, -case_depth, 0])
    rotate([90, 0, -90])
    linear_extrude(height=case_width)
    polygon(back_cut);

    // Remove bottom of screen for ease of print
    translate([-screen_width/2, 0, -(screen_height - ctop_stop)])
    cube([screen_width, screen_depth, screen_height - ctop_stop - case_height]);
    
}
