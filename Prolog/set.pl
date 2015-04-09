member(X,[X|_]).
member(X,[_|T]):-member(X,T).
mysubset([],_).
mysubset([X|Xs],Ys):-
    member(X,Ys),mysubset(Xs,Ys).

musuperset(_,[]).
musuperset(Xs,[Y|Ys]):-
    member(Y,Xs),musuperset(Xs,Ys).
