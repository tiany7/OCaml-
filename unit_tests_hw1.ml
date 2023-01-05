
(** Unit tests **)

print_string "Unit tests:\n";

let open Submission_hw1 in

(** Setup **)

print_string "  Setup:\n";

let rec apply_n f n x = if n = 0 then x  
        else apply_n f (n - 1) (f x)  
in  
let plus a b = apply_n ((+) 1) b a in  
let mult a b = apply_n ((+) a) b 0 in  
let output = plus (mult 2 4) 1 in  
(** 2 * 4 + 1 **)
Printf.printf "  Output: %d\n" output;  
(** Output: 9 **)  

(** Problem 1 **)

print_string "Problem 1:\n  ";

if expon 4 5 = 1024
then print_string "YAY\n" else print_string "OOPS\n";

(** Problem 3.A **)

print_string "Problem 3.A:\n  ";

let f x = 3 * x * x + 5 * x + 9 in (** f (x) = 3x^2 + 5x + 9 **)
let partial_sum = psum f in
if partial_sum 1 = 17
&& partial_sum 5 = 285
then print_string "YAY\n" else print_string "OOPS\n";


(** Problem 3.B **)

print_string "Problem 3.B:\n  ";

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
then print_string "YAY\n" else print_string "OOPS\n";

(** Problem 4 **)

print_string "Problem 4:\n  ";

let out = maxrun [8; -5; 3; 0; 10; -4] in
if out.length = 3
&& out.entries = [8; 5; 3; 0; 10; 4]
then print_string "YAY\n" else print_string "OOPS\n";

(** Problem 5 **)

print_string "Problem 5:\n  ";

let posExample = 
  (List (List Int),
    Seq
     [ (List Int, Seq [(Int, IntLit 4); (Int, IntLit 2); (Int, IntLit 0)]);
       (List Int, Seq []) ])
in 
let negExample = 
  (List Bool,
    Seq
      [ (Bool, IntLit 9);
        (List Bool, Seq [(Bool, BoolLit false); (Bool, BoolLit true)]);
        (Bool, BoolLit true) ])
in

if check posExample = true
&& check negExample = false
then print_string "YAY\n" else print_string "OOPS\n";

(** Problem 6 **)

print_string "Problem 6:\n  ";

let posExample = 
  (List (List Int),
    Seq
     [ (List Int, Seq [(Int, IntLit 4); (Int, IntLit 2); (Int, IntLit 0)]);
       (List Int, Seq []) ])
in 
let negExample = 
  (List Bool,
    Seq
      [ (Bool, IntLit 9);
        (List Bool, Seq [(Bool, BoolLit false); (Bool, BoolLit true)]);
        (Bool, BoolLit true) ])
in
let infExample =  
  (List Int,
    Seq
      [ (Int, Seq [(Bool, BoolLit false); (Bool, BoolLit true)]);
        (Bool, Seq [(Int, BoolLit true)]) ])
in 
let inferred_output = 
  (List (List Bool),
   Seq
     [ (List Bool, Seq [(Bool, BoolLit false); (Bool, BoolLit true)]);
       (List Bool, Seq [(Bool, BoolLit true)]) ])  
in 

let test_pos = try Some (infer posExample) 
  with Failure err -> print_string (err ^ "\n  "); None
in 
let test_neg = try Some (infer negExample) 
  with Failure err -> print_string (err ^ "\n  "); None
in 

if test_pos = None
&& test_neg = None
&& infer infExample = inferred_output
then print_string "YAY\n" else print_string "OOPS\n";

(** Problem 7.A **)

print_string "Problem 7.A:\n  ";

let sym_tbl = StringMap.add "X" 3 StringMap.empty in
let stack = prog_exec_instr sym_tbl (SVar "X") [4] in 
let stack' = prog_exec_instr sym_tbl (SMult) [3;4] in
if stack = Some [3;4] && stack' = Some [12]
then print_string "YAY\n" else print_string "OOPS\n";


(** Problem 7.B **)

print_string "Problem 7.B:\n  ";

let sym_tbl = StringMap.add "X" 3 StringMap.empty in
let prog = [SLit 4; SVar "X"; SMult] in
if (prog_exec sym_tbl prog) = Some (12) 
then print_string "YAY\n" else print_string "OOPS\n";
