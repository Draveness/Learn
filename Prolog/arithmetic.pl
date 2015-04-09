len([],0).
len([_|T],N):-len(T,X), N is X+1.

accLen([_|T],A,L):-Anew is A+1,accLen(T,Anew,L).
accLen([],A,A).

length(List,Length):-accLen(List,0,Length).
