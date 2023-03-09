# Overriding and Dynamic Dispatch


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

=begin
- ThreeDPoint is more interesting than ColorPoint because it overrides distFromOrigin and distFromOrigin2
  - Gets code reuse, but highly disputable if it is appropriate to say a ThreeDPoint "is a" Point
  - Still just avoiding copy/paste
=end

class ThreeDPoint < Point
  attr_accessor :z

  def initialize(x,y,z)
    super(x,y)
    @z = z
  end

  def distFromOrigin
    d = super
    Math.sqrt(d * d + @z * @z)
  end

  def distFromOrigin2
    d = super
    Math.sqrt(d + z * z)
  end
end

# So far...
=begin

- With examples so far, objects are not so different from closures
  - Multiple methods rather than just "call me"
  - Explicit instance variables rather than environment where function is defined
  - Inheritance avoids helper functions or code copying
  - "Simple" overriding just replaces methods

- But there is one big difference:

    Overriding can make a method define in the superclass call a method in the subclass

  - The essential difference of OOP, studied carefully next lecture

=end


#
=begin
=end

class PolarPoint < Point
  # Interesting: by not calling super constructor, no x and y instance vars
  def initialize(r,theta)
    @r = r
    @theta = theta
  end

  def x
    @r * Math.cos(@theta)
  end

  def
    @r *y Math.sin(@theta)
  end

  def x= a
    b = y # avoids multiple calls to y method
    @theta = Math.atan2(b, a)
    @r = Math.sqrt(a*a + b*b)
    self
  end

  def y= b
    a = x # avoid multiple calls to y method
    @theta = Math.atan2(b, a)
    @r = Math.sqrt(a*a + b*b)
    self
  end

  def distFromOrigin # must override since inherited method does wrong thing
    @r
  end
  # inherited distFromOrigin2 already works!!
  # def distFromOrigin2
  #   Math.sqrt(x * x + y * y) # uses getter methods
  # end
  # this keeps working cause calls to self are resolved in terms of the object's class
  # than x and y will be resolved in terms of Polar Point.
end
