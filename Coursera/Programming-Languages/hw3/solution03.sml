
(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu


fun g f1 f2 p =
    let
	val r = g f1 f2
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)

fun only_capitals xs = List.filter (fn x => Char.isUpper (String.sub (x, 0))) xs

fun longest_string1 xs =
    foldl (fn (x, y) => if String.size x > String.size y then x else y) "" xs

fun longest_string2 xs =
    foldl (fn (x, y) => if String.size x >= String.size y then x else y) "" xs

fun longest_string_helper f xs =
    foldl (fn (x, y) => if f ((String.size x), (String.size y)) then x else y) "" xs

val longest_string3 = longest_string_helper (fn (x, y) => x > y)

val longest_string4 = longest_string_helper (fn (x, y) => x >= y)

val longest_capitalized =
    longest_string1 o only_capitals

val rev_string =
    implode o rev o explode

fun first_answer f xs =
    case xs of
        [] => raise NoAnswer
      | x::xs' => case f x of
                      NONE => first_answer f xs'
                    | SOME y => y

fun all_answers f xs =
    let fun all_answers_helper (xs, acc) =
            case xs of
                [] => SOME acc
              | x::xs' => case f x of
                              NONE => NONE
                            | SOME y => all_answers_helper (xs', acc @ y)
    in
        all_answers_helper (xs, [])
    end

val count_wildcards =
    g (fn () => 1) (fn x => 0)

val count_wild_and_variable_lengths =
    g (fn () => 1) (fn x => String.size x)

fun count_some_var (s, p) =
    g (fn () => 0) (fn x => if x = s then 1 else 0) p

fun check_pat p =
    let fun variables_in_patterns p =
            case p of
                Variable p => [p]
              | TupleP ps => foldl (fn (x, y) => y @ variables_in_patterns x) [] ps
              | ConstructorP (_, TupleP ps) => variables_in_patterns (TupleP ps)
              | _ => []
        fun no_repeat xs =
            case xs of
                [] => true
              | x::[] => true
              | x::xs' => List.exists (fn a => a <> x) xs' andalso no_repeat xs'
    in
        no_repeat (variables_in_patterns p)
    end

fun match (v, p) =
    case (p, v) of
        (Wildcard, _) => SOME []
      | (Variable s, _) => SOME [(s, v)]
      | (UnitP, Unit) => SOME []
      | (ConstP x, Const y) => if x = y then SOME [] else NONE
      | (TupleP pl, Tuple vl) => if List.length pl = List.length vl
                                 then all_answers (fn (x, y) => match (x, y)) (ListPair.zip(vl, pl))
                                 else NONE
      | (ConstructorP (s1, p), Constructor (s2, v)) => if s1 = s2 then match(v, p) else NONE
      | _ => NONE

fun first_match v ps =
    SOME (first_answer (fn p => match(v, p)) ps) handle NoAnswer => NONE

fun pattern_to_type (data_type, p) =
    case p of
        UnitP => UnitT
      | ConstP _ => IntT
      | TupleP pl => TupleT (List.map (fn x => pattern_to_type (data_type, x)) pl)
      | ConstructorP (str, p) =>
        let fun match x =
                case x of
                    (s, _, t) => s = str andalso (pattern_to_type(data_type, p) = t orelse
                                                  pattern_to_type(data_type, p) = Anything)
        in
            case List.find match data_type of
                SOME (_, a, _) => Datatype a
              | NONE => raise NoAnswer
        end
      | Variable v => Anything
      | Wildcard => Anything

fun type_merge (type1, type2) =
    let fun tuple_compare (t1, t2) =
            if length t1 <> length t2
            then raise NoAnswer
            else case (t1, t2) of
                     ([],[]) => []
                   | (x::xs', y::ys') => (type_merge (x, y))::tuple_compare(xs', ys')
                   | _ =>  raise NoAnswer
    in
        case (type1, type2) of
            (Anything, _) => type2
          | (_, Anything) => type1
          | (IntT, IntT) => IntT
          | (UnitT, UnitT) => UnitT
          | (Datatype a, Datatype b) => if a = b then type1 else raise NoAnswer
          | (TupleT t1, TupleT t2) => TupleT(tuple_compare(t1, t2))
          | (_, _) => raise NoAnswer
    end

fun typecheck_patterns (data_type, patterns) =
    SOME (foldl (fn (x, y) => type_merge(pattern_to_type (data_type, x), y)) Anything patterns)
    handle NoAnswer => NONE
