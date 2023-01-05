# Welcome to Programming Languages and Translators

As this course is entirely taught out of OCaml, it's imperative that you
become comfortable with functional programming. There is [exposition](exposition_hw1.md) for this assignment 
writeup, but we also recommend consulting these [slides](https://www.cs.columbia.edu/~rgu/courses/4115/spring2022/lectures/ocaml.pdf).

Setup
-----
To begin install the latest version of [OCaml]( http://www.ocaml.org/docs/install.html#Ubuntu-Ubuntu-18-10).

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
Warm Up: First-class Functions
-------

If you're wondering about good coding standards check out the [Jane Street
Style Guide](https://opensource.janestreet.com/standards/). Also, we
highly recommend taking a peak at [Real World
Ocaml](https://dev.realworldocaml.org/guided-tour.html). They provide a
great introduction to the skills needed for successfully programming in
OCaml.

[Click for Exposition](exposition_hw1.md#P1to3)



**Problem 1**

Now in a similar fashion to `plus` (using `apply_n`), define `expon` a function that takes the first argument to the power
of the second argument.

` let expon a b = (** YOUR CODE HERE **)`

__Example__ 
`expon 4 5 (** => 1024 **)`

**Problem 2** 

How does OCaml know that `=` in `apply_n f n x = ...` is assignment
whereas `=` in `n = 0` is comparison?

*Write it as a comment in the submission file*

**Problem 3 Part A**

For this problem, let's write a partial sum function called `psum f`. For example, `psum (fun x -> x * x )` equates to the following function of n.
```
f (n) = 1 * 1 + 2 * 2 + ... + n * n
```
There are several twists:
1. We want to always start our index (n) from one, and we allow only positive integers 
(raise (Failure "Argument Not Positive").
2. We allow the caller to define what `f` describes the sum. 
3. We want to return a function (specifically a function awaiting the value of n)

<details><summary> Click for Sample Unit Test <br> <br></summary>
<p>

-------------------------------

```ocaml
let f x = 3 * x * x + 5 * x + 9 in (** f (x) = 3x^2 + 5x + 9 **)
let partial_sum = psum f in
if partial_sum 1 = 17
&& partial_sum 5 = 285
then print_string "YAY" else raise (Failure "OOPS");
```

----------------------------
</p>
</details>

NB: Notice that the type of this function is 
` psum: (int -> int) -> (int -> int)` 
which is to say a function which takes one arguments 
a function (which takes a int to int) and  returns another function (int to int). 

**Problem 3 Part B**

In OCaml, arithmetic operators like `+` are only for int; there are another set of them for float: `+.`, so what if we want to use floats instead or do products instead of sums. 
We can use polymorphism to abstract away the actual operation used to accumulate. 
So now we define the function `partial` which will require an additional input function for how to combine consecutive terms. Note that the input `f` has to take as input an integer representing the position in the series.

```ocaml 
let rec partial accum f = 
  (** YOUR CODE HERE **)  
```

Note that partial has type 

```ocaml 
val partial: ('a -> 'a -> 'a) -> (int -> 'a) -> int -> 'a
```

Just as we wished, we can have a version that handles floats, 

<details><summary> Click for Sample Unit Test <br> <br></summary>
<p>

-------------------------------

```ocaml
let f x = 3 * x * x + 5 * x + 9 in (** f (x) = 3x^2 + 5x + 9 **)
let g x = (** g (x) = 3x^2 + 5x + 9 **)
  let x = float_of_int x in
  3. *. x *. x +. 5. *. x +. 9.
in

let partial_sum = partial (+) f in
let fpartial_sum = partial (+.) g in
if fpartial_sum 1 = 17.
&& fpartial_sum 5 = 285.
&& partial_sum 1 = 17
&& partial_sum 5 = 285
then print_string "YAY" else raise (Failure "OOPS");
```

----------------------------
</p>
</details>

Try it on products to confirm you implemented it correctly.

Lists Type Check: Abstract Data Type and Lists
----------------

Just as imperative programs have arrays, the go-to workhorse data structure in OCaml are lists. Take a look at the [ocaml manual](https://caml.inria.fr/pub/docs/manual-ocaml/libref/List.html) for a great introduction to the `List` module in the Standard Library . 

[Click for Exposition](exposition_hw1.md#P4to6)

**Problem 4** 
Write `maxrun`, a function which returns the length of the longest sublist of negative or non-negative numbers and a list of absolute values of the original list elements. Ensure that this list is in the same order.

To report multiple outputs, use a record. We'll define this particular output record as `run_output`:

```ocaml 
type run_output = 
{  length : int;
   entries : int list;
}
```

Template:

```ocaml
let maxrun (l:int list) : run_output = 
  (** YOUR CODE HERE **)
```

<details><summary> Click for Sample Unit Test <br> <br></summary>
<p>

-------------------------------

```ocaml
let out = moveNeg [8; -5; 3; 0; 10; -4] in
if out.length = 3
&& out.entries = [8; 5; 3; 0; 10; 4]
then print_string "YAY" else raise (Failure "OOPS");
```

----------------------------
</p>
</details>
 


**Problem 5**
Given the following typed representation of lists which allows only for ints and bools and if an typed expression (texpr), write a `check`, with the type, `val check: texpr -> bool` which checks this. Note that the `*` indicates it's a tuple, and so we have that texpr is a tuple of a type and an expression. Also, the `and` keyword allows the definition of expr to see texpr and vice versa. This is called mutual recursion.

```ocaml
type ty = Int | Bool | List of ty
type texpr = ty * expr
and expr = 
  | IntLit of int
  | BoolLit of bool
  | Seq of texpr list

let rec check texpr = 
  (** YOUR CODE HERE **)
```

Here's an example of a well-typed texpr:

```ocaml
let posExample = 
  (List (List Int),
    Seq
     [ (List Int, Seq [(Int, IntLit 4); (Int, IntLit 2); (Int, IntLit 0)]);
       (List Int, Seq []) ])
```

and an example of an incorrectly typed texpr (return false):

```ocaml
let negExample = 
  (List Bool,
    Seq
      [ (Bool, IntLit 9);
        (List Bool, Seq [(Bool, BoolLit false); (Bool, BoolLit true)]);
        (Bool, BoolLit true) ])
```

Note you need to check that 
- each tuple is correctly typed
- each list is correctly typed
- nested lists are also correct
- if the Seq has an empty list of texpr, any List type is legal

**Problem 6** 

Note that we can actually infer the type of an texpr. If we see `(x, IntLit (8))`, we know `x` should be an Int.
So now write a similar function `infer` which overwrites any incorrect types. 

```ocaml
val infer: texpr -> texpr
```

Note:
- if an empty list is encountered, `raise (Failure "empty list")`
- if a list has inconsistent types, `raise (Failure "inconsistent")`
- list order is preserved

`negExample` from Problem 5 should be inconsistent. 

```ocaml
let infExample =  
  (List Int,
    Seq
      [ (Int, Seq [(Bool, BoolLit false); (Bool, BoolLit true)]);
        (Bool, Seq [(Int, BoolLit true)]) ])
in 
infer infExample 

```
evaluates to

```ocaml
  (List (List Bool),
   Seq
     [ (List Bool, Seq [(Bool, BoolLit false); (Bool, BoolLit true)]);
       (List Bool, Seq [(Bool, BoolLit true)]) ])  
``` 



