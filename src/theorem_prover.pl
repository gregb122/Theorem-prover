% Defining a module containing the solution.
:- module(theorem_prover, [solve/2]).

% Defining the operators ~/1 and v/2.
:- op(200, fx, ~). % p v q v r => v(p, v(q, r))  X v R    v(X, R) [H|T]
:- op(500, xfy, v).

% The main predicate solving the task.
solve(Clauses, Solution) :-
  formula_to_atom_list_sort(Clauses, AtomList),
  formula_to_literal_list_list(Clauses, LiteralList),
  \+ member([], Clauses), !,
  solve(AtomList, LiteralList, [], WarList1, Rest),
  remaining_valuation(Rest, [], WarList2),
  append(WarList1, WarList2, Solution).

remaining_valuation([], Acc, Acc).
remaining_valuation([H|T], Acc, WarList2) :-
  Acc1 = [(H, x)|Acc],
  remaining_valuation(T, Acc1, WarList2).

solve(List, [], Acc1, Acc1, List) :- !.
solve([H|T], LiteralList, Acc, WarList1, Rest) :-
  member(X, [t, f]),
  remove_from_list(X, H, LiteralList, [], RemainingList),
  solve(T, RemainingList, [(H, X)|Acc], WarList1, Rest).

% Creates a list of clauses in which the variable H does not occur.
remove_from_list(_, _, [], Acc, Acc).
remove_from_list(t, H, [X|T], Acc, RemainingList) :-
  \+ member(H, X), !,
  remove_from_list(t, H, T, [X|Acc], RemainingList).
remove_from_list(f, H, [X|T], Acc, RemainingList) :-
  \+ member(~H, X), !,
  remove_from_list(f, H, T, [X|Acc], RemainingList).
remove_from_list(X, H, [_|T], Acc, RemainingList) :-
  remove_from_list(X, H, T, Acc, RemainingList).

% Lists of atoms and literals:

formula_to_atom_list_sort(Formula, SortedList) :-
  formula_to_atom_list(Formula, [], List),
  sort(List, SortedList).
formula_to_atom_list([], Acc, Acc).
formula_to_atom_list([~H|T], Acc, LiteralList) :-
  atomic(H),
  Acc1 = [H|Acc],
  formula_to_atom_list(T, Acc1, LiteralList), !.
formula_to_atom_list([H|T], Acc, LiteralList) :-
  atomic(H),
  Acc1 = [H|Acc],
  formula_to_atom_list(T, Acc1, LiteralList), !.
formula_to_atom_list([H|T], Acc, LiteralList) :-
  clause_to_atom_list(H, [], List),
  append(List, Acc, Acc1),
  formula_to_atom_list(T, Acc1, LiteralList).

clause_to_atom_list(~Clause, Acc, LiteralList) :-
  atomic(Clause),
  Acc1 = [Clause|Acc],
  Acc1 = LiteralList, !.
clause_to_atom_list(Clause, Acc, LiteralList) :-
  atomic(Clause),
  Acc1 = [Clause|Acc],
  Acc1 = LiteralList, !.
clause_to_atom_list(~X v R, Acc, LiteralList) :-
  Acc1 = [X|Acc],
  clause_to_atom_list(R, Acc1, LiteralList), !.
clause_to_atom_list(X v R, Acc, LiteralList) :-
  Acc1 = [X|Acc],
  clause_to_atom_list(R, Acc1, LiteralList), !.

clause_to_literal_list(~Clause, Acc, LiteralList) :-
  atomic(Clause),
  Acc1 = [~Clause|Acc],
  Acc1 = LiteralList, !.
clause_to_literal_list(Clause, Acc, LiteralList) :-
  atomic(Clause),
  Acc1 = [Clause|Acc],
  Acc1 = LiteralList, !.
clause_to_literal_list(~X v R, Acc, LiteralList) :-
  Acc1 = [~X|Acc],
  clause_to_literal_list(R, Acc1, LiteralList), !.
clause_to_literal_list(X v R, Acc, LiteralList) :-
  Acc1 = [X|Acc],
  clause_to_literal_list(R, Acc1, LiteralList), !.

formula_to_literal_list_list(Formula, LiteralListList) :-
  formula_to_literal_list_list_acc(Formula, [], LiteralListList).
formula_to_literal_list_list_acc([], Acc, Acc).
formula_to_literal_list_list_acc([H|T], Acc, LiteralListList) :-
  clause_to_literal_list(H, [], LiteralList),
  sort(LiteralList, SortedLiteralList),
  Acc1 = [SortedLiteralList|Acc],
  formula_to_literal_list_list_acc(T, Acc1, LiteralListList).
