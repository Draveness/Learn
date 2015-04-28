(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)

fun all_except_option (str, []) = NONE
  | all_except_option (str, x::xs) =
    case (same_string(str,x), all_except_option(str,xs)) of
        (true, _) => SOME xs
      | (false, NONE) => NONE
      | (false, SOME y) => SOME(x::y)

fun get_substitutions1 ([], s) = []
  | get_substitutions1 (x::xs,s) =
    case all_except_option(s,x) of
        NONE => get_substitutions1(xs,s)
      | SOME y => y @ get_substitutions1(xs,s)

fun get_substitutions2 (xs, s) =
    let fun aux ([], s, acc) = acc
          | aux (y::ys, s, acc) =
            case all_except_option(s,y) of
                NONE   => aux(ys, s, acc)
              | SOME m => aux(ys, s, acc @ m)
    in
        aux(xs, s, [])
    end

fun similar_names (xs, {first = a, middle = b, last = c}) =
    let fun aux ([], x, acc) = x::acc
          | aux (x::xs, {first = _, middle = b, last = c}, acc) =
            aux(xs, {first = a, middle = b, last = c}, acc @ [{first = x, middle = b, last = c}])
    in
        aux(get_substitutions1(xs,a), {first = a, middle = b, last =c}, [])
    end

(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw

exception IllegalMove

(* put your solutions for problem 2 here *)

fun card_color (Hearts, _)   = Red
  | card_color (Clubs, _)    = Black
  | card_color (Diamonds, _) = Red
  | card_color (Spades, _)   = Black

fun card_value (_, Num i) = i
  | card_value (_, Ace)   = 11
  | card_value (_, _)     = 10

fun remove_card ([], _, ex) = raise ex
  | remove_card (x::xs, c, ex) =
    if x = c
    then xs
    else x::remove_card(xs, c, ex)

fun all_same_color ([]) = true
  | all_same_color (hd::(nk::tl)) =
    if card_color(hd) = card_color(nk)
    then all_same_color(nk::tl)
    else false
  | all_same_color (hd::tl) = true

fun sum_cards cards =
    let fun aux ([], acc) = acc
          | aux (x::xs, acc) = aux (xs, acc + card_value(x))
    in
        aux(cards, 0)
    end

fun score (cards, goal) =
    let val sum = sum_cards(cards) in
        case (sum > goal, all_same_color(cards)) of
            (true, true)  => 3 * (sum - goal) div 2
          | (true, false) => 3 * (sum - goal)
          | (false, true) => (goal - sum) div 2
          | (false, false) => goal - sum
    end

exception IllegalMove

fun officiate (cards, moves, goal) =
    let fun aux (cards, moves, held_cards) =
            case (cards, moves, held_cards) of
                (cards, [], held_cards) => score(held_cards, goal)
              | ([], move::remain, held_cards) =>
                (case move of
                     Draw => score(held_cards, goal)
                   | Discard c => aux([], remain,
                                      remove_card(held_cards, c, IllegalMove)))

              | (card::deck, move::remain, held_cards) =>
                (case move of
                     Draw => if sum_cards(card::held_cards) >= goal
                             then score(card::held_cards, goal)
                             else aux(deck, remain, card::held_cards)
                   | Discard c => aux(card::deck, remain,
                                      remove_card(held_cards, c, IllegalMove)))

    in
        aux(cards, moves, [])
    end

fun card_value_ace (_, Num i) = i
  | card_value_ace (_, Ace) = 1
  | card_value_ace (_, _) = 10

fun sum_cards_ace (cards) =
    let fun aux ([], acc) = acc
          | aux (x::xs, acc) = aux (xs, acc + card_value_ace(x))
    in aux (cards, 0) end

fun score_ace (cards, goal) =
    let val sum = sum_cards_ace(cards) in
        case (sum > goal, all_same_color(cards)) of
            (true, true) => 3 * (sum - goal) div 2
          | (true, false) => 3 * (sum - goal)
          | (false, true) => (goal - sum) div 2
          | (false, false) => goal - sum
    end

fun score_challenge (cards, goal) =
    if (score(cards, goal) > score_ace(cards, goal))
    then score_ace(cards, goal)
    else score(cards, goal)


fun officiate_challenge (cards, moves, goal) =
    let fun aux (cards, moves, held_cards) =
            case (cards, moves, held_cards) of
                (cards, [], held_cards) => score_challenge(held_cards, goal)
              | ([], move::remain, held_cards) =>
                (case move of
                     Draw => score_challenge(held_cards, goal)
                   | Discard c => aux([], remain,
                                      remove_card(held_cards, c, IllegalMove)))

              | (card::deck, move::remain, held_cards) =>
                (case move of
                     Draw => if sum_cards (card::held_cards) > goal andalso
                                sum_cards_ace (card::held_cards) > goal
                             then score_challenge(held_cards, goal)
                             else aux(card::deck, remain, card::held_cards)
                   | Discard c => aux(card::deck, remain,
                                      remove_card(held_cards, c, IllegalMove)))

    in
        aux(cards, moves, [])
    end

fun discard ([], offset) = NONE
  | discard (card::remain, offset) = if card_value(card) = offset
                                     then SOME card
                                     else discard (remain, offset)

fun careful_helper (cards, goal) =
    let fun aux ([], goal, held_cards, moves) = moves
          | aux (head::neck::deck, goal, held_cards, moves) =
            (if sum_cards(head::held_cards) = goal
             then moves @ [Draw]
             else if sum_cards(held_cards) < goal - 10
             then aux(neck::deck, goal, head::held_cards, moves @ [Draw])
             else case discard (head::neck::held_cards, sum_cards(head::neck::held_cards) - goal) of
                      NONE => moves
                    | SOME c => moves @ [Discard c, Draw])
          | aux (card::deck, goal, held_cards, moves) =
            if sum_cards(card::held_cards) = goal
            then moves @ [Draw]
            else if sum_cards(held_cards) < goal - 10
            then aux(deck, goal, card::held_cards, moves @ [Draw])
            else moves
    in
        aux(cards, goal, [], [])
    end
