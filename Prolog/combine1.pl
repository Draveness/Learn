combine1([],[],[]).
combine1([X|Xs],[Y|Ys],[X,Y|Zs]):-
    combine1(Xs,Ys,Zs).
