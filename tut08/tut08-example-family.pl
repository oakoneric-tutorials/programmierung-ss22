male(albert).
male(berti).
male(conrad).
male(dennis).
male(daniel)
male(erich).
male(fritz).

parent(berti,albert).
parent(beate,albert).

parent(conrad,berti).
parent(claudia,berti).

parent(erich,conrad).
parent(eva,conrad).

parent(dennis,beate).
parent(daniel,beate).

parent(fritz,eva).

female(X) :- not(male(X)).

father(X,Y) :- parent(X,Y), male(X).

ancestor(X,Y) :- parent(X,Y).
ancestor(X,Y) :- parent(Z,Y), ancestor(X,Z).

female_ancestor(X,Y) :- ancestor(X,Y), female(X).
