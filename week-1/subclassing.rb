# Subclassing

# Subclassing
=begin

- A class definition has a superclass (Object if not specified)
    class ColorPoint < Point ...


- The superclass affects the class definition:
  - Class inherits all method definitions from superclass
  - But class can override method definitions as desired

- Unlike Java/C#/C++:
  - No such thing as "inheriting fields" since all objects create instance variables by assigning to them
  - Subclassing has nothing to do with a (non-existent) type system: can still (try to) call any method on any object

Example
=end

class Point
  attr_accessor :x, :y

  def initialize(x,y)
    @x = x
    @y = y
  end

  def distFromOrigin
    Math.sqrt(@x * @x + @y * @y) # uses instance variables
  end

  def distFromOrigin2
    Math.sqrt(x * x + y * y) # uses getter methods
  end
end

class ColorPoint < Point
  attr_accessor :color

  def initialize(x,y,c="clear")
    super(x,y) # keyword super calls same method in superclass, in this case Point
    @color = c
  end
end

p1 = Point.new(0,0)
c1 = ColorPoint.new(0,0,"red")

p1.is_a? Point # -> true
p1.is_a? Object # -> true
p1.is_a? ColorPoint # -> false

c1.is_a? ColorPoint # -> true
c1.is_a? Point # -> true
c1.is_a? Object # -> true

p1.instance_of? Point # -> true
p1.instance_of? ColorPoint # -> false

c1.instance_of? ColorPoint # -> true
c1.instance_of? Point # -> false

# An object has a class

p1.class                        # Point
p1.class.superclass             # Object
c1.class                        # ColorPoint
c1.class.superclass             # Point
c1.class.superclass.superclass  # Object
c1.is_a? Point                  # true
c1.instance_of? Point           # false
c1.is_a? ColorPoint             # true
c1.instance_of? ColorPoint      # true
=begin

- Using these methods is usually non-OOP style
  - Disallows other things that "act like a duck"
  - Nonetheless semantics is that an instance of ColorPoint
    "is a" Point but is not an "instance of" Point

=end
