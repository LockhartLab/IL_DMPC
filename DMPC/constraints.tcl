
# addgroup needs atomid
set upperlayer [addgroup {570 688 806 924 1042 1160 1278 1396 1514 1632 1750 1868 1986 2104 2222 2340 2458 2576 2694 2812 2930 3048 3166 3284 3402 3520 3638 3756 3874 3992 4110 4228 4346 4464 4582 4700 4818 4936 5054 5172 5290 5408 5526 5644 5762 5880 5998 6116 6234}]
set lowerlayer [addgroup {6352 6470 6588 6706 6824 6942 7060 7178 7296 7414 7532 7650 7768 7886 8004 8122 8240 8358 8476 8594 8712 8830 8948 9066 9184 9302 9420 9538 9656 9774 9892 10010 10128 10246 10364 10482 10600 10718 10836 10954 11072 11190 11308 11426 11544 11662 11780 11898 12016}]

# spring constant
set k 6.5

# set distance between P-P
set d 34.73617
set ddiv2 [expr $d / 2.]

# required function
proc calcforces {} {
 # load in atom coordinates (add group computes COM)
 global upperlayer lowerlayer k ddiv2
 loadcoords coord
 
 # constraint between cm1 and cm2 of phosphate atoms in bilayer
 set cm1 [split $coord($upperlayer) { }]
 set cm2 [split $coord($lowerlayer) { }]
 set cm1_z [lindex $cm1 2]
 set cm2_z [lindex $cm2 2]
 set r_cm1_d [expr $cm1_z-$ddiv2]
 set r_cm2_d [expr $cm2_z+$ddiv2]
 set f_cm1_z [expr -$k*$r_cm1_d]
 set f_cm2_z [expr -$k*$r_cm2_d]
 addenergy [expr 0.5*$k*$r_cm1_d**2.0]
 addenergy [expr 0.5*$k*$r_cm2_d**2.0]
 addforce $upperlayer [list 0.0 0.0 $f_cm1_z]
 addforce $lowerlayer [list 0.0 0.0 $f_cm2_z]

 # print com
 #print cm1_z=$cm1_z
 #print cm2_z=$cm2_z
}
