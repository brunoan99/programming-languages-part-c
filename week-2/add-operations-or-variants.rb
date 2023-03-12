# Adding Operations or Variants


# Extensibility
=begin

|---------| eval | toString | hasZero | noNegConstants |
| Int     |      |          |         |                |
| Add     |      |          |         |                |
| Negate  |      |          |         |                |
| Mult    |      |          |         |                |

- For implementign our grid so far, SML / Racket style usually by column and Ruby / Java style usually by row

- But beyond just style, this decision affects what (unexpected?) software extensuions need not change old code

- Functions
  - Easy to add a new operation, e.g., noNegConstants
  - Adding a new variant, e.g., Mult requires modifying old functions, but ML type-checker gives a to-do list
    if original code avoided wildcard patterns

```sml

datatype exp =
    Int    of int
  | Negate of exp
  | Add    of exp * exp
  | Mult   of exp * exp

exception BadResult of string

fun add_values (v1, v2) =
  case (v1,v2) of
      (Int i, Int j) => Int (i+j)
    | _ => raise BadResult "non-ints in addition"

fun mult_values (v1, v2) =
  case (v1,v2) of
      (Int i, Int j) => Int (i*j)
    | _ => raise BadResult "non-ints in multiplication"

fun eval e =
  case e of
      Int _         => e
    | Negate e1     => (case (eval e1) of
                            Int i => Int (~1)
                          | _ => raise BadResult "non-int in negate")
    | Add (e1,e2)   => add_values (eval e1, eval e2)
    | Mult (e1,e2)  => mult_values (eval e1, eval e2)

fun toString e =
  case e of
      Int i         => Int.toString i
    | Negate e1     => "-(" ^ (toString e1) ^ ")"
    | Add (e1,e2)   => "(" ^ (toString e1) ^ " + " ^ (toString e2) ^ ")"
    | Mult (e1,e2)  => "(" ^ (toString e1) ^ " * " ^ (toString e2) ^ ")"

fun hasZero e =
  case e of
      Int i         => i=0
    | Negate e1     => hasZero e1
    | Add (e1,e2)   => (hasZero e1) orelse (hasZero e2)
    | Mult (e1, e2) => (hasZero e1) orelse (hasZero e2)

fun noNegConstants e =
  case e of
      Int i         => if i < 0 then Negate (Int(~i)) else e
    | Negate e1     => Negate(noNegConstants e1)
    | Add (e1,e2)   => Add(noNegConstants e1, noNegConstants e2)
    | Mult (e1, e2) => Mult(noNegConstants e1, noNegConstants e2)

```

=end



# Extensibility
=begin

|---------| eval | toString | hasZero | noNegConstants |
| Int     |      |          |         |                |
| Add     |      |          |         |                |
| Negate  |      |          |         |                |
| Mult    |      |          |         |                |

- For implementign our grid so far, SML / Racket style usually by column and Ruby / Java style usually by row

- But beyond just style, this decision affects what (unexpected?) software extensuions need not change old code

- Objects
  - Easy to add a new variant, e.g., Mult
  - Adding a new operation, e.g., noNegConstants requires modifying old classes, but Java type-checker gives a to-do list
    if original code avoided default methods

=end

class Exp
  # could put default implementations or helper methods here
end

class Value < Exp
  # overkill here, but useful if you have multiple kinds of
  # /values/ in your language that can share methods that
  # do not make sense for non-value expressions
end

class Int < Value
  attr_reader :i
  def initialize i
    @i = i
  end

  def eval # no argument because no envrironment
    self
  end

  def toString
    @i.to_s
  end

  def hasZero
    @i == 0
  end

  def noNegateConstants
    if i < 0
      Negate.new(Int.new(-i))
    else
    @self
  end
end


class Negate < Exp
  attr_reader :e
  def initialize e
    @e = e
  end

  def eval
    Int.new(-e.eval.i) # error if e.eval has no i method
  end

  def toString
    "-(" + e.toString + ")"
  end

  def hasZero
    e.hasZero
  end

  def noNegateConstants
    Negate.new(e.noNegateConstants)
  end
end

def Add < Exp
  attr_reader :e1, :e2
  def initialize (e1, e2)
    @e1 = e1
    @e2 = e2
  end

  def eval
    Int.new(e1.eval.i + e2.eval.i) # error if e1.eval or e2.eval has no i method
  end

  def toString
    "(" + e1.toString + " + " e2.toString + ")"
  end

  def hasZero
    e1.hasZero || e2.hasZero
  end

  def noNegateConstants
    Add.new(e1.noNegateConstants, e2.noNegateConstants)
  end
end


def Mult < Exp
  attr_reader :e1, :e2
  def initialize (e1, e2)
    @e1 = e1
    @e2 = e2
  end

  def eval
    Int.new(e1.eval.i * e2.eval.i) # error if e1.eval or e2.eval has no i method
  end

  def toString
    "(" + e1.toString + " * " e2.toString + ")"
  end

  def hasZero
    e1.hasZero || e2.hasZero
  end

  def noNegateConstants
    Mult.new(e1.noNegateConstants, e2.noNegateConstants)
  end
end


# The other way is possible
=begin

- Functions allow new operations and objects allow new variants without modifying existing code even if they didn't plan for it
  - Natural result of the decomposition

- Functions can support new variants somewhat awkwardly "if they plan ahead"
  - Can use type constructors to make datatypes extensible and have operations take function arguments to give results for the extensions

- Objects can support new operations somewhat awkwardly "if they plan ahead"
  - The popular Visitor Pattern uses the double-dispatch pattern to allow new operations "on the side"

=end


# Thoughts on Extensibility
=begin

- Making software extensible is valuable and hard
  - If you know you want new operations, use FP
  - If you know you want new variants, use OOP
  - If both? Languages like Scala try; it's a hard problem
  - Reality: The future is often hard to predict

- Extensibility is a double-edged sword
  - Code more reusable without being changed later
  - But makes original code more difficult to reason abbout locally or change later (could break extensios)
  - Often language mechanisms to make code less extensible (ML modules hide datatypes; Java's final prevents subclassing/overriding)

=end
