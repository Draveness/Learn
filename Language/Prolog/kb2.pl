listenToMusic(mia).
happy(yolanda).
playsAirGuitar(mia) :- listenToMusic(mia).
playsAirGuitar(yolanda) :- listenToMusic(yolanda).
listenToMusic(yolanda) :- happy(yolanda).
