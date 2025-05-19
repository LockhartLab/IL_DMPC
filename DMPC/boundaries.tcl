# wrapmode input
# wrapmode cell
# wrapmode nearest
# wrapmode patch ;# the default

proc calcforces {step unique k} {

 set cell [getcell]
 set z [lindex [lindex $cell 3] 2]
 set zw [expr 0.5*$z-4.0]
 #print "$z $zw"

 while {[nextatom]} {
  set atomnum [getid]

  # indo 1, atomids 1-275 (indo1 placed above membrane in +Z)
  if {$atomnum >= 1 && $atomnum <= 275} {
   set coord [getcoord]
   set zk [lindex $coord 2]
   if {$zk > $zw} {
    set rz [expr $zk-$zw]
    set fz [expr -$k*$rz]
    addenergy [expr 0.5*$k*$rz**2.0]
    addforce [list 0.0 0.0 $fz]
   } 
  # indo 2, atomids 276-550 (indo2 placed below membrane in -Z)
  } elseif {$atomnum >= 276 && $atomnum <= 550} {
   set coord [getcoord]
   set zk [lindex $coord 2]
   if {$zk < [expr $zw*-1.0]} {
    set rz [expr $zk+$zw]
    set fz [expr -$k*$rz]
    addenergy [expr 0.5*$k*$rz**2.0]
    addforce [list 0.0 0.0 $fz]
   }
  # ion placed above membrane in +Z
  } elseif {$atomnum >= 46549 && $atomnum <= 46552} {
   set coord [getcoord]
   set zk [lindex $coord 2]
   if {$zk > $zw} {
    set rz [expr $zk-$zw]
    set fz [expr -$k*$rz]
    addenergy [expr 0.5*$k*$rz**2.0]
    addforce [list 0.0 0.0 $fz]
   }
  # ion placed below membrane in -Z
  } elseif {$atomnum >= 46553 && $atomnum <= 46556} {
   set coord [getcoord]
   set zk [lindex $coord 2]
   if {$zk < [expr $zw*-1.0]} {
    set rz [expr $zk+$zw]
    set fz [expr -$k*$rz]
    addenergy [expr 0.5*$k*$rz**2.0]
    addforce [list 0.0 0.0 $fz]
   }
  # drop all other atoms from consideration
  } else {
   dropatom
   continue
  }
 }
}
