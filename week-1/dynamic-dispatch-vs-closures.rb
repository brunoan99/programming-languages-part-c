class A
  def even x
    puts "in even A"
    if x==0 then true else odd(x-1) end
  end

  def odd x
    puts "in odd A"
    if x==0 then false else even(x-1) end
  end
end

a1 = A.new.odd 7
puts "a1 is " + a1.to_s + "\n\n"

class B < A
  def even x # changes B's odd too! (helps)
    puts "in even B"
    x % 2 == 0
  end
end

class C < A
  def even x
    puts "in even C" # changes C's odd too! (hurts)
    false
  end
end

a2 = B.new.odd 7
puts "a2 is " + a2.to_s + "\n\n"

a3 = C.new.odd 7
puts "a3 is " + a3.to_s + "\n\n"


# The OOP trade-off
=begin

Any method that makes calls to overridable methods can have its behavior changed in subclasses even if it is not overridden
  - Maybe on purpose, maybe by mistake
  - Observable behavior includes calls-to-overridable methods

- So harder to reason about "the code you're looking at"
  - Can avoid by disallowing overriding
    - "private" or "final" methods

- So easier for subclasses to affect behavior without copying code
  - Provided method in superclass is not modified later

=end
