# Blocks

# Blocks
=begin

Blocks are probably Ruby's strangest feature compared to other PLs

But almost just closures
  - Normal: easy way to pass anonymous functions to methods for all the usual reasons
  - Normal: Blocks can take 0 or more arguments
  - Normal: Blocks use lexical scope: block body uses environment where block was defined

Example
=end

3.times { puts "hi" } # print hi 3 times
[4,6,8].each { puts "hi" } # also print hi 3 times cause [4,6,8].size size is 3
i = 7
[4,6,8].each {|x| if i > x then puts (x + 1) end} # prints 5, 7


# Some strange things
=begin

- Can pass 0 or 1 block with any message
  - Callee might ignore it
  - Callee might given an error if you do not send one
  - Callee might do different things if you do/don't send one
    - Also number-of-block-arguments can matter

- Just put the block "next to" the "other" arguments (if any)
  - Syntax: {e}, {|x| e}, {|x,y| e}, etc. (plus variantions)
    - Can also replace { and } with do and end
      - Often preferred for blocks > 1 line

=end


# Blocks everywhere
=begin

- Rampant use of great block-taking methods in standard library
- Ruby has loops but very rarely used
  - Can write (0..i).each {|j| e}, but often better options

Examples
=end
a = Array.new(5) {|i| 4*(i+1)}
a.each { puts "hi" }
a.each { puts (|x| x * 2)}
a.map {|x| x * 2 } # synonym: collect
a.any? {|x| x > 7 }
a.all? {|x| x > 7 }
a.inject(0) {|acc,elt| acc + elt }
a.select {|x| x > 7 }
