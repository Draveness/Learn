combine1([],[],[]).
combine1([X|Xs],[Y|Ys],[X,Y|Zs]):-
    combine1(Xs,Ys,Zs).

combine2([],[],[]).
combine2([X|Xs],[Y|Ys],[[X,Y]|Zs]):-
    combine2(Xs,Ys,Zs).


combine3([],[],[]).
combine3([X|Xs],[Y|Ys],[join(X,Y)|Zs]):-
    combine3(Xs,Ys,Zs).
