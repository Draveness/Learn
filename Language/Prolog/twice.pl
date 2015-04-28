twice([],[]).
twice([X|Xs],[X,X|Ys]):-twice(Xs,Ys).
    
