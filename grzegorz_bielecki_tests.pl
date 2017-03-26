% Definiujemy moduł zawierający testy.
% Należy zmienić nazwę modułu na {imie}_{nazwisko}_tests gdzie za
% {imie} i {nazwisko} należy podstawić odpowiednio swoje imię
% i nazwisko bez znaków diakrytycznych
:- module(grzegorz_bielecki_tests, [tests/5]).

% definiujemy operatory ~/1 oraz v/2
:- op(200, fx, ~).
:- op(500, xfy, v).

% Zbiór faktów definiujących testy
% Należy zdefiniować swoje testy
tests(wyl_srodek, validity, [p v ~p], 500, solution([(p,t)])).
tests(pojedyncza_zmienna,validity,[p],500,solution([(p,t)])).
tests(alter_zmiennych_1,validity,[p v q],500,solution([(p,t),(q,t)])).
tests(alter_zmiennych_2,validity,[p v q v r],500,count(7)).
tests(alter_zmiennych_3,validity,[p v q v r v s v n],700,count(31)).
tests(spelnialna_1,validity,[p v ~q, p],500,solution([(p,t),(q,t)])).
tests(spelnialna_2,validity,[p, p v q],500,count(2)).
tests(spelnialna_3,validity,[p, ~p v q],500,count(1)).
tests(neg_zmienna,validity,[~p],500,solution([(p,f)])).
tests(neg_kon_zmiennych,validity,[~p, ~q, ~r],500,solution([(p,f),(q,f),(r,f)])).
tests(neg_powt_zmienna_1,validity,[~p v ~p],500,solution([(p,f)])).
tests(kon_alternatyw,validity,[p v q, p v r],500,count(5)).
tests(kon_zmiennych_1,validity,[p, q, r, s],500,solution([(p,t),(q,t),(r,t),(s,t)])).
tests(kon_zmiennych_2,validity,[p, q, r],500,count(1)).
tests(powt_klaz,validity,[p v p, p v p],500,solution([(p,t)])).
tests(powt_zmienna_1,validity,[p, p],500,solution([(p,t)])).
tests(powt_zmienna_2,validity,[p, p, p],500,solution([(p,t)])).
tests(powt_zmienna_3,validity,[p v p],500,solution([(p,t)])).
tests(powt_zmienna_4,validity,[p v p v p],500,solution([(p,t)])).
tests(slabo_spelnialna_1,validity,[p v q, r, s],500,solution([(p,t),(q,f),(r,t),(s,t)])).
tests(slabo_spelnialna_2,validity,[p v q, ~r, r v ~p],600,count(1)).
tests(sprzeczna_1,validity,[p , ~q],500,count(0)).
tests(sprzeczna_2,validity,[p, p, ~p],500,count(0)).
tests(pusta,validity,[[]],500,count(0)).
tests(z_pusta,validity,[p, []],500,count(0)).
