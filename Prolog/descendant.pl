descend(X,Y):-child(X,Y).
descend(X,Y):-child(X,Z),
	      descend(Z,Y).
child(martha,charlotte).
child(charlotte,caroline).
child(caroline,laura).
child(laura,rose).
