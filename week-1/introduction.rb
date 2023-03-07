# Introduction to Ruby

=begin
  Ruby Logistics

- Ruby page: http://www.ruby-lang.org
- Ruby doc: http://www.ruby-doc.org

=end

=begin
  Ruby: focus is this course

- Pure object-oriented: all values are objects (even numbers)
- Class-based: Every object has a class that determines behavior
  - Like Java
  - Mixins (neither Java interfaces nor C++ multiple inheritance)
- Dynamically typed
- Convenient reflection: Run-time inspection of objects
- Very dynamic: Can change classes during execution
- Blocks and libraries encourage lots of closure idioms
- Syntax, scoping rules, semantics of a "scriptiong language"
  - Variables "spring to life" on use
  - Very flexible arrays

=end



=begin
  Ruby: not focus is this course

- Lots of support for string manipulation and regular expressions
- Popular for server-side web application
  - Ruby on Rails
- Often many ways to do the same thing
  - More of a "why not add that too?" approach
=end

=begin
  Where Ruby fits

|-------------------------| dynamically typed | statically typed   |
| functional              |     Racket        |   SML              |
| object-oriented (OOP)   |     Ruby          |   Java, C#         |
|-------------------------|-------------------|--------------------|

Note: Racket also has classes and objects when you want them
  - In Ruby everything uses them (at least implicitly)

Historical note: Smalltalk also a dynamically typed, class-based, pure OOP language with blocks and convenient reflection
  - Smaller just-as-powerful language
  - Ruby less simple, more "modern and useful"

Dynamically typed OOP helps identify OOP's essence by not having to discuss types

=end

class Hello
  def my_first_method
    puts "Hello, world!"
  end
end

x = Hello.new
x.my_first_method


