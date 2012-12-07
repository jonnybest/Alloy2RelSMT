; file: D:\Entwicklung\workspace\alloy2relsmt\smtexamples\syntaxtest.als 
; hash: 9F76D95FA578E05A9DE27DFC246D23FF
(set-logic AUFLIA)
(set-option :macro-finder true)
;; sorts
(declare-sort Atom)
(declare-sort Rel1)
(declare-sort Rel2)
(declare-sort Rel3)
(declare-sort Rel4)
(declare-sort Rel5)
;; --end sorts

;; functions
(declare-fun A () Rel1)
(declare-fun B () Rel1)
(declare-fun a2r_1 (Atom) Rel1)
(declare-fun disjoint_1 (Rel1 Rel1) Bool)
(declare-fun fn () Rel3)
(declare-fun in_1 (Atom Rel1) Bool)
(declare-fun in_2 (Atom Atom Rel2) Bool)
(declare-fun in_3 (Atom Atom Atom Rel3) Bool)
(declare-fun in_4 (Atom Atom Atom Atom Rel4) Bool)
(declare-fun in_5 (Atom Atom Atom Atom Atom Rel5) Bool)
(declare-fun join_1x2 (Rel1 Rel2) Rel1)
(declare-fun join_1x3 (Rel1 Rel3) Rel2)
(declare-fun lone_1 (Rel1) Bool)
(declare-fun no_5 (Rel5) Bool)
(declare-fun none () Rel1)
(declare-fun prod_1x1 (Rel1 Rel1) Rel2)
(declare-fun prod_1x4 (Rel1 Rel4) Rel5)
(declare-fun prod_2x1 (Rel2 Rel1) Rel3)
(declare-fun prod_3x1 (Rel3 Rel1) Rel4)
(declare-fun some_1 (Rel1) Bool)
(declare-fun subset_2 (Rel2 Rel2) Bool)
(declare-fun subset_3 (Rel3 Rel3) Bool)
;; --end functions

;; axioms
(assert 
 (! 
  (forall ((y0 Atom)(x0 Atom)(A Rel1)(B Rel1)) (= (in_2 x0 y0 (prod_1x1 A B)) (and (in_1 x0 A) (in_1 y0 B)))) 
 :named axiom19bef732 
 ) 
 )
(assert 
 (! 
  ; subset axiom for Rel2
(forall ((x Rel2)(y Rel2)) (= (subset_2 x y) (forall ((a0 Atom)(a1 Atom)) (=> (in_2 a0 a1 x) (in_2 a0 a1 y))))) 
 :named axiom225d0e51 
 ) 
 )
(assert 
 (! 
  ; (forall ((A Rel1)(B Rel1)) (= (disjoint_1 A B) (forall ((a0 Atom)) (=> (in_1 a0 A) (not (in_1 a0 B)))))); alternative
(forall ((A Rel1)(B Rel1)) (= (disjoint_1 A B) (forall ((a0 Atom)) (not (and (in_1 a0 A) (in_1 a0 B)))))) 
 :named axiom300ecb75 
 ) 
 )
(assert 
 (! 
  ; axiom for empty set
(forall ((a Atom)) (not (in_1 a none))) 
 :named axiom6cf65805 
 ) 
 )
(assert 
 (! 
  (forall ((y0 Atom)(x0 Atom)(x1 Atom)(A Rel2)(B Rel1)) (= (in_3 x0 x1 y0 (prod_2x1 A B)) (and (in_2 x0 x1 A) (in_1 y0 B)))) 
 :named axiom6f1bf92f 
 ) 
 )
(assert 
 (! 
  ; axiom for join_1x3
(forall ((A Rel1)(B Rel3)(y0 Atom)(y1 Atom)) (= (in_2 y0 y1 (join_1x3 A B)) (exists ((x Atom)) (and (in_1 x A) (in_3 x y0 y1 B))))) 
 :named axiom82f21aba 
 ) 
 )
(assert 
 (! 
  (forall ((y0 Atom)(y1 Atom)(y2 Atom)(y3 Atom)(x0 Atom)(A Rel1)(B Rel4)) (= (in_5 x0 y0 y1 y2 y3 (prod_1x4 A B)) (and (in_1 x0 A) (in_4 y0 y1 y2 y3 B)))) 
 :named axiom922964e9 
 ) 
 )
