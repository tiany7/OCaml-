# Welcome to Programming Languages and Translators


As this course is entirely taught out of OCaml, it's imperative that you
become comfortable with functional programming. There is [exposition](exposition_hw1.md) for this assignment
writeup, but we also recommend consulting these [slides](https://www.cs.columbia.edu/~rgu/courses/4115/spring2020/lectures/ocaml.pdf).

Setup
-----
To begin install the  latest version of [OCaml]( http://www.ocaml.org/docs/install.html#Ubuntu-Ubuntu-18-10).

To ensure that you installed everything correctly, 
create a __test.ml__ file with the following content:

```ocaml
let rec apply_n f n x = if n = 0 then x  
        else apply_n f (n - 1) (f x)  
in  
let plus a b = apply_n ((+) 1) b a in  
let mult a b = apply_n ((+) a) b 0 in  
let output = plus (mult 2 4) 1 in  
(** 2 * 4 + 1 **)
Printf.printf "Output: %d\n" output;  
(** Output: 9 **)  
 ```

Now we can test the compilation by running:

```bash
> ocamlopt -o test.exe test.ml  
> ./test.exe  
```

There should be no compiler warnings or errors, and the output should be exactly:
```
Output: 9  
```

Alternatively you can confirm it with the submission framework described below.


Submission
------------

For submission, we will be using GitHub Classroom. Submit a definition of all the relevant functions collected into a file called *submission_hw1.ml*. To test your submission, we will basically append (using `open`) *submission_hw1.ml* to a suite of unit tests. Although there are many brute force solutions that exists to solve these problems, getting in the habit of writing elegant and maintainable code will pay-off handsomely as the course progresses.

Start by accepting the invitation to the Github Classroom [https://classroom.github.com/a/-sEM78u5](https://classroom.github.com/a/-sEM78u5) then cloning the template and unit tests from the repository. You should also be able to access it through `githubclassroom` link in Canvas.

**DUEDATE: October 5, 2022 at 11:59pm**

To test the compilation, run 
```bash
> ocamlopt -o a.out submission_hw1.ml unit_tests_hw1.ml
> ./a.out
```
We have placed dummy implementations to make it compile so you'll have to overwrite those. Please be aware that the `unit_tests_hw1.ml` only indicate a couple of examples and we will be testing more comprehensively to ensure that the submission is correct. In other words, passing the `unit_tests_hw1.ml` doesn't guarantee you a perfect score. You should write your own tests.

You should see the following output: 
```bash 
Unit tests:
  Setup:
  Output: 9
Problem 1:
  OOPS
Problem 3.A:
  OOPS
Problem 3.B:
  OOPS
Problem 4:
  OOPS
Problem 5:
  OOPS
Problem 6:
  OOPS
Problem 7.A:
  OOPS
Problem 7.B:
  OOPS
```

# Exposition

If you're wondering about good coding standards check out the [Jane Street
Style Guide](https://opensource.janestreet.com/standards/). Also, we
highly recommend taking a peak at [Real World
Ocaml](https://dev.realworldocaml.org/guided-tour.html). They provide a
great introduction to the skills needed for successfully programming in
OCaml.

Here we have compiled helpful exposition to guide you through the first assignment.


## First-Class Functions (Problem 1-3)
<a name="P1to3"></a>

Let Expression
-----------------

In OCaml, there are variables and values. The way we define a new variable is by a let expression:

```ocaml
let var = val in expr
```
so now `var` is 'in-scope' for the duration of `expr`. Further, 
the let expression (as indicated by the name) is an expression itself and evaluates to the result of `expr`. For example, `let i = 1 in i` evaluates to 1. In fact, what we mean by value is no different than an expression. So although `let x = (let i = 1 in i) in (let y = 1 in y + x)` is a really obnoxious way of writing `2`, please note that `i` is no longer in-scope in `(let y = 1 in y + x)`.

**First-Class Functions**
The most notable difference between OCaml and an imperative (procedural) language
like C/C++ is the treatment of functions as first-class. By first-class,
we mean functions themselves can be the arguments and return values of a
function, in essence they're treated like any other value. In a functional language (compared to
imperative languages), we tend to describe to the computer how a function transforms data as opposed to detailed steps to execute.

As you may have encountered before in JavaScript or Python, the most
fundamental way of defining functions in OCaml is anonymous functions
not even giving it a name. We use the `fun` keyword much like `"`
indicates the definition of a string:

```ocaml
(fun a b -> a + b); 
```

Although the function doesn't have a name we can apply it to arguments by supplying the arguments immediately after the function just as you would with lambda calculus: 

```ocaml
(fun a b -> a + b) 2 3;
(** 2 + 3 **) 
```

Further, since we treat functions just like any other value we can define variables which are functions. For example,

```ocaml
let plus = (fun a b -> a + b) in
```

But because defining a function by name is so common, OCaml has essentially included a built-in macro which lets us write the above in a more readable format:

```ocaml
let plus a b = a + b in
```

This is called syntactic sugar.

Types
----------

It's worth noting that OCaml has a powerful type-inference engine that will at compile time check if the types match. To quickly see the types of expressions, use the command-line interpretor launched by `> ocaml`, you can see the type of an expression by typing it followed by `;;\n`. In the case of a let expression you can also replace `in` with `;;`. 

Sometimes a type can't be completely inferred. This leads to polymorphism, we'll decide the type of the function when it's applied later. Consider the identity function: `(fun x -> x)`, as written, it can take an input of any type but will always return a value of the same type. In the command-line OCaml interpreter we'll see the following type reported:

```ocaml 
- : 'a -> 'a = <fun>
```

The `'a` indicates that the type could not be inferred while `->` indicates a function. If there are multiple arguments we'll see a chain of arrows with the last thing pointed to as the return type. For example, 

```ocaml 
# (fun x y -> x);;
- : 'a -> 'b -> 'a = <fun> 
``` 

Finally, we can restrict the types of inputs and outputs by explicitly annotating the type as follows. The last `: <type>` denotes the return type. 

```ocaml
let plus (a: int) (b : int) : int = a + b in
```

Recursion
---------------

Note though that if function declarations are truly variable declarations where the value is a function, then how are recursive functions possible? 
Surely, based on our C/C++ intuition, it would be completely nonsense to say `int x = x + 1`. But, based on OCaml's allowance of variables to be functions `let fac = (fun n -> if n = 1 then 1 else n * fac (n - 1))` would be the most sensible way of writing a factorial function. 

OCaml's answer to the dilemma is to ask you as the coder to indicate with the `rec` keyword when the "`fac`" name should be visible in the definition. You'll note if you try our earlier example of `let rec x = x + 1` that OCaml will reject this and is indeed smart enough to determine if the variable is a function or not.

We use the `and` keyword to extend this to mutually recursive functions; for example:
```ocaml
let f x = if x = 0 then 0 else g x
and g x = f (x - 1) in
```

----------------------------


## Lists Type Check: Abstract Data Type and Lists (Problem 4-6)

<a name="P4to6"></a>

**Helpful List API Functions**
Here are a list of must know functions and the associated type definition. `'a` represents an arbitrary type which will be determined when the function gets applied.
- `List.hd l`: returns first element of list
   ```ocaml
   - : 'a list -> 'a
   ```
- `List.tl l`: returns the list without the first element
   ```ocaml
   - : 'a list -> 'a
   ```
- `List.rev l`: reverses the list values
      ```ocaml
      - : 'a list -> 'a list
      ```
- `List.map f l`: returns a new list having applied f to each element in l
   ```ocaml
    - : ('a -> 'b) -> 'a list -> 'b list
    ```
- `List.fold_left f val0 [l1; l2; ...; ln]`: applies a function to each element of a list with the accumulated value up to that point, starting with the val0 argument as the first value.

   (e.g. `List.fold_left (+) 4 [1, 2, 3]` evaluates to `((4+1)+2)+3`, or more generally `List.fold_left f val0 [l1; l2; l3; ...]` evaluates to `f (... f (f val0 l1) l2) ...) ln`
   ```ocaml 
   - : ('a -> 'b -> 'a) -> 'a -> 'b list -> 'a
   ```

Three additional built-in features:
- `[]` defines an empty list
- `element :: list` adds `element` to the front of `list`
- `l1 @ l2` appends l1 and l2 (note much slower than `::` operator)

**Partially Applied Functions**
As you are writing helper functions, you may sometimes find it useful to write a function and then only partially evaluate it. You can do this with a feature called currying. Consider this example:

```ocaml
let helper upperbound x y = if y < upperbound then x + y else x in 
let sum_if_more_than upperbound l = List.fold (helper upperbound) 0 l
```

In the second line, we supplied `upperbound` as the first argument to `helper`, resulting in a new function of only two variables.

**Abstract Data Types & Pattern Matching**
You can define your own types by enumerating all the possibilities. This allows you to do richer things than just combinations of built-in types. In fact, lists can be implemented as an Abstract Data Type. 

```ocaml 
type 'a list =
  | Empty 
  | Cons of 'a * 'a list
```

We call each of the names immediately right of the `|` the constructor. Here we defined a list inductively to be either an empty list or `Cons` constructor which takes a list element and the remainder of the list. 

Since this list representation has a finite number of cases to cover, we can define map this way:

```ocaml 
let rec my_map f l = 
  match l with
  | Empty -> Empty
  | Cons (hd, tl) -> Cons (f hd, my_map f tl)
```

We can use the `function` keyword as syntactic sugar to indicate that the match should occur on the last argument (implicit) and `_` to designate the default case. Using the built-in list type, this would look like the following.

```ocaml 
let rec my_map f = function
  | hd :: tl -> f hd :: my_map f tl
  | _ -> []
```

Note that pattern can occur anywhere not necessarily immediately the `=` in a let expression. Also, a case within the pattern can contain a let expression. Further, you can implicitly match using let statements.
For example, below `l` is a list of int pairs and `f` returns the sum of `x+1` and the values in the first pair.

```ocaml
let f l x =
  let y = x + 1 in 
  match l with 
  | [] -> raise (Failure "empty list")
  | hd :: _ -> 
    let (a,b) = hd in
    a + b + y

(** val f : (int * int) list -> int -> int **)
(** f [(3,4);(5,6)] 2 => 10 **)
```



