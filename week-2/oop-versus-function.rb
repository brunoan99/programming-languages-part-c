# OOP Versus Functional Decomposition #

# Breaking things down
=begin

- In function (and procedural) programming, break programs down into functions that perform some operation

- In object-oriented programming, break programs down into classes that give behavior to some kind of data

Beginning of this unit:
  - These two forms of decomposition are so exactly opposite that they are two ways of looking at the same "matrix"
  - Which from is "better" is somewhat personal taste, but also depends on how you expect to change/extend software
  - For some operations over two (multiple) argumetns, functions and pattern-matching are straightforward, but with OOP
    we can do it with double dispatch (multiple dispatch)

=end


# The expression example
=begin

Well-known and compelling example of a common pattern:
  - Expressions for a small language
  - Different variants of expressions: ints, additions, negations, ...
  - Different operations to perform: eval, toString, hasZero, ...

Leads to a matrix (2D-grid) of variants and operations
  - Implementation will involve deciding what "should happen" for each entry in the grid regardless of the PL


|--------| eval | toString | hasZero | ... |
| Int    |      |          |         |     |
| Add    |      |          |         |     |
| Negate |      |          |         |     |
| ...    |      |          |         |     |

=end


# Standard approach in ML
=begin

|--------| eval | toString | hasZero | ... |
| Int    |      |          |         |     |
| Add    |      |          |         |     |
| Negate |      |          |         |     |
| ...    |      |          |         |     |

- Define a datatype, with one constructor for each variant
  - (No need to indicate datatypes if dynamically typed)
- "Fill out the grid" via one function per column
  - Each function has one branch for each column entry
  - Can combine cases (e.g., with wildcard patterns) if multiple entries in column are the same

```sml
datatype exp =
    Int    of int
  | Negate of exp
  | Add    of exp * exp

exception BadResult of string

fun add_values (v1, v2) =
  case (v1,v2) of
      (Int i, Int j) => Int (i+j)
    | _ => raise BadResult "non-ints in addition"

fun eval e =
  case e of
      Int _       => e
    | Negate e1   => (case (eval e1) of
                          Int i => Int (~1)
                        | _ => raise BadResult "non-int in negate")
    | Add (e1,e2) => add_values (eval e1, eval e2)

fun toString e =
  case e of
      Int i       => Int.toString i
    | Negate e1   => "-(" ^ (toString e1) ^ ")"
    | Add (e1,e2) => "(" ^ (toString e1) ^ " + " ^ (toString e2) ^ ")"

fun hasZero e =
  case e of
      Int i       => i=0
    | Negate e1   => hasZero e1
    | Add (e1,e2) => (hasZero e1) orelse (hasZero e2)
```
=end



# Standard approach in OOP
=begin

|--------| eval | toString | hasZero | ... |
| Int    |      |          |         |     |
| Add    |      |          |         |     |
| Negate |      |          |         |     |
| ...    |      |          |         |     |

- Define a class, with one abstract method for each operation
  - (No need to indicate abstract methods if dynamically typed)

- Define a subclass for each variant

- So "fill out the grid" via one class per row with one method implementation for each grid position
  - Can use a method in superclass if there is a default for multiple entries in a column

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
end


# A big course punchline
=begin

|--------| eval | toString | hasZero | ... |
| Int    |      |          |         |     |
| Add    |      |          |         |     |
| Negate |      |          |         |     |
| ...    |      |          |         |     |

- FP and OOP often doing the same thing in exact opposite way
  - Organize the program "by rows" or "by columns"

- Which is "most natural" may depend on what you are doing (e.g., an interpreter vs. a GUI) or personal taste

- Code layout is important, but there is no perfect way since software has many dimensions of strucutre
  - Tools, IDEs can help with multiple "views" (e.g., rows / columns )


=end
