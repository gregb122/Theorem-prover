% Definiujemy moduł zawierający rozwiązanie.
% Należy zmienić nazwę modułu na {imie}_{nazwisko} gdzie za
% {imie} i {nazwisko} należy podstawić odpowiednio swoje imię
% i nazwisko bez znaków diakrytycznych
%:- module(grzegorz_bielecki, [solve/2]).

% definiujemy operatory ~/1 oraz v/2
:- op(200, fx, ~).% p v q v r => v(p, v(q, r))  X v R    v(X, R) [H|T]
:- op(500, xfy, v).

% Główny predykat rozwiązujący zadanie.
% UWAGA: to nie jest jeszcze rozwiązanie; należy zmienić jego
% definicję.
solve(Clauses, Solution) :-
  Clauses  = [p v ~p],
  Solution = [(p,x)].
formula_do_listy_literalow([],Acc,Acc).
formula_do_listy_literalow([H|T],Acc,Lista_literalow):-
  atomic(H),
  Acc1=[H|Acc],
  formula_do_listy_literalow(T,Acc1,Lista_literalow),!.
formula_do_listy_literalow([H|T],Acc,Lista_literalow):-
  klauzula_do_listy_literalow(H,[],Lista),
  append(Lista,Acc,Acc1),
  formula_do_listy_literalow(T,Acc1,Lista_literalow).

klauzula_do_listy_literalow(Klauzula,Acc,Lista_literalow):-
  atomic(Klauzula),
  \+ member(Klauzula, Acc),
  Acc1=[Klauzula|Acc],
  Acc1=Lista_literalow.
klauzula_do_listy_literalow(X v R,Acc,Lista_literalow):-
  \+ member(X, Acc),
  Acc1=[X|Acc],
  klauzula_do_listy_literalow(R,Acc1,Lista_literalow),!.
klauzula_do_listy_literalow(_ v R,Acc,Lista_literalow):-
  klauzula_do_listy_literalow(R,Acc,Lista_literalow).
