sublist(SubL,L):-suffix(S,L),prefix(SubL,S).
suffix(S,L):-append(_,S,L).
