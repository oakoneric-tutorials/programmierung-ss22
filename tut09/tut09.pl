% AUFGABE 1

nat (0).
nat(s(X)) :- nat(X).

listnat ([]).
listnat ([X|XS]) :- nat(X), listnat(XS).

prefix([]    , Ys )    :- listnat(Ys).
prefix([X|Xs], [X|Ys]) :- nat(X), prefix(Xs, Ys).

sublist(Xs   , [Y|Ys]) :- nat(Y), sublist(Xs, Ys).
sublist(Xs   , Ys )    :- prefix(Xs, Ys).

% AUFGABE 2

sum(0, Y, Y) :- nat(Y).
sum(s(X), Y, s(S)) :- sum(X, Y, S).

eval( X         , X ) :-  nat(X).
eval( plus (L,R), X ) :-  eval(L, LE), eval(R, RE), sum(LE, RE,  X).
eval( minus(L,R), X ) :-  eval(L, LE), eval(R, RE), sum(RE,  X, LE).
