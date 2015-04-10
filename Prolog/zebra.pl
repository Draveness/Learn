neighbor(L,R,[L,R|_]).
neighbor(L,R,[_|Xs]) :- neighbor(L,R,Xs).

zebra(X) :-
    Street = [H1,H2,H3],
    member(house(red,englishman,_), Street),
    member(house(_,spanish,jaguar), Street),
    neighbor(house(_,_,snail), house(_,japanese,_), Street),
    neighbor(house(_,_,snail), house(blue,_,_), Street),
    member(house(_,X,zebra),Street).
