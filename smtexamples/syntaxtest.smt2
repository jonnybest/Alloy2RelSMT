; file: D:\Entwicklung\workspace\alloy2relsmt\smtexamples\syntaxtest.als 
; hash: 97FA 3C0B0E498EE842CE4FD8147BEBB
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
(declare-fun a2r_2 (Atom Atom) Rel2)
(declare-fun disjoint_1 (Rel1 Rel1) Bool)
(declare-fun fn () Rel3)
(declare-fun in_1 (Atom Rel1) Bool)
(declare-fun in_2 (Atom Atom Rel2) Bool)
(declare-fun in_3 (Atom Atom Atom Rel3) Bool)
(declare-fun in_4 (Atom Atom Atom Atom Rel4) Bool)
(declare-fun in_5 (Atom Atom Atom Atom Atom Rel5) Bool)
(declare-fun ins () Rel2)
(declare-fun inter_2 (Rel2 Rel2) Rel2)
(declare-fun join_1x2 (Rel1 Rel2) Rel1)
(declare-fun join_1x3 (Rel1 Rel3) Rel2)
(declare-fun join_2x1 (Rel2 Rel1) Rel1)
(declare-fun join_2x2 (Rel2 Rel2) Rel2)
(declare-fun lone_1 (Rel1) Bool)
(declare-fun no_1 (Rel1) Bool)
(declare-fun no_5 (Rel5) Bool)
(declare-fun none () Rel1)
(declare-fun one_1 (Rel1) Bool)
(declare-fun prod_1x1 (Rel1 Rel1) Rel2)
(declare-fun prod_1x4 (Rel1 Rel4) Rel5)
(declare-fun prod_2x1 (Rel2 Rel1) Rel3)
(declare-fun prod_3x1 (Rel3 Rel1) Rel4)
(declare-fun some_1 (Rel1) Bool)
(declare-fun some_2 (Rel2) Bool)
(declare-fun subset_1 (Rel1 Rel1) Bool)
(declare-fun subset_2 (Rel2 Rel2) Bool)
(declare-fun subset_3 (Rel3 Rel3) Bool)
;; --end functions

;; axioms
(assert 
 (! 
  (forall ((X Rel1)) (= (one_1 X) (and (exists ((a0 Atom)) (in_1 a0 X)) (forall ((a0 Atom)(b0 Atom)) (=> (and (in_1 a0 X) (in_1 b0 X)) (= a0 b0)))))) 
 :named axiom12f951fb 
 ) 
 )
(assert 
 (! 
  (forall ((A Rel2)) (= (some_2 A) (exists ((a0 Atom)(a1 Atom)) (in_2 a0 a1 A)))) 
 :named axiom18f69822 
 ) 
 )
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
  ; axiom for join_2x1
(forall ((A Rel2)(B Rel1)(y0 Atom)) (= (in_1 y0 (join_2x1 A B)) (exists ((x Atom)) (and (in_2 y0 x A) (in_1 x B))))) 
 :named axiom48f6aa73 
 ) 
 )
(assert 
 (! 
  ; axiom for 'the expression is empty'
(forall ((a0 Atom)(R Rel1)) (=> (no_1 R) (not (in_1 a0 R)))) 
 :named axiom6282b3bb 
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
  ; subset axiom for Rel1
(forall ((x Rel1)(y Rel1)) (= (subset_1 x y) (forall ((a0 Atom)) (=> (in_1 a0 x) (in_1 a0 y))))) 
 :named axiom76d2de83 
 ) 
 )
(assert 
 (! 
  ; axiom for join_2x2
(forall ((A Rel2)(B Rel2)(y0 Atom)(y1 Atom)) (= (in_2 y0 y1 (join_2x2 A B)) (exists ((x Atom)) (and (in_2 y0 x A) (in_2 x y1 B))))) 
 :named axiom785d259e 
 ) 
 )
