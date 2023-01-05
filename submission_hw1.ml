(* 
 * This file is your submission for the PLT Assignment HW1 
 * Name: <YOUR NAME HERE>
 * UNI: <YOUR UNI HERE>
 * 
 *)


(** Problem 1 **)
let rec apply_n f n x =  if n = 0 then x
        else apply_n f (n - 1) (f x)  

let expon (a:int) (b:int) : int = 
  (** YOUR CODE HERE **)
  0

(** Problem 2 **)

(*
 *
 *  (** YOUR ANSWER HERE **)
 *
 *)

(** Problem 3.A **)

let rec psum (f: int -> int): int -> int =
  (** YOUR CODE HERE **)
  (fun x -> 1)

(** Problem 3.B **)

let rec partial (accum: 'a -> 'a -> 'a) (f: int -> 'a )
  : int -> 'a = 
  (** YOUR CODE HERE **)   
  f

(** Problem 4 **)

type run_output = 
{  length : int;
   entries : int list;
}

let maxrun (l: int list) : run_output = 
  (** YOUR CODE HERE **)
  {length = 1; entries =[]}

(** Problem 5 **)

type ty = Int | Bool | List of ty
type texpr = ty * expr
and expr = 
  | IntLit of int
  | BoolLit of bool
  | Seq of texpr list

let rec check (texpr:texpr): bool = 
  (** YOUR CODE HERE **)
  true


(** Problem 6 **)

let rec infer (texpr:texpr): texpr = 
  (** YOUR CODE HERE **)
  (Int,IntLit 1)

(** Problem 7.A **)

module StringMap = Map.Make(String)

type sinstr =
| SLit of int
| SVar of string
| SPlus 
| SMinus 
| SMult
| SDiv

let prog_exec_instr (symbol_table: int StringMap.t) (inst : sinstr) (stack : int list) 
  : (int list) option = 
  (** YOUR CODE HERE **)
  None


(** Problem 7.B **)

let prog_exec (symbol_table: int StringMap.t) (prog : sinstr list) : int option= 
  (** YOUR CODE HERE **)
  None


