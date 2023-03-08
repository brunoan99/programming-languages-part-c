# Arrays

# Ruby Arrays
=begin

- Lots of special syntax and many provided methods for the Array class

- Can hold any number of other objects, indexed by number
  - Get via a[i]
  - Set via a[i] = e

- Compared to arrays in many other languages
  - More flexible and dynamic
  - Fewer operations are errors
  - Less efficient

- "The standard collection" (like lists were in ML and Racket)

=end

# Examples

a = [3, 2, 1, 0]

# a[0] -> 3
# a[1] -> 2
# a[2] -> 1
# a[3] -> 0

# a.size -> 4

# a[4] -> nil   | for any i >= a.size will return nil

# a[-1] -> 0
# a[-2] -> 1
# a[-3] -> 2
# a[-4] -> 3
# a[-5] -> nil  | for any i < a.size will return nil

a[1] = 6 # updates the second position to 6
# a -> [3,6,1,0]

a[6] = 14
# this will not return an error, instead will create the n positions needed to fill 6 with 14, and the remaining created positions will get nil vaue
# a -> [3,6,1,0,nil,nil,14]

# a.size -> 7, even nil positions count to the size

a[0] = "hi"
# a -> ["hi",6,1,0,nil,nil,14]

b = a + [true, false]
# + returns the second array appended to the first
# b -> [3,6,1,0,nil,nil,14,true,false]

c = [3,2,3] | [1,2,3]
# | return the append of arrays but removing duplicated values
# c -> [3,2,1]

d = Array.new(5)
# d -> [nil,nil,nil,nil,nil]

e = Array.new(5) { 0 }
# d -> [0,0,0,0,0]

f = Array.new(5) {|i| -i}
# f -> [0,-1,-2,-3,-4]

a.push 7
# adds an element to the right side
# a -> ["hi",6,1,0,nil,nil,14,7]

a.pop
# a.pop -> 7
# return the element on the right side of the array
# a -> ["hi",6,1,0,nil,nil,14]

# using push and pop we get a stack

a.shift
# a.shift -> "hi"
# return the element on the left side of the array
# a -> [6,1,0,nil,nil,14]

# using push and shift we get a queue

g = f + []
# g will have the same items of f, but g will not be an alias to f
# then
f[0] = 1
# f -> [1,-1,-2,-3,-4]
# g -> [0,-1,-2,-3,-4]

h = a[2,4]
# the expression 'a[2,4]' is a way to do a slice of the array 'a' starting from the position '2' and catching '4' positions
# h -> [1,0,nil,nil]
