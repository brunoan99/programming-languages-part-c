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
