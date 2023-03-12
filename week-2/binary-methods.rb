# Binary Methods with Functional Decomposition

# Binary operations
=begin

|--------| eval | toString | hasZero | ... |
| Int    |      |          |         |     |
| Add    |      |          |         |     |
| Negate |      |          |         |     |
| ...    |      |          |         |     |

- Situation is more complicated if an operation is defined over multiple arguments that can have different variants
  - Can arise in original program or after extension

- Function decomposition deals with this much more simply

=end


# Example
=begin

To show the issue:
  - Include variants String and Rational
  - (Re)define Add to work on any pair of Int, String, Rational
    - Concatenation if either argument a String, else math

Now just defining the addition operation is a different 2D grid:

-----------| Int | String | Rational |
| Int      |     |        |          |
| String   |     |        |          |
| Rational |     |        |          |

=end
