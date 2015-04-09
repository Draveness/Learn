len([],0).
len([_|T],N):-len(T,X), N is X+1.

accLen([_|T],A,L):-Anew is A+1,accLen(T,Anew,L).
accLen([],A,A).


accMax([H|T],A,Max):-
    H > A,
    accMax(T,H,Max).

accMax([H|T],A,Max):-
    H=<A,
    accMax(T,A,Max).
accMax([],A,A).

max(List,Max):-
    [H|_] = List,
    accMax(List,H,Max).
