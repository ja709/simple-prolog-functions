# simple-prolog-functions


tree(?Tree)

	Tree is a binary tree, which may be nil or b(Left,Here,Right), where
	Left and Right are binary trees and Here is an arbitrary term.
	
	?- tree(nil).
	true.
	?- tree(b(nil,_,nil)).
	true.
	?- tree(b(b(nil,1,nil),x,nil)).
	true.

mirror(+Tree1, ?Tree2)

	Tree1 and Tree2 are mirror images; that is, swapped left for right
	
	?- mirror(b(nil,1,b(nil,2,nil)), R).
	R = b(b(nil,2,nil),1,nil).

--

echo(+L1, ?L2)
	True if L1 and L2 are lists, and L2 contains each element in L1
	twice in a row.
	
	?- echo([],[]).
	true.
	?- echo([1],[1,1]).
	true.
	?- echo([1,2], L).
	L = [1,1,2,2].

unecho(+L1, ?L2)
	True if L1 and L2 are lists, and any consecutive repetitions in L1 are
	single elements in L2.
	
	?- unecho([1,2,2,3], [1,2,3]).
	true.
	?- unecho([1,2,2,3], X).
	X = [1,2,3].

--


slist(?List)

	List is a non-decreasing list of integers
	
	?- slist([1,2,2]).
	true.
	?- slist([0,4,4,8).
	true.
	?- slist([1,0]).
	false.

	slist(List) should produce arbitrarily many lists

sselect(?Item, ?List0, ?List1)

	List1 is the result of inserting Item into List0
	
	?- sselect(2, [1,3], [1,2,3]).
	true.
	?- sselect(2, [1,2,3], [1,2,2,3]).
	true.
	?- sselect(2, [1,3], L).
	L = [1,2,3].
	?- sselect(2, L, [1,2,3]).
	L = [1,3].
	?- sselect(X, [1,3], [1,2,3]).
	X = 2.
	?- sselect(X, L, [1,2,3]).
	X = 1, L = [2,3] ;
	X = 2, L = [1,3] ;
	X = 3, L = [1,2] .
	
	sselect(X, Y, Z) should produce arbitrarily many answers
	
	
	sselect/3 should only examine enough of List0 and List1 to determine
	the placement of Item. In particular, sselect(2, [1,3|X], [1,2,3|X])
	should not bind X.
	
sselect(X,[],[X]) :- X in inf..sup.
sselect(X,[Y],[Y,X]) :- X #> Y.
sselect(X,[Y|Z],[X|[Y|Z]]) :- X #=< Y.
sselect(X,[Y|[Z|W],[Y|A]) :- X #> Y, Y #=< Z, sselect(X,[Z|W],A).
	?- sselect(2, [1,3|X], [1,2,3|X]).
	true.
	?- sselect(2, [1,3|X], L).
	L = [1,2,3|X].
	
	The prefix of List0 up to Item and the element following item must be
	non-decreasing.

	?- sselect(2, L, [1,0,2,3]).
	false.
