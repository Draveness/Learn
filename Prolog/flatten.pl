flatten([],Acc,Acc).
flatten(H,Acc,[H|Acc]):-
    H \= [_|_],
    H \= [].
flatten([X|Xs],Acc,Result):-
    flatten(Xs,Acc,NewAcc),
    flatten(X,NewAcc,Result).
flatten(List,Flat):-
    flatten(List,[],Flat).
