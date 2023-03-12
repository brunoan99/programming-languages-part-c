# Binary Methods with Functional Decomposition

# Binary operations
=begin

|--------| eval | toString | hasZero | ... |
| Int    |      |          |         |     |
| Add    |      |          |         |     |
| Negate |      |          |         |     |
| ...    |      |          |         |     |

- Situation is more complicated if an operation is defined over multiple arguments that can have different variants
  - Can arise in original program or after extension

- Function decomposition deals with this much more simply

=end


# Example
=begin

To show the issue:
  - Include variants String and Rational
  - (Re)define Add to work on any pair of Int, String, Rational
    - Concatenation if either argument a String, else math

Now just defining the addition operation is a different 2D grid:

-----------| Int | String | Rational |
| Int      |     |        |          |
| String   |     |        |          |
| Rational |     |        |          |

=end


# Binary Methods with OOP: Double Dispatch #

#
=begin
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

  def noNegConstants
    if i < 0
      Negate.new(Int.new(-i))
    else
    @self
  end

  # double-dispatch for adding values
  def add_values v # first dispatch
    v.addInt self
  end

  def addInt v # second dispatch: other is Int
    Int.new(v.i + i)
  end

  def addString v # second dispatch: other is MyString
    MyString.new(v.s + i.to_s)
  end

  def addRational v # second dispatch: other is MyRational
    MyRational.new(v.i +v.j*i, v.j)
  end
end

class MyString < Value
  attr_reader :s
  def initialize s
    @s = s
  end

  def eval
    self
  end

  def toString
    s
  end

  def hasZero
    false
  end

  def noNegConstants
    self
  end

  # double-dispatch for adding values
  def add_values v # first dispatch
    v.addString self
  end

  def addInt v # second dispatch: other is Int
    MyString.new(v.i.to_s + s)
  end

  def addString v # second dispatch: other is MyString
    MyString.new(v.s + s)
  end

  def addRational v # second dispatch: other is MyRational
    MyString.new(v.i.to_s + "/" + v.to_s + s)
  end
end

class MyRational < Value
  attr_reader :i, :j
  def initialize (i,j)
    @i = i
    @j = j
  end

  def eval
    self
  end

  def toString
    i.to_s + "/" + j.to_s
  end

  def hasZero
    i==0
  end

  def noNegConstants
    if i < 0 && j < 0
      MyRational.new(-i,-j)
    elsif i < 0
      Negate.new(MyRational.new(-i,j))
    elsif j < 0
      Negate.new(MyRational.new(i,-j))
    else
      self
    end
  end

  # double-dispatch for adding values
  def add_values v # first dispatch
    v.addRational self
  end

  def addInt v # second dispatch: other is Int
    MyRational.new(v.i*j + i,j)
  end

  def addString v # second dispatch: other is MyString
    MyString.new(v.s + i.to_s + "/" + j.to_s)
  end

  def addRational v # second dispatch: other is MyRational
    MyRational.new(v.i*j + i*v.j, j*v.j)
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

  def noNegConstants
    Negate.new(e.noNegConstants)
  end
end

def Add < Exp
  attr_reader :e1, :e2
  def initialize (e1, e2)
    @e1 = e1
    @e2 = e2
  end

  def eval
    e1.eval.add_values e2.eval
  end

  def toString
    "(" + e1.toString + " + " e2.toString + ")"
  end

  def hasZero
    e1.hasZero || e2.hasZero
  end

  def noNegConstants
    Add.new(e1.noNegConstants, e2.noNegConstants)
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

  def noNegConstants
    Mult.new(e1.noNegConstants, e2.noNegConstants)
  end
end

# What about OOP?
=begin

Starts promising:
  - Use OOP to call method add_values to one value with other value as result

    ```ruby
    class Add
      ...
      def eval
        e1.eval.add_values e2.eval
      end
      ...
    end
    ```

Class Int, MyString, MyRational then all implement
  - Each handling 3 of the 9 cases: "add self to argument"

    ```ruby
    class Int
      ...
      def add_values v
        ... # what goes here?
      end
      ..
    end
    ```

=end


# First try
=begin

- This approach is common, but is "not as OOP"

  ```ruby
    class Int
      ...
      def add_values v
        if v.is_a? Int
          Int.new(v.i + i)
        elseif v.is_a? MyRational
          MyRational.new(v.i * v.j*i, v.j)
        else
          MyString.new(v.s + i.to_s)
        end
      end
      ..
    end
    ```

- A "hybrid" style where we used dynamic dispatch on 1 argument and then
  switched to Racket-style type tests for other argument
    - Definitely not "full OOP"

=end


# Another way
=begin

- add_values method in Int needs "what kind of thing" v has
  - Same problem in MyRational and MyString

- In OOP, "always" solve this by calling a methods on v instead!

- But now we need to "tell" v "what kind of thing" self is
  - We know that!
  - "Tell" v by calling different methods on v, passing self

- Use a "programming trick" (?) called double-dispatch

=end


# Double-dispatch "trick"
=begin

- Int, MyString and MyRationa each define all of addInt, addString and AddRational
  - For example, String's addInt is for adding concatenating an integer argument to the string in self
  - 9 total methods, one for each case of addition

- Add's eval method calls e1.eval.add_values e2.eval, which dispatches to add_values in Int, String or Rational
  - Int's         ->  add_values: v.addInt self
  - MyString's    ->  add_values: v.addString self
  - MyRational's  ->  add_values: v.addRational self
  So add_values performs "2nd dispatch" to the correct case of 9!


Double-dispatch also works fine with static-typed languages, like Java/C#

=end
