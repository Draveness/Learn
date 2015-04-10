member(X,[X|_]).
member(X,[_|T]):-member(X,T).
mysubset([],_).
mysubset([X|Xs],Ys):-
    member(X,Ys),mysubset(Xs,Ys).

musuperset(_,[]).
musuperset(Xs,[Y|Ys]):-
    member(Y,Xs),musuperset(Xs,Ys).

set([],Acc,Acc).
set([H|T],Acc,OutList):-
    member(H,Acc),
    set(T,Acc,OutList).
set([H|T],Acc,OutList):-
    set(T,[H|Acc],OutList).
set([H|T],OutList):-set(T,H,OutList).
