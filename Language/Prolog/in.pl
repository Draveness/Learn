in(X,Y):-inside(X,Y).
in(X,Z):-inside(X,Y),
	 in(Y,Z).

inside(olga,katarina).
inside(natsha,loga).
inside(irina,natsha).
