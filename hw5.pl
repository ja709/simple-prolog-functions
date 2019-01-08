:- use_module(library(clpfd)).
:- use_module(library(dif)).


tree(nil).
tree(b(L,_,R)):-
	tree(L), tree(R).


notmember(A,[]).
notmember(A,[X|Y]) :-
	dif(X,A),
	notmember(A,Y).


/*
travel(Rel,A,B,[A,B],2,Visit) :-
	call(Rel,A,B).
travel(Rel,A,B,[A|[C|X]],Len,Visit) :-
       	call(Rel,A,C),           
       	%\+member(C,Visit),
	notmember(C,Visit),
       	travel(Rel,C,B,[C|X],L1,[C|Visit]),
       	Len is L1 + 1.  


path(Rel,A,B,Path,Len) :-
	dif(A,B),travel(Rel,A,B,Path,Len,[A,B]). 
*/
% ---------------------------------------------------------

mirror(nil,nil).
mirror(b(L,X,R), b(SL,X,SR)) :-
	mirror(L,SR), mirror(R,SL).
% ---------------------------------------------------------

echo([], []).
echo([X|L1], [X,X|L2]) :-
	echo(L1,L2).
% ---------------------------------------------------------

unecho([],[]).
unecho([X], [X]).
unecho([X|[Y|Z]],[X|A]) :-
	dif(X,Y), unecho([Y|Z],A).
unecho([X|[X|Y]],A):-
	unecho([X|Y],A).
% ---------------------------------------------------------

slist([]).
slist([X]):- X in inf..sup.
slist([X|[Y|Z]]) :- 
	X #=< Y, slist([Y|Z]).
% ---------------------------------------------------------
sselect([],[],[]).
sselect(X, [],[X]) :- 
	X in inf..sup.
sselect(X,[Y],[Y,X]) :- 
	X #> Y.
sselect(X,[Y|Z],[X|[Y|Z]]) :-
	X #=< Y.
sselect(X,[Y|[Z|W]],[Y|A]) :-
	X #> Y,	
	Y #=< Z,
	sselect(X,[Z|W],A).
