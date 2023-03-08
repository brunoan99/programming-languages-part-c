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


# Why Use Subclassing?

# Example continued
=begin

- Consider alternatives to
    class ColorPoint < Point ... end

- Here subclassing is a good choice, but programmers often overuse subclassing in OOP languages

=end


# Why subclass
=begin

- Instead of creating ColorPoint, could add methods to Point
  - That could mess up other users and subclassers of Point

      class Point
        attr_accessor :color
        def initialize(x,y,c="clear")
          @x = x
          @y = y
          @color = c
        end
      end

=end

# Why subclass
=begin

- Instead of subclassing Point, could copy/paste the methods
  - Means the same thing if you don't use methods like is_a?
    and superclass, but of course code reuse is nice

      class ColorPoint
        attr_accessor :x, :y, :color
        def initialize(x,y,c="clear")
          @x = x
          @y = y
          @color = c
        end

        def distFromOrigin
          Math.sqrt(@x * @x + @y * @y) # uses instance variables
        end

        def distFromOrigin2
          Math.sqrt(x * x + y * y) # uses getter methods
        end
      end

=end


# Why subclass
=begin

- Instead of subclassing Point, could use a Point instance variable
  - Define methods to send same message to the Point
  - Often OOP programmers overuse subclassing
  - But for ColorPoint, subclassing makes sense: less work and can use ColorPoint wherever code expects a Point

      class ColorPoint
        attr_accessor :x, :y, :color
        def initialize(x,y,c="clear")
          @pt = Point.new(x,y)
          @color = c
        end

        def distFromOrigin
          x = @pt.x
          y = @pt.y
          Math.sqrt(x * x + y * y) # uses instance variables
        end

        def distFromOrigin2
          Math.sqrt(x * x + y * y) # uses getter methods
        end

        def x
          @pt.x
        end

        def y
          @pt.y
        end
      end

=end