(assert 
 (! 
  (forall ((X Rel1)) (= (lone_1 X) (forall ((a0 Atom)(b0 Atom)) (=> (and (in_1 a0 X) (in_1 b0 X)) (= a0 b0))))) 
 :named axiomaa1ef80f 
 ) 
 )
(assert 
 (! 
  ; subset axiom for Rel3
(forall ((x Rel3)(y Rel3)) (= (subset_3 x y) (forall ((a0 Atom)(a1 Atom)(a2 Atom)) (=> (in_3 a0 a1 a2 x) (in_3 a0 a1 a2 y))))) 
 :named axiomb131cb24 
 ) 
 )
(assert 
 (! 
  ; axiom for join_1x2
(forall ((A Rel1)(B Rel2)(y0 Atom)) (= (in_1 y0 (join_1x2 A B)) (exists ((x Atom)) (and (in_1 x A) (in_2 x y0 B))))) 
 :named axiomc43ab575 
 ) 
 )
(assert 
 (! 
  (forall ((y0 Atom)(x0 Atom)(x1 Atom)(x2 Atom)(A Rel3)(B Rel1)) (= (in_4 x0 x1 x2 y0 (prod_3x1 A B)) (and (in_3 x0 x1 x2 A) (in_1 y0 B)))) 
 :named axiomcc87c233 
 ) 
 )
(assert 
 (! 
  ; axiom for 'the expression is empty'
(forall ((a0 Atom)(a1 Atom)(a2 Atom)(a3 Atom)(a4 Atom)(R Rel5)) (=> (no_5 R) (not (in_5 a0 a1 a2 a3 a4 R)))) 
 :named axiomd5222db3 
 ) 
 )
(assert 
 (! 
  (forall ((A Rel1)) (= (some_1 A) (exists ((a0 Atom)) (in_1 a0 A)))) 
 :named axiomdf19d42f 
 ) 
 )
(assert 
 (! 
  ; axiom for the conversion function Atom -> Relation
(forall ((x0 Atom)) (and (in_1 x0 (a2r_1 x0)) (forall ((y0 Atom)) (=> (in_1 y0 (a2r_1 x0)) (= x0 y0))))) 
 :named axiome566b6fc 
 ) 
 )
;; --end axioms

;; assertions
(assert 
 (! 
  (no_5 (prod_1x4 A (prod_3x1 fn A))) 
 :named assert525024f9 
 ) 
 )
(assert 
 (! 
  (forall ((this Atom)) (=> (in_1 this B) (forall ((x0 Atom)) (=> (in_1 x0 A) (lone_1 (join_1x2 (a2r_1 x0) (join_1x3 (a2r_1 this) fn))))))) 
 :named assert75da85a3 
 ) 
 )
(assert 
 (! 
  (subset_3 fn (prod_2x1 (prod_1x1 B A) B)) 
 :named assertac1e6e29 
 ) 
 )
(assert 
 (! 
  (disjoint_1 B A) 
 :named assertd08a16f0 
 ) 
 )
;; --end assertions

;; command
(assert 
 (! 
  (not (some_1 B)) 
 :named commanddcca249b 
 ) 
 )
;; --end command

;; lemmas
(assert
 (! 
  ; 2. lemma for join_1x2. direction: in to join
(forall ((a1 Atom)(a0 Atom)(r Rel2)) (=> (in_2 a1 a0 r) (in_1 a0 (join_1x2 ; (swapped)
(a2r_1 a1) r)))) 
 :named lemma6ec6a62 
 ) 
 )
(assert
 (! 
  ; 2. lemma for join_1x3. direction: in to join
(forall ((a2 Atom)(a1 Atom)(a0 Atom)(r Rel3)) (=> (in_3 a2 a1 a0 r) (in_2 a1 a0 (join_1x3 ; (swapped)
(a2r_1 a2) r)))) 
 :named lemma823ccdc0 
 ) 
 )
;; --end lemmas

;; -- key stuff for debugging --
;\problem {(
;
;)-> (
;
;;\predicates {

;;}

;; -- END key stuff --
(check-sat)
