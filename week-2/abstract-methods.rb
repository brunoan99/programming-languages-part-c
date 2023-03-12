# Optional: Abstract Methods

# Connections
=begin

- What does a statically typed OOP language need to support "required overriding"?

- How is this similar to higher-order functions

- Why does a language with multiple inheritance (e.g., C++) not need Java/C#-style interfaces?

=end


# Required overriding
=begin

Often a class expects all subclasses to override some methods(s)
  - The purpose of the superclass is to abstract common functionality, but some non-common parts have no default

A Rubty approach:
  - Do not define must-override methods in superclass
  - Subclasses can add it
  - Creatuing instance of superclass can cause method-missing error

  ```ruby
    class A
      def m1 v
        ... self.m2 e ...
      end
    end
  ```

=end


# Static typing
=begin

- In Java/C#/C++, prior approach fails type-checking
  - No method m2 deefined in superclass
  - One solution: provide error-casuing implementation

  ```ruby
    class A
      def m1 v
        ... self.m2 e ...
      end
      def m2 v
        raise "must be overriden"
      end
    end
  ```
  - Better: Use static checking to prevent this error...

=end


# Abstract methods
=begin

- Java/C#/C++ let superclass give signature (type) of method subclasses should provide
  - Called abstract methods or pure virtual methods
  - Cannot creates instances of classes with such methods
    - Catches error at compile-time
    - Indicates intent to code-reader
    - Does not make language more powerful

    ```java

      abstract class A {
        T1 m1(T2 x) { ... m2(e); ... }
        abstract T3 m2(T4 x);
      }

      class B extends A {
        T3 m2 (T4 x) {...}
      }

    ```

=end


# Passing code to other code
=begin

- Abstract methods and dynamic dispatch: An OOP way to have subclass "pass code" to other code in superclass

  ```java

    abstract class A {
      T1 m1(T2 x) { ... m2(e); ... }
      abstract T3 m2(T4 x);
    }

    class B extends A {
      T3 m2 (T4 x) {...}
    }

  ```
- Higher-order functions: An FP way to have caller "pass code" to callee

  ```sml
    fun f (g, x) = ... g x ...

    fun h x = f((fn y => ...)), ...)

  ```

=end


# No interfacees in C++
=begin

- If you have multiple inheritance and abstract methods, you do not also need interfaces

- Replace each interface with a class with all abstract methods

- Replace each "implements interface" with another superclass

So: Expect to see interfaces only in statically typed OOP without multiple inheritance
  - Not Ruby
  - Not C++

=end
