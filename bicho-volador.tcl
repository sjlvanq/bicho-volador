#!/usr/bin/sh
# the next line restarts using wish \
exec wish8.6 "$0" ${1+"$@"}
package require Tk

set c .c
canvas $c -width 300 -height 300 -background white
set bicho [$c create oval 5c 5c 5.4c 5.4c -fill black]

$c bind $bicho <1> "$c itemconfigure current -fill red" 
pack $c

set rumbo {10 0}
set rumbo_mod 1
set distancia 5

proc mover_bicho { c bicho } {
	global rumbo rumbo_mod distancia
	incr distancia -1
	if { $distancia <= 0 } {
		set distancia [expr int(rand()*5) + 5]
		set rumbo [lreverse $rumbo]
		set rumbo_mod [expr int(rand()*3)-1]
	}
	lassign $rumbo x y
	#mantiene_en_lienzo $c $bicho
	lassign [ $c coords $bicho ] x1 y1 x2 y2
	if { [expr $x*$rumbo_mod + $x2] <= 255 && 
		  [expr $x*$rumbo_mod + $x1] >= 45 && 
		  [expr $y*$rumbo_mod + $y2] <= 255 && 
		  [expr $y*$rumbo_mod + $y1]>= 45 } {
		
		$c move $bicho [expr $x*$rumbo_mod] [expr $y*$rumbo_mod]
	}
	after 25 mover_bicho $c $bicho 
}

# Antiguo proc. Fuera de uso. Requiere revisión 
proc mantiene_en_lienzo { c bicho } {
	global rumbo_mod distancia 
	lassign [ $c coords $bicho ] x1 y1 x2 y2
	if { $x2 >= 255 || $x1 <= 45 || 
		  $y2 >= 255 || $y1<= 45 } {
		set rumbo_mod [expr $rumbo_mod * -1]
	}
}

mover_bicho $c $bicho 
