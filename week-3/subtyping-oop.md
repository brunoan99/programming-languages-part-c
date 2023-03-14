# Subtyping for OOP

## An object is...

- Objects: mostly records holding fields and methods
  - Fields are mutable
  - Methods are immutable functions that also have acceess to self

- So could desing a type system using typees very much like record types
  - Subtypes could have extra fields and methods
  - Overriding methods could have contravariant arguments and \
    covariant results compared to method overridden
    - Soud only because method "slots" are immutable

## Actual Java/C#

Compare/contrast to what our "theory" allows:

1. Types are class names and subtyping are explicity subclassess

2. A subclass can add fields and methods

3. A subclass can override a method with a covariant return type
  - (No contravariant arguments; instead makes it a non-overriding method of the same name)

(1) Is a subset of what is sound (so also sound)

(3) Is a subset of what is sound and a different choice (adding method instead of overriding)
<br/>

## Classes vs. Types

- A class defines an object's behavior
  - Subclassing inherits behavior and changes it via extension and overriding

- A type describes an object's methods argument/result types
  - A subtype is substitutable in terms of its field/method types

- These are separate concepts: try to use the terms correctly
  - Java/C# confuse them by requiring cusblasses to be subtypes
  - A class name is both a class and a type
  - This confusion is convenient in practice

## More details

Java and C# are sound: They do not allow subtypes to do things that would lead to "method missing" or accessing a field at the wrong type

Confusing (?) Java examples:
  - Subclass can declare field name already declared by superclass
  - Two classes can use any two types for the field name
  - Instance of subclass have two fields with same name
  - "Which field is in scope" depends on which class defined the method

## self/this is special

- Recall our Racket encoding of OOP-style
  - "Objects" have a list of fields and a list of functions that take self as an explicit extra argument

- So if self/this is a function argument, is it contravariant?
  - No, it is covariant: a method in a subclass can use fields \
    and methods only available in the subclasses: essential for OOP
  ```java
  class A {
    int m() { return 0; }
  }
  class B extends A {
    int x;
    int m() { return x; }
  }
  ```

  - Sound because calls always use the "whole object" for self
  - This is why coding up your own objects manually works much less well in a statically typed language
