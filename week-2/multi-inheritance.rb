# Multiple Inheritance

# What next?
=begin

Have used classes for OOP'essence: inheritance, overriding, dynamic dispatch

Now, what if we want to have more than just 1 superclass
  - Multiple Inheritance: allow > 1 superclass
    - Useful but has some problems (C++)

  - Ruby-style mixins: 1 superclass; > 1 method providers
    - Often a fine substitute for multiple inheritance and has fewer problems (se also Scala traits)

  - Java/C#-style interfaces: allow > 1 types
    - Mostly irrelevant in a dynamic typed language, but fewer problems

=end


# Multiple Inheritance
=begin

- If inheritance and overriding are so useful, why limit ourselves to one superclass?
  - Because the semantics is often awkward
  - Because it makes static type-checking harder
  - Because it makes efficient implemeentation harder

- Is it useful?
  - Example: Make a ColorPt3D by inheriting from Pt3D and ColorPt (or maybe just from Color)
  - Example: Make a StudentAthlete by inheriting from Student and Athlete
  - With single inheritance, end up copying code or using non-OOP style helper functions

=end

class Pt
  attr_accessor :x, :y
  def distToOrigin
    Math.sqrt(x * x + y * y)
  end
end

class ColorPT < Pt
  attr_accessor :color
  def darken # error if @color not already set
    self.color = "dark " + self.color
  end
end

class Pt3D < Pt
  attr_accessor :z
  def distToOrigin
    Math.sqrt(x * x + y * y + z * z)
  end
end

# This does not exist is Ruby (or Java/C#, it does in C++)
# class ColorPtD < ColorPt, Pt3D
#   ...
# end

# two ways we could actually make 3D Color Points:

class ColorPt3D_1 < ColorPt
  attr_accessor :z
  def distToOrigin
    Math.sqrt(x * x + y * y + z * z)
  end
end

class ColorPt3D_2 < Pt3D
  attr_accessor :color
  def darken # error if @color not already set
    self.color = "dark " + self.color
  end
end


# Tree, dags, and diamonds
=begin

- Note: The phrases subcalss, superclass can be ambiguous
  - There are immediate subclasses, superclasses
  - And there are transitive subclasses, superclasses


- Single inheritance: the calss hierarchy is a tree
  - Nodes are classes
  - Parent is immediate superclass
  - Any number of children allowed

                  A
                 /|\
                / | \
               /  |  \
              B   C   D
                      |
                      E

- Multiple inheritance: the class hierarchy no longer a tree
  - Cycles still disallowed (a directed-acyclic graph)
  - If multiple paths show that X is a (transitive) superclass of Y, then we have diamonds


                  X
                 / \
                /   \
               /     \
              V       W
              |       |
               \      Z
                \    /
                 \  /
                  \/
                   \
                    Y

=end

# What could go wrong?
=begin

- If V and Z both define a method m,
  what does Y inherit? What does super mean?
  - Directed resends useful (e.g., Z::super)

- What if X defines a method m that Z but not V overrides?
  can handle like previous case, but sometimes undesirable
  (e.g., ColorPt3D wants Pt3D's overrides to "win")

- If X defines fields, should Y have one copy of them (f) or two
  (V::f and Z::f)?
    - Turns out each behavior can be desirable
    - So C++ has (at least) two forms of inheritance

=end


# SOlution to 3DColorPoints
=begin

If Ruby had multiple inheritance, we would want ColorPt3D to inherit methods that share one @x and one @y

  ```ruby
  class Pt
    attr_accessor :x, :y
    ...
  end

  class ColorPt < Pt
    attr_accessor :color
    ...
  end

  class Pt3D < Pt
    attr_accessor :z
    ... # override some methods
  end
  ```

class ColorPt3D < Pt3D, ColorPt # not Ruby!
end

=end

# ArtistCowboys
=begin

This code has Person define a pocket for sublcasses to use, but an ArtistCowboy wants two pockets, one for each draw method

  ```ruby
  class Person
    attr_accessor :pocket
    ...
  end

  class Artist < Person # pocket for brush objects
    def draw # access pocket
    ...
  end

  class Cowboy < Person # pocket for gun objects
    def draw # access pocket
    ...
  end
  ```

class ArtistCowboy < Artist, Cowboy # not Ruby!
end

=end


# Mixins #

# Mixins
=begin

- A mixin is a collection of methods
  - Less than a class: no instances of it

- Languages with mixins (e.g., Ruby modules) typically let a class have one superclass but include number of mixins

- Semantics: Including a mixin makes its methods part of the class
  - Extending or overriding in the order mixins are included in the class definition
  - More powerful than helper methods becausee mixin methods can access methods (and instance variables)
    on self not defined in the mixin


=end

module Doubler
  def double
    self + self
  end
end

class Pt
  attr_accessor :x, :y
  include Doubler
  def + other
    ans = Pt.new
    ans.x = self.x + other.x
    ans.y = self.y + other.y
    ans
  end
end

class String
  include Doubler
end


# Lookup rules
=begin

Mixins changer our lookup rules slightly:
  - When looking for receiver obj's method m, look in obj's class,
    then mixins that class includes (later includes shadow), then obj's superclass,
    then the superclass'mixins, etc.

  - As for instance variables, the mixin methods are included in the same object
    - So usually bad style for mixin methods to use instance variables since a name clash would be like our CowboyArtist
      pocket problem (but sometimes unavoidable?)

=end


# The two big ones
=begin

The two most popular/useful mixins in Ruby:
  - Comparable: Defines <,>,==,!=,>=,<= in terms of <=>
    - <=> returns -1, 0 or 1 depending on the values being compared
  - Enumerable: Defines many iterators (e.g., map, find) in terms of each

Great examples of using mixins:
  - Classes including them get a bunch of methods for just a little work
  - Classes do not "spend" their "one superclass" for this
  - Do not neeed the complexity of multiple inheritance

=end

class Name
  attr_accessor :first, :middle, :last
  include Comparable
  def initialize (first, last, middle="")
    @first = first
    @middle = middle
    @last = last
  end

  def <=> other
    l = @last <=> other.last  # <=> defined on strings
    return l if l != 0
    f = @first <=> other.first
    return f if f != 0
    @middle <=> other.middle
  end
end


class MyRange
  include Enumerable
  def initialize (low,high)
    @low = low
    @high = high
  end
  def each
    i=@low
    while i <= @high
      yield i
      i=i+1
    end
  end
end


# Replacement for multiple inheritance?
=begin

- A mixin works pretty well for ColorPt3D
  - Color a reasonable mixin except for using an instance variable

    ```ruby
    module Color
      attr_accessor :color
    end
    ```

- A mixin works awkwardly-at-best for ArtistCowboy:
  - Natural for Artist and Cowboy to be Person subclasses
  - Could move methods of one to a mixin, but it is odd style and still does not get you two pockets

    ```ruby
    module ArtistM ...

    class Artist < Person
      include ArtistM
      ...

    class ArtistCowboy < Cowboy
      include ArtistM
      ...
    ```

=end
