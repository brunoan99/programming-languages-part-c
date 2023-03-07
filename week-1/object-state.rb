# Object State

# Objects have state
=begin

- An object's state persists
  - Can grow and change from time object is created

- State only directly accessible from object's methods
  - Can read, write, extend the state
  - Effects persist for next method call

- State consists of *instance variables* (also known as fields)
  - Syntax: starts with an @, e.g., @foo
  - "Spring into being" with assignment
    - So mis-spellings silently add new state (!)
  - Using one not in state not an error; produces nil Object

=end

# Aliasing
=begin

- Creating an object returns a reference to a new object
  - Different state from every other object

- Variable assignment (e.g., x=y) creates an alias
  - Aliasing means same object means same state

=end

class A
  def m1
    @foo = 0
  end

  def m2 x
    @foo += x
  end

  def foo
    @foo
  end

end

class B
  def initialize (f=0)
    @foo = f
  end

  def m1
    @foo = 0
  end

  def m2 x
    @foo += x
  end

  def foo
    @foo
  end

end

# Initialization
=begin

- A method named initialize is special
  - Is called on a new object before new returns
  - Arguments to new are passed on to initialize
  - Excellent for creating object invariants
  - (Like constructors in Java/C#/etc.)

- Usually good style to create instance variables in initialize
  - Just a convention
  - Unlike OOP languages that make "what fields an object has" a (fixed) part of the class definition
    - In Ruby, different instances of same class can have different instance variables

=end


# Class variables
=begin

- There is also state shared by the entire class

- Shared by (and only acessible to) all instances of the class

- Called class variables
  - Syntax: starts with an @@, e.g., @@foo

- Less common, but sometimes useful
  - And helps explain via contrast that each object has its own instance variables

=end


# Class constants and methods
=begin

- Class constants
  - Syntax: start with capital letter, e.g., Foo
  - Should not be mutated
  - Visible outside class C as C::Foo (unlike class variables)

- Class method (cf. Java/C# static methods)
  - Syntax (in some class C):
    def self.method_name (args)
      ...
    end

  - Use (of class method in class C):
    C.method_name(args)

  - Part of the class, not a particular instance of it

=end
class C
  Any_Number = 1

  def self.reset_bar
    @@bar = 0
  end

  def initialize(f=0)
    @foo = f
  end

  def m2 x
    @foo += x
    @@bar += 1
  end

  def foo
    @foo
  end

  def bar
    @@bar
  end

end
