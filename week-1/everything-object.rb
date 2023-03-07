# Everything is an Object

# Pure OOP
=begin

- Ruby is fully committed to OOP
    Every value is a reference to an object

- Simpler, smaller semantics

- Can call methods on anything
  - May just get a dynamic "undefined method" error

- Almost everything is a method call
  - Example: 3 + 4

=end


# All code is methods
=begin

- All methods you define are part of a class

- Top-level methods (in file or REPL) just added to Object class

- Since all classes you define are subclasses of Object, all inherit the top-level methods
  - So you can call these methods anywhere in the program
  - Unless a class overrides it by defining a method with the same name

=end

# Reflection and  exploratory programming
=begin

- All objects also have methods like:
  - methods
  - class

- Can use at run-time to query "what an object can do" and respond accordingly
  - Called reflection

- Also useful in the REPL to explore what methods are available
  - May be quicker than consulting full documentation

- Another example of "just objects and method calls"
=end
