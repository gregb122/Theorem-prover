% Define a module containing tests.
:- module(theorem_prover_tests, [tests/5]).

% Define the operators ~/1 and v/2.
:- op(200, fx, ~).
:- op(500, xfy, v).

% Set of facts defining the tests.
tests(middle_exclusion,validity,[p v ~p],500,solution([(p,t)])).
tests(single_variable,validity,[p],500,solution([(p,t)])).
tests(disjunction_of_variables_1,validity,[p v q],500,solution([(p,t),(q,t)])).
tests(disjunction_of_variables_2,validity,[p v q v r],500,count(7)).
tests(disjunction_of_variables_3,validity,[p v q v r v s v n],700,count(31)).
tests(satisfiable_1,validity,[p v ~q, p],500,solution([(p,t),(q,t)])).
tests(satisfiable_2,validity,[p, p v q],500,count(2)).
tests(satisfiable_3,validity,[p, ~p v q],500,count(1)).
tests(negation_of_variable,validity,[~p],500,solution([(p,f)])).
tests(negation_of_conjunction_of_variables,validity,[~p, ~q, ~r],500,solution([(p,f),(q,f),(r,f)])).
tests(neg_duplicate_variable_1,validity,[~p v ~p],500,solution([(p,f)])).
tests(conj_disj_1,validity,[p v q, p v r],500,count(5)).
tests(conj_vars_1,validity,[p, q, r, s],500,solution([(p,t),(q,t),(r,t),(s,t)])).
tests(conj_vars_2,validity,[p, q, r],500,count(1)).
tests(dup_clause,validity,[p v p, p v p],500,solution([(p,t)])).
tests(dup_var_1,validity,[p, p],500,solution([(p,t)])).
tests(dup_var_2,validity,[p, p, p],500,solution([(p,t)])).
tests(dup_var_3,validity,[p v p],500,solution([(p,t)])).
tests(dup_var_4,validity,[p v p v p],500,solution([(p,t)])).
tests(weak_satisfiable_1,validity,[p v q, r, s],500,solution([(p,t),(q,f),(r,t),(s,t)])).
tests(weak_satisfiable_2,validity,[p v q, ~r, r v ~p],600,count(1)).
tests(contradictory_1,validity,[p , ~q],500,count(0)).
tests(contradictory_2,validity,[p, p, ~p],500,count(0)).
tests(empty_clause,validity,[[]],500,count(0)).
tests(var_empty,validity,[p, []],500,count(0)).
