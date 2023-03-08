# Hashes and Ranges

# More collections
=begin

- Hashes like array but:
  - Keys can be anything; strings and symbols common
  - No natural ordering like numeric indices
  - Different syntax to make them
  Like a dynamic record with anything for field names
  - Often pass a hash rather than many arguments

- Ranges like arrays of contiguous numbers but:
  - More efficiently represented, so large ranges fine

Good style to:
  - Use ranges when you can
  - Use hashes when non-numeric keys better represent data

Examples:
=end
h1 = {} # Or use Hash.new
h1["a"] = "Any String"

h1[false] = "Any Boolean"
# Keys don't even needs to be the same type

h1[1] = 1
# And like keys the values doesn't needs to be the same type too

# h1 -> {"a"=>"Any String", false=>"Any Boolean", 1=>1}

# ask for a index that doesn't exists return nil
# h1[42] -> nil

# unlike arrays a hash contain some methods that are not defined to arrays

# like keys, that return an array containing all hash keys
h1.keys
# h1.keys -> ["a", false, 1]

# values, that return an array containing all hash values
h1.values
# h1.values -> ["Any String", false, 1]

h2 = {"SML"=>1, "Racket"=>2, "Ruby"=>3} # define a hash with values directly

h2.each {|k,v| print k; print ": "; puts v}
# SML: 1
# Racket: 2
# Ruby: 3


# Ranges

(1..100) # a range that starts in 1 and ends in 100

# ranges can be used to performa computations like
(1..100).inject {|acc,elt| acc + elt }
# -> 5050


# Similar methods
=begin

- Arrays, hashes and ranges all have some methods other don't
  - E.g., keys and values

- But also have many of the same methods, particularly iterators
  - Great for duck typing

Example
=end

def foo a
  a.count {|x| x * x < 50 }
end

foo [3,4,5,6,7,8,9] # -> 5
foo (3..9) # -> 5

# Once again separating "how to iterate" from "what to do"
