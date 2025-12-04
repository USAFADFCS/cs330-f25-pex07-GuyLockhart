% pex5.pl
% USAFA UFO Sightings 2024
%
% name: Will Lockhart
%
% Documentation: While looking over C2C Zach Poupart's code, discovered I didn't 
% implement day order in output. Then tryed to figure out how member function worked, 
% discovered this website to implement lines 76-83. 
% https://www.swi-prolog.org/pldoc/man?predicate=member/2
%

% The query to get the answer(s) or that there is no answer
% ?- solve.

cadet(smith).
cadet(garcia).
cadet(chen).
cadet(jones).

day(tues).
day(wed).
day(thurs).
day(fri).

object(balloon).
object(kite).
object(fighter).
object(cloud).

solve :-
    object(SmithObject), object(GarciaObject), object(ChenObject), object(JonesObject),
    all_different([SmithObject, GarciaObject, ChenObject, JonesObject]),
    
    day(SmithDay), day(GarciaDay), day(ChenDay), day(JonesDay),
    all_different([SmithDay, GarciaDay, ChenDay, JonesDay]),
    
    Triples =[ [smith, SmithDay, SmithObject],
             [garcia, GarciaDay, GarciaObject],
             [chen, ChenDay, ChenObject],
             [jones, JonesDay, JonesObject] ],
    
    % C4C Smith did not see a weather balloon, nor kite.
    \+ member([smith, _, balloon], Triples),
    \+ member([smith, _, kite], Triples),
    
	% The one who saw the kite isn’t C4C Garcia.
	\+ member([garcia, _, kite], Triples),
    
	% Friday’s sighting was made by either C4C Chen or the one who saw the fighter aircraft.
	% not needed
    
	% The kite was not sighted on Tuesday.
	\+ member([_, tues, kite], Triples),
    
	% Neither C4C Garcia nor C4C Jones saw the weather balloon.
	\+ member([garcia, _, balloon], Triples),
    \+ member([jones, _, balloon], Triples),
    
	% C4C Jones did not make their sighting on Tuesday.
	\+ member([jones, tues, _], Triples),
    
	% C4C Smith saw an object that turned out to be a cloud.
    member([smith, _, cloud], Triples),
	
    
	% The fighter aircraft was spotted on Friday.
	member([_, fri, fighter], Triples),
    
	% The weather balloon was not spotted on Wednesday.
	\+ member([_, wed, balloon], Triples),
    
    member(W, Triples),
    member(tues, W),
    member(X, Triples),
    member(wed, X),
    member(Y, Triples),
    member(thurs, Y),
    member(Z, Triples),
    member(fri, Z),
    

    tell(W),
    tell(X),
    tell(Y),
    tell(Z).
    
% Succeeds if all elements of the argument list are bound and different.
% Fails if any elements are unbound or equal to some other element.
all_different([H | T]) :- member(H, T), !, fail.
all_different([_ | T]) :- all_different(T).
all_different([_]).

tell([Cadet, Day, Object]) :-
    
    write('C4C '), write(Cadet), write(' saw the '), write(Object),
    write(' on '), write(Day), write('.'), nl.
