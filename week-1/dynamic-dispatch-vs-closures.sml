(* Dynamic Dispatch Versus Closures *)

fun even x = ( print "in even "; if x=0 then true else odd (x-1))
and odd x = ( print "in odd "; if x=0 then false else even (x-1))

val a1 = odd 7
val _ = print "\n"

(* shadowing even with a much quicker algorithm *)
(* does not change behavior of odd -- which continue too bad *)
fun even x = (x mod 2) = 0

val a2 = odd 7
val _ = print "\n"

(* does not change behavior of odd -- which is good, cause if change odd will be wrong *)
fun even x = false

val a3 = odd 7
val _ = print "\n"
