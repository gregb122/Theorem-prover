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
  formula_do_listy_atomow_sort(Clauses,Lista_atomow),
  formula_do_listy_list_literalow(Clauses,Lista_list_literalow),
  solve(Lista_atomow,Lista_list_literalow,[],Lista_war1,Reszta),
  wartosciowanie_reszty(Reszta,[],Lista_war2),
  append(Lista_war1,Lista_war2,Solution).

solve(Lista,[],Acc1,Acc1,Lista):-!.
solve([],_,_,_,_):-fail.
solve([H|T],Lista_list_literalow,Acc,Lista_war1,Reszta):-
  member(X,[t,f]),
  usun_z_listy(X,H,Lista_list_literalow,[],Lista_pozostalych),
  Acc1=[(H,X)|Acc],
  solve(T,Lista_pozostalych,Acc1,Lista_war1,Reszta).

wartosciowanie_reszty([],Acc,Acc).
wartosciowanie_reszty([H|T],Acc,Lista_war2):-
  Acc1=[(H,x)|Acc],
  wartosciowanie_reszty(T,Acc1,Lista_war2).

%tworzy liste z klauzul w ktorych nie wystepuje podana zmienna H.
usun_z_listy(_,_,[],Acc,Acc).
usun_z_listy(t,H,[X|T],Acc,Lista_pozostalych):-
  \+ member(H,X),
  Acc1=[X|Acc],
  usun_z_listy(t,H,T,Acc1,Lista_pozostalych),!.
usun_z_listy(f,H,[X|T],Acc,Lista_pozostalych):-
  \+ member(~H,X),
  Acc1=[X|Acc],
  usun_z_listy(f,H,T,Acc1,Lista_pozostalych),!.
usun_z_listy(X,H,[_|T],Acc,Lista_pozostalych):-
  usun_z_listy(X,H,T,Acc,Lista_pozostalych).



%Listy atomow i literalow:

formula_do_listy_atomow_sort(Formula,Listasort):-
  formula_do_listy_atomow(Formula,[],Lista),
  sort(Lista,Listasort).
formula_do_listy_atomow([],Acc,Acc).
formula_do_listy_atomow([~H|T],Acc,Lista_literalow):-
  atomic(H),
  Acc1=[H|Acc],
  formula_do_listy_atomow(T,Acc1,Lista_literalow),!.
formula_do_listy_atomow([H|T],Acc,Lista_literalow):-
  atomic(H),
  Acc1=[H|Acc],
  formula_do_listy_atomow(T,Acc1,Lista_literalow),!.
formula_do_listy_atomow([H|T],Acc,Lista_literalow):-
  klauzula_do_listy_atomow(H,[],Lista),
  append(Lista,Acc,Acc1),
  formula_do_listy_atomow(T,Acc1,Lista_literalow).

klauzula_do_listy_atomow(~Klauzula,Acc,Lista_literalow):-
  atomic(Klauzula),
  Acc1=[Klauzula|Acc],
  Acc1=Lista_literalow,!.
klauzula_do_listy_atomow(Klauzula,Acc,Lista_literalow):-
  atomic(Klauzula),
  Acc1=[Klauzula|Acc],
  Acc1=Lista_literalow,!.
klauzula_do_listy_atomow(~X v R,Acc,Lista_literalow):-
  Acc1=[X|Acc],
  klauzula_do_listy_atomow(R,Acc1,Lista_literalow),!.
klauzula_do_listy_atomow(X v R,Acc,Lista_literalow):-
  Acc1=[X|Acc],
  klauzula_do_listy_atomow(R,Acc1,Lista_literalow),!.

klauzula_do_listy_literalow(~Klauzula,Acc,Lista_literalow):-
  atomic(Klauzula),
  Acc1=[~Klauzula|Acc],
  Acc1=Lista_literalow,!.
klauzula_do_listy_literalow(Klauzula,Acc,Lista_literalow):-
  atomic(Klauzula),
  Acc1=[Klauzula|Acc],
  Acc1=Lista_literalow,!.
klauzula_do_listy_literalow(~X v R,Acc,Lista_literalow):-
  Acc1=[~X|Acc],
  klauzula_do_listy_literalow(R,Acc1,Lista_literalow),!.
klauzula_do_listy_literalow(X v R,Acc,Lista_literalow):-
  Acc1=[X|Acc],
  klauzula_do_listy_literalow(R,Acc1,Lista_literalow),!.

formula_do_listy_list_literalow(Formula,Listalist):-
  formula_do_listy_list_literalow_acc(Formula,[],Listalist).
formula_do_listy_list_literalow_acc([],Acc,Acc).
formula_do_listy_list_literalow_acc([H|T],Acc,Listalist):-
  klauzula_do_listy_literalow(H,[],Lista_literalow),
  Acc1=[Lista_literalow|Acc],
  formula_do_listy_list_literalow_acc(T,Acc1,Listalist).
