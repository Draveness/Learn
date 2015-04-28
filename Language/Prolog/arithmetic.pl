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

accMin([H|T],A,Min):-
    H > A,
    accMin(T,A,Min).
accMin([H|T],A,Min):-
    H =< A,
    accMin(T,H,Min).
accMin([],A,A).
min(List,Min):-
    [H|_] = List,
    accMin(List,H,Min).

max(List,Max):-
    [H|_] = List,
    accMax(List,H,Max).


increment(X,Y):-
    Y is X+1.

sum(X,Y,Z):-
    Z is X+Y.

addOne([],[]).
addOne([X|Xs],[Y|Ys]):-
    Y is X + 1,
    addOne(Xs,Ys).


scalar(_,[],[]).
scalar(M,[X|Xs],[Y|Ys]):-
    Y is X*M,
    scalar(M,Xs,Ys).

dot([],[],0).
dot([X|Xs],[Y|Ys],Z):-
    dot(Xs,Ys,Z1),
    Z is X*Y+Z1.
