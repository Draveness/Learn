second(X,[_,S|_]):-X=S.

swap12([X,Y|T],[Y,X|T]).

final(X,List):-reverse(List,[H|_]),X=H.

toptail([H|T],Ys):-length([H|T],L),L >= 2,
		reverse(T,[_|T1]),reverse(T1,Ys).


swapfl([X|Xs],List2):-
    append(T,[H],Xs),
    append([H|T],[X],List2).
