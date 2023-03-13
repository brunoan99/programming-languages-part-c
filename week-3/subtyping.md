# Subtyping From the Beginning

## A tiny language

- Can cover most core subtyping ideas by just considering **records with mutable fields**
- Will make up our own syntax
  - ML has records, but no subtyping or field-mutation
  - Racket and Ruby have no type system
  - Java uses class/interface names and rarely fits on a slide
<br/>

## Records (half like ML, half like Java)

Record **creation** (fieeld names and contents): \
  &ensp;&ensp;{f1=e1, f2=e1, ..., fn=en} \
  &ensp;&ensp;Evaluate ei, make a record

Record field **access**: \
  &ensp;&ensp;e.f \
  &ensp;&ensp;Evaluate e to record v with an f field, get contents of f field

Record field **update**:\
  &ensp;&ensp;e1.f = e2 \
  &ensp;&ensp;Evaluate e1 to a record v1 and e2 to a value v2; \
  &ensp;&ensp;Changes v1's f field (which must exist) to v2; \
  &ensp;&ensp;Return v2
<br/>

## A Basic Type System

Record types: What fields a record has and type for each field \
  &ensp;&ensp;&ensp;{f1:t1, f2:t2, ..., fn:tn}

Type-checking expressions:
- If e1 has type t1, ..., en has type tn, then {f1=e1, ..., fn=en} has type {f1:t1, ..., fn:tn}
- If e has a record type containing f:t, then e.f haas type t
- IF e1 has a record type containing f:t, and e2 has type t, then e1.f = e2 has type t
<br/>

## This is safe

These evaluation rules and typing rules prevent ever trying to access a field of a record that does not exists

Example program that type-checks (in a made-up language):

```
fun distToOrigin (p:{x:real,y:real}) =
  Math.sqrt(p.x*p.x + p.y*p.y)

val pythag : {x:real,y:real} = {x=3.0, y=4.0}
val five : real = distToOrigin(pythag)
```
<br/>

## Motivating subtyping

But according to our typing rules, this program does not type-check
  - It does nothing wrong and seems worth supporting


```
fun distToOrigin (p:{x:real,y:real}) =
  Math.sqrt(p.x*p.x + p.y*p.y)

val c : {x:real,y:real,color=string} = {x=3.0, y=4.0, color="green}
val five : real = distToOrigin(c)
```
<br/>

## A good idea: allow extra fields

Natural idea: If an expression has type

&ensp;&ensp;&ensp;{f1:t1, f2:t2, ..., fn:tn}

Then it can also have a type with some fields removed

This is what we need to type-check these function calls:

```
fun distToOrigin (p:{x:real,y:real}) =
  Math.sqrt(p.x*p.x + p.y*p.y)
fun makePurple (p:{color.string}) = p.color = "purple"

val c : {x:real,y:real,color=string} = {x=3.0, y=4.0, color="green}
val _ = distToOrigin(c)
val _ = makePurple(c)
```
<br/>
