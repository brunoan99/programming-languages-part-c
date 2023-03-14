# Function Subtyping

## Now functions

- Already know a caller can use subtyping for arguments passed
  - Or on the result

- More interesting: When is one function type a subtype of another?

  - Important for higher-order functions: If a function expects an \
    argument of type t1 -> t2, can you pass a t3 -> t4 instead ?

  - Important for understanding methods
    - (An object type is a lot like a reecord type where "method positions" \
      are immutable and have function types)
<br/>

## Example

```ml
fun distMoved (f: {x:real,y:real}->{x:real,y:real},
               p: {x:real,y:real}) =
  let val p2 : {x:real,y:real} = f p
      val dx : real = p2.x - p.y
      val dy : real = p2.y - p.y
  in Math.sqrt(dx*dx + dy*dy) end

fun flip p = {x = ~p.x, y=~p.y}
val d = distMoved(flip, {x=3.0, y=4.0})

```

No subtyping here yet:
  - flip has exactly the type distMoved expects for f
  - Can pass in a record with extra fields for p, but that's old news
<br/>

## Return-type subtyping

```ml
fun distMoved (f: {x:real,y:real}->{x:real,y:real},
               p: {x:real,y:real}) =
  let val p2 : {x:real,y:real} = f p
      val dx : real = p2.x - p.y
      val dy : real = p2.y - p.y
  in Math.sqrt(dx*dx + dy*dy) end

fun flipGreen p = {x = ~p.x, y=~p.y, color="green"}
val d = distMoved(flipGreen, {x=3.0, y=4.0})

```

- Return type of flipGreeen is {x:real,y:real,color:string}, \
  but distMoved expects a return type of {x:real,y:real}

- Nothing goes wrong: **If** ta <: tb, **then** t->ta <: t->tb
  - A function can return "more than it needs to"
  - Jargon: "Return types are covariant"
<br/>

## This is wrong

```ml
fun distMoved (f: {x:real,y:real}->{x:real,y:real},
               p: {x:real,y:real}) =
  let val p2 : {x:real,y:real} = f p
      val dx : real = p2.x - p.y
      val dy : real = p2.y - p.y
  in Math.sqrt(dx*dx + dy*dy) end

fun flipIfGreen p = if p.color = "green"
                  then {x= ~p.x, y=~p.y}
                  else {x = p.x, y=p.y}
val d = distMoved(flipIfGreen, {x=3.0, y=4.0})

```

- Argument type of flipIfGreen is \
  {x:real,y:real,color:string}, but it is called with a \
  {x:real,y:real}

- Unsound! ta <: tb does **NOT** allow ta->t <: tb->t
<br/>

## The other way works!

```ml
fun distMoved (f: {x:real,y:real}->{x:real,y:real},
               p: {x:real,y:real}) =
  let val p2 : {x:real,y:real} = f p
      val dx : real = p2.x - p.y
      val dy : real = p2.y - p.y
  in Math.sqrt(dx*dx + dy*dy) end

fun flipX_Y0 p = {x = ~p.x, y=0.0}
val d = distMoved(flipX_Y0, {x=3.0, y=4.0})

```

- Argument type of flipX_Y0 is {x:real} but it is called with a \
  {x:real,y:real}, which is finee

- If tb <: ta, then ta -> t <: tb -> t
  - A function can assume "less than it needs to" about arguments
  - Jargon: "Argument types are contravariant"
<br/>

## Can do both

```ml
fun distMoved (f: {x:real,y:real}->{x:real,y:real},
               p: {x:real,y:real}) =
  let val p2 : {x:real,y:real} = f p
      val dx : real = p2.x - p.y
      val dy : real = p2.y - p.y
  in Math.sqrt(dx*dx + dy*dy) end

fun flipXMakeGreen p = {x = ~p.x, y=0.0, color="green"}
val d = distMoved(flipXMakeGreen, {x=3.0, y=4.0})

```

- flipXMakeGreen has type \
  {x:real} -> {x:real,y:real,color:string}

- Fine to pass a function of such a type as function of type \
  {x:real,y:real} -> {x:real,y:real}

- If t3 <: t1 and t2 <:t4, then t1->t2<:t3->t4
<br/>

# Conclusion

- **If t3 <: t1 and t2 <: t4, then t1 -> t2 <: t3 -> t4**
  - **Function subtyping contravariant in arguments(s) and covariant in results**

- Also essential for understanding subtyping and methods in OOP