(assert 
 (! 
  ; axiom for the conversion function Atom -> Relation
(forall ((x0 Atom)(x1 Atom)) (and (in_2 x0 x1 (a2r_2 x0 x1)) (forall ((y0 Atom)(y1 Atom)) (=> (in_2 y0 y1 (a2r_2 x0 x1)) (and (= x0 y0) (= x1 y1)))))) 
 :named axiom7a8a4465 
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
(assert 
 (! 
  ; axiom for intersection 2
(forall ((a0 Atom)(a1 Atom)(R Rel2)(S Rel2)) (=> (in_2 a0 a1 (inter_2 R S)) (or (in_2 a0 a1 R) (in_2 a0 a1 S)))) 
 :named axiomeab84aab 
 ) 
 )
;; --end axioms

;; assertions
(assert 
 (! 
  (subset_2 ins (prod_1x1 B B)) 
 :named assert318c1ef9 
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
  (forall ((this Atom)) (=> (in_1 this B) (one_1 (join_1x2 (a2r_1 this) ins)))) 
 :named assert8569e6fa 
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
(assert 
 (! 
  (and (no_5 (prod_1x4 A (prod_3x1 fn A))) (some_2 (inter_2 ins ins))) 
 :named assertf3ff583d 
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
  ; lemma about subsets within joins, from com-theorem1, related to step 45
(forall ((a Rel1)(A Rel1)(B Rel1)(R Rel2)) (=> (subset_1 a A) (subset_1 (join_1x2 a R) (join_1x2 A R)))) 
 :named lemma1aecfc94 
 ) 
 )
(assert
 (! 
  ; 2. lemma for join_2x2. direction: in to join
(forall ((a2 Atom)(a1 Atom)(a0 Atom)(r Rel2)) (=> (in_2 a1 a0 r) (in_2 a2 a0 (join_2x2 ; (swapped)
(a2r_2 a2 a1) r)))) 
 :named lemma3bc35ca3 
 ) 
 )
(assert
 (! 
  ; 2. lemma for join_2x1. direction: in to join
(forall ((a0 Atom)(a1 Atom)(r Rel2)) (=> (in_2 a0 a1 r) (in_1 a0 (join_2x1 r (a2r_1 a1))))) 
 :named lemma50960a04 
 ) 
 )
(assert
 (! 
  ; equality Lemma (newly introduced. Be careful, this is very costly.
(forall ((x Rel1)(y Rel1)) (=> (= x y) (and (subset_1 x y) (subset_1 y x)))) 
 :named lemma68418934 
 ) 
 )
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
(assert
 (! 
  ; lemma for step 21 of the com-theorem1 for join_1x2: R=(i.qi) S=iids
(forall ((R Rel2)(S Rel2)(x Atom)) (=> (no_1 (join_1x2 (a2r_1 x) R)) (no_1 (join_1x2 (a2r_1 x) (join_2x2 R S))))) 
 :named lemma844803cd 
 ) 
 )
(assert
 (! 
  ; lstep20: lemma about subset 2 and product 1x1 , using join
(forall ((R Rel2)(A Rel1)(B Rel1)) (=> (subset_2 R (prod_1x1 A B)) (forall ((a0 Atom)) (= (not (in_1 a0 (join_2x1 R B))) (no_1 (join_1x2 (a2r_1 a0) R)))))) 
 :named lemma8f0bdd2 
 ) 
 )
(assert
 (! 
  ; 1. lemma for join_2x2. direction: join to in
(forall ((a2 Atom)(a1 Atom)(a0 Atom)(r Rel2)) (=> (in_2 a2 a0 (join_2x2 ; (swapped)
(a2r_2 a2 a1) r)) (in_2 a1 a0 r))) 
 :named lemmaaa5ad85c 
 ) 
 )
(assert
 (! 
  ; joinOfProdRel: originally introduced for COM-theorem1 step 19->20 with R=qi, A=C=Interface, B=IID
(forall ((a Atom)(A Rel1)(B Rel1)(C Rel1)(R Rel3)) (= (subset_3 R (prod_2x1 (prod_1x1 A B) C)) (subset_2 (join_1x3 (a2r_1 a) R) (prod_1x1 B C)))) 
 :named lemmacb5f335f 
 ) 
 )
(assert
 (! 
  ; 1. lemma for join_1x3. direction: join to in
(forall ((a2 Atom)(a1 Atom)(a0 Atom)(r Rel3)) (=> (in_2 a1 a0 (join_1x3 ; (swapped)
(a2r_1 a2) r)) (in_3 a2 a1 a0 r))) 
 :named lemmadc7b01cf 
 ) 
 )
(assert
 (! 
  ; 1. lemma for join_2x1. direction: join to in
(forall ((a0 Atom)(a1 Atom)(r Rel2)) (=> (in_1 a0 (join_2x1 r (a2r_1 a1))) (in_2 a0 a1 r))) 
 :named lemmaec517cdd 
 ) 
 )
(assert
 (! 
  ; 1. lemma for join_1x2. direction: join to in
(forall ((a1 Atom)(a0 Atom)(r Rel2)) (=> (in_1 a0 (join_1x2 ; (swapped)
(a2r_1 a1) r)) (in_2 a1 a0 r))) 
 :named lemmaf97e883f 
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
