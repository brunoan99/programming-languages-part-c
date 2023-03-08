# Procs

# Blocks are "second-class"
=begin

All a method can do with a block is yield to it
  - Cannot return it, store it in an object (e.g., for a callback),...
  - But can also turn blocks into real closures
  - Closures are instances of class Proc
    - Called with method call

- Blocks are "second-class"
- Procs are "first-class expressions"

This is Ruby, so there are several ways to make Proc objects
  - One way: method lambda of Object takes a block and returns the corresponding Proc

=end

a = [3,5,7,9]

# b = a.map {|x| {|y| x >= y }} its an error cause a block isnt an expression
b = a.map {|x| lambda {|y| x >= y }}
# b = [<proc>, <proc>, <proc>, <proc>]

c = b.map {|x| x.call(5)}
# c -> [false, true, true, true]


# Moral
=begin

- First-class ("can be passed/stored anywhere") makes closures more powerful than blocks

- But blocks are (a little) more convenient and cover most uses

- This helps us understand what first-class means

- Language design question: When is convenience worth making something less general and powerful?

=end
