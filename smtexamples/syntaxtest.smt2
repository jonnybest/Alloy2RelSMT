(set-logic AUFLIA)
(set-option :macro-finder true)
;; sorts
(declare-sort Atom)
(declare-sort Rel1)
(declare-sort Rel2)
(declare-sort Rel3)
(declare-sort Rel4)
(declare-sort Rel5)
(declare-sort Rel7)
;; --end sorts

;; functions
(declare-fun fn () Rel3)
(declare-fun in_1 (Atom Rel1) Bool)
(declare-fun in_2 (Atom Atom Rel2) Bool)
(declare-fun prod_1x1 (Rel1 Rel1) Rel2)
(declare-fun subset_2 (Rel2 Rel2) Bool)
(declare-fun join_1x2 (Rel1 Rel2) Rel1)
(declare-fun a2r_1 (Atom) Rel1)
(declare-fun subset_1 (Rel1 Rel1) Bool)
(declare-fun join_2x1 (Rel2 Rel1) Rel1)
(declare-fun no_1 (Rel1) Bool)
(declare-fun in_3 (Atom Atom Atom Rel3) Bool)
(declare-fun prod_2x1 (Rel2 Rel1) Rel3)
(declare-fun subset_3 (Rel3 Rel3) Bool)
(declare-fun join_2x3 (Rel2 Rel3) Rel3)
(declare-fun a2r_2 (Atom Atom) Rel2)
(declare-fun join_3x1 (Rel3 Rel1) Rel2)
(declare-fun no_3 (Rel3) Bool)
(declare-fun join_1x3 (Rel1 Rel3) Rel2)
(declare-fun lone_1 (Rel1) Bool)
(declare-fun disjoint_1 (Rel1 Rel1) Bool)
(declare-fun in_4 (Atom Atom Atom Atom Rel4) Bool)
(declare-fun prod_3x1 (Rel3 Rel1) Rel4)
(declare-fun subset_4 (Rel4 Rel4) Bool)
(declare-fun in_5 (Atom Atom Atom Atom Atom Rel5) Bool)
(declare-fun join_3x4 (Rel3 Rel4) Rel5)
(declare-fun a2r_3 (Atom Atom Atom) Rel3)
(declare-fun join_4x1 (Rel4 Rel1) Rel3)
(declare-fun no_5 (Rel5) Bool)
(declare-fun prod_1x4 (Rel1 Rel4) Rel5)
(declare-fun subset_5 (Rel5 Rel5) Bool)
(declare-fun join_1x5 (Rel1 Rel5) Rel4)
(declare-fun in_7 (Atom Atom Atom Atom Atom Atom Atom Rel7) Bool)
(declare-fun join_5x4 (Rel5 Rel4) Rel7)
(declare-fun a2r_4 (Atom Atom Atom Atom) Rel4)
(declare-fun no_4 (Rel4) Bool)
(declare-fun some_1 (Rel1) Bool)
(declare-fun B () Rel1)
(declare-fun A () Rel1)
;; --end functions

;; axioms
(assert 
 (! 
  (forall ((y0 Atom)(x0 Atom)(A Rel1)(B Rel1)) (= (in_2 x0 y0 (prod_1x1 A B)) (and (in_1 x0 A) (in_1 y0 B)))) 
 :named ax0 
 ) 
 )
(assert 
 (! 
  ; subset axiom for Rel2
(forall ((x Rel2)(y Rel2)) (= (subset_2 x y) (forall ((a0 Atom)(a1 Atom)) (=> (in_2 a0 a1 x) (in_2 a0 a1 y))))) 
 :named ax1 
 ) 
 )
(assert 
 (! 
  ; axiom for join_1x2
(forall ((A Rel1)(B Rel2)(y0 Atom)) (= (in_1 y0 (join_1x2 A B)) (exists ((x Atom)) (and (in_1 x A) (in_2 x y0 B))))) 
 :named ax2 
 ) 
 )
(assert 
 (! 
  ; axiom for the conversion function Atom -> Relation
(forall ((x0 Atom)) (and (in_1 x0 (a2r_1 x0)) (forall ((y0 Atom)) (=> (in_1 y0 (a2r_1 x0)) (= x0 y0))))) 
 :named ax3 
 ) 
 )
(assert 
 (! 
  ; subset axiom for Rel1
(forall ((x Rel1)(y Rel1)) (= (subset_1 x y) (forall ((a0 Atom)) (=> (in_1 a0 x) (in_1 a0 y))))) 
 :named ax4 
 ) 
 )
(assert 
 (! 
  ; axiom for join_2x1
(forall ((A Rel2)(B Rel1)(y0 Atom)) (= (in_1 y0 (join_2x1 A B)) (exists ((x Atom)) (and (in_2 y0 x A) (in_1 x B))))) 
 :named ax5 
 ) 
 )
(assert 
 (! 
  ; axiom for 'the expression is empty'
(forall ((a0 Atom)(R Rel1)) (=> (no_1 R) (not (in_1 a0 R)))) 
 :named ax6 
 ) 
 )
(assert 
 (! 
  (forall ((y0 Atom)(x0 Atom)(x1 Atom)(A Rel2)(B Rel1)) (= (in_3 x0 x1 y0 (prod_2x1 A B)) (and (in_2 x0 x1 A) (in_1 y0 B)))) 
 :named ax7 
 ) 
 )
(assert 
 (! 
  ; subset axiom for Rel3
(forall ((x Rel3)(y Rel3)) (= (subset_3 x y) (forall ((a0 Atom)(a1 Atom)(a2 Atom)) (=> (in_3 a0 a1 a2 x) (in_3 a0 a1 a2 y))))) 
 :named ax8 
 ) 
 )
(assert 
 (! 
  ; axiom for join_2x3
(forall ((A Rel2)(B Rel3)(y0 Atom)(y1 Atom)(y2 Atom)) (= (in_3 y0 y1 y2 (join_2x3 A B)) (exists ((x Atom)) (and (in_2 y0 x A) (in_3 x y1 y2 B))))) 
 :named ax9 
 ) 
 )
(assert 
 (! 
  ; axiom for the conversion function Atom -> Relation
(forall ((x0 Atom)(x1 Atom)) (and (in_2 x0 x1 (a2r_2 x0 x1)) (forall ((y0 Atom)(y1 Atom)) (=> (in_2 y0 y1 (a2r_2 x0 x1)) (and (= x0 y0) (= x1 y1)))))) 
 :named ax10 
 ) 
 )
(assert 
 (! 
  ; axiom for join_3x1
(forall ((A Rel3)(B Rel1)(y0 Atom)(y1 Atom)) (= (in_2 y0 y1 (join_3x1 A B)) (exists ((x Atom)) (and (in_3 y0 y1 x A) (in_1 x B))))) 
 :named ax11 
 ) 
 )
(assert 
 (! 
  ; axiom for 'the expression is empty'
(forall ((a0 Atom)(a1 Atom)(a2 Atom)(R Rel3)) (=> (no_3 R) (not (in_3 a0 a1 a2 R)))) 
 :named ax12 
 ) 
 )
(assert 
 (! 
  ; axiom for join_1x3
(forall ((A Rel1)(B Rel3)(y0 Atom)(y1 Atom)) (= (in_2 y0 y1 (join_1x3 A B)) (exists ((x Atom)) (and (in_1 x A) (in_3 x y0 y1 B))))) 
 :named ax13 
 ) 
 )
(assert 
 (! 
  (forall ((X Rel1)) (= (lone_1 X) (forall ((a0 Atom)(b0 Atom)) (=> (and (in_1 a0 X) (in_1 b0 X)) (= a0 b0))))) 
 :named ax14 
 ) 
 )
(assert 
 (! 
  ; (forall ((A Rel1)(B Rel1)) (= (disjoint_1 A B) (forall ((a0 Atom)) (=> (in_1 a0 A) (not (in_1 a0 B)))))); alternative
(forall ((A Rel1)(B Rel1)) (= (disjoint_1 A B) (forall ((a0 Atom)) (not (and (in_1 a0 A) (in_1 a0 B)))))) 
 :named ax15 
 ) 
 )
(assert 
 (! 
  (forall ((y0 Atom)(x0 Atom)(x1 Atom)(x2 Atom)(A Rel3)(B Rel1)) (= (in_4 x0 x1 x2 y0 (prod_3x1 A B)) (and (in_3 x0 x1 x2 A) (in_1 y0 B)))) 
 :named ax16 
 ) 
 )
(assert 
 (! 
  ; subset axiom for Rel4
(forall ((x Rel4)(y Rel4)) (= (subset_4 x y) (forall ((a0 Atom)(a1 Atom)(a2 Atom)(a3 Atom)) (=> (in_4 a0 a1 a2 a3 x) (in_4 a0 a1 a2 a3 y))))) 
 :named ax17 
 ) 
 )
(assert 
 (! 
  ; axiom for join_3x4
(forall ((A Rel3)(B Rel4)(y0 Atom)(y1 Atom)(y2 Atom)(y3 Atom)(y4 Atom)) (= (in_5 y0 y1 y2 y3 y4 (join_3x4 A B)) (exists ((x Atom)) (and (in_3 y0 y1 x A) (in_4 x y2 y3 y4 B))))) 
 :named ax18 
 ) 
 )
(assert 
 (! 
  ; axiom for the conversion function Atom -> Relation
(forall ((x0 Atom)(x1 Atom)(x2 Atom)) (and (in_3 x0 x1 x2 (a2r_3 x0 x1 x2)) (forall ((y0 Atom)(y1 Atom)(y2 Atom)) (=> (in_3 y0 y1 y2 (a2r_3 x0 x1 x2)) (and 
    (= x0 y0)
    (= x1 y1)
    (= x2 y2)
  ))))) 
 :named ax19 
 ) 
 )
(assert 
 (! 
  ; axiom for join_4x1
(forall ((A Rel4)(B Rel1)(y0 Atom)(y1 Atom)(y2 Atom)) (= (in_3 y0 y1 y2 (join_4x1 A B)) (exists ((x Atom)) (and (in_4 y0 y1 y2 x A) (in_1 x B))))) 
 :named ax20 
 ) 
 )
(assert 
 (! 
  ; axiom for 'the expression is empty'
(forall ((a0 Atom)(a1 Atom)(a2 Atom)(a3 Atom)(a4 Atom)(R Rel5)) (=> (no_5 R) (not (in_5 a0 a1 a2 a3 a4 R)))) 
 :named ax21 
 ) 
 )
(assert 
 (! 
  (forall ((y0 Atom)(y1 Atom)(y2 Atom)(y3 Atom)(x0 Atom)(A Rel1)(B Rel4)) (= (in_5 x0 y0 y1 y2 y3 (prod_1x4 A B)) (and (in_1 x0 A) (in_4 y0 y1 y2 y3 B)))) 
 :named ax22 
 ) 
 )
(assert 
 (! 
  ; subset axiom for Rel5
(forall ((x Rel5)(y Rel5)) (= (subset_5 x y) (forall ((a0 Atom)(a1 Atom)(a2 Atom)(a3 Atom)(a4 Atom)) (=> (in_5 a0 a1 a2 a3 a4 x) (in_5 a0 a1 a2 a3 a4 y))))) 
 :named ax23 
 ) 
 )
(assert 
 (! 
  ; axiom for join_1x5
(forall ((A Rel1)(B Rel5)(y0 Atom)(y1 Atom)(y2 Atom)(y3 Atom)) (= (in_4 y0 y1 y2 y3 (join_1x5 A B)) (exists ((x Atom)) (and (in_1 x A) (in_5 x y0 y1 y2 y3 B))))) 
 :named ax24 
 ) 
 )
(assert 
 (! 
  ; axiom for join_5x4
(forall ((A Rel5)(B Rel4)(y0 Atom)(y1 Atom)(y2 Atom)(y3 Atom)(y4 Atom)(y5 Atom)(y6 Atom)) (= (in_7 y0 y1 y2 y3 y4 y5 y6 (join_5x4 A B)) (exists ((x Atom)) (and (in_5 y0 y1 y2 y3 x A) (in_4 x y4 y5 y6 B))))) 
 :named ax25 
 ) 
 )
(assert 
 (! 
  ; axiom for the conversion function Atom -> Relation
(forall ((x0 Atom)(x1 Atom)(x2 Atom)(x3 Atom)) (and (in_4 x0 x1 x2 x3 (a2r_4 x0 x1 x2 x3)) (forall ((y0 Atom)(y1 Atom)(y2 Atom)(y3 Atom)) (=> (in_4 y0 y1 y2 y3 (a2r_4 x0 x1 x2 x3)) (and 
    (= x0 y0)
    (= x1 y1)
    (= x2 y2)
    (= x3 y3)
  ))))) 
 :named ax26 
 ) 
 )
(assert 
 (! 
  ; axiom for 'the expression is empty'
(forall ((a0 Atom)(a1 Atom)(a2 Atom)(a3 Atom)(R Rel4)) (=> (no_4 R) (not (in_4 a0 a1 a2 a3 R)))) 
 :named ax27 
 ) 
 )
(assert 
 (! 
  (forall ((A Rel1)) (= (some_1 A) (exists ((a0 Atom)) (in_1 a0 A)))) 
 :named ax28 
 ) 
 )
;; --end axioms

;; assertions
(assert 
 (! 
  (subset_3 fn (prod_2x1 (prod_1x1 B A) B)) 
 :named a0 
 ) 
 )
(assert 
 (! 
  (forall ((this Atom)) (=> (in_1 this B) (forall ((x0 Atom)) (=> (in_1 x0 A) (lone_1 (join_1x2 (a2r_1 x0) (join_1x3 (a2r_1 this) fn))))))) 
 :named a1 
 ) 
 )
(assert 
 (! 
  (disjoint_1 B A) 
 :named a2 
 ) 
 )
(assert 
 (! 
  (no_5 (prod_1x4 A (prod_3x1 fn A))) 
 :named a3 
 ) 
 )
;; --end assertions

;; command
(assert 
 (! 
  (not (some_1 B)) 
 :named c0 
 ) 
 )
;; --end command

;; lemmas
(assert
 (! 
  ; 1. lemma for join_1x2. direction: join to in
(forall ((a1 Atom)(a0 Atom)(r Rel2)) (=> (in_1 a0 (join_1x2 ; (swapped)
(a2r_1 a1) r)) (in_2 a1 a0 r))) 
 :named l0 
 ) 
 )
(assert
 (! 
  ; 2. lemma for join_1x2. direction: in to join
(forall ((a1 Atom)(a0 Atom)(r Rel2)) (=> (in_2 a1 a0 r) (in_1 a0 (join_1x2 ; (swapped)
(a2r_1 a1) r)))) 
 :named l1 
 ) 
 )
(assert
 (! 
  ; 1. lemma for join_2x1. direction: join to in
(forall ((a0 Atom)(a1 Atom)(r Rel2)) (=> (in_1 a0 (join_2x1 r (a2r_1 a1))) (in_2 a0 a1 r))) 
 :named l2 
 ) 
 )
(assert
 (! 
  ; 2. lemma for join_2x1. direction: in to join
(forall ((a0 Atom)(a1 Atom)(r Rel2)) (=> (in_2 a0 a1 r) (in_1 a0 (join_2x1 r (a2r_1 a1))))) 
 :named l3 
 ) 
 )
(assert
 (! 
  ; lemma about subset 2 and product 1x1 , using join
(forall ((R Rel2)(A Rel1)(B Rel1)) (=> (subset_2 R (prod_1x1 A B)) (forall ((a0 Atom)) (=> (in_1 a0 A) (and (=> (no_1 (join_1x2 (a2r_1 a0) R)) (not (in_1 a0 (join_2x1 R B)))) (=> (not (in_1 a0 (join_2x1 R B))) (no_1 (join_1x2 (a2r_1 a0) R)))))))) 
 :named l4 
 ) 
 )
(assert
 (! 
  ; 1. lemma for join_2x3. direction: join to in
(forall ((a3 Atom)(a2 Atom)(a1 Atom)(a0 Atom)(r Rel3)) (=> (in_3 a3 a1 a0 (join_2x3 ; (swapped)
(a2r_2 a3 a2) r)) (in_3 a2 a1 a0 r))) 
 :named l5 
 ) 
 )
(assert
 (! 
  ; 2. lemma for join_2x3. direction: in to join
(forall ((a3 Atom)(a2 Atom)(a1 Atom)(a0 Atom)(r Rel3)) (=> (in_3 a2 a1 a0 r) (in_3 a3 a1 a0 (join_2x3 ; (swapped)
(a2r_2 a3 a2) r)))) 
 :named l6 
 ) 
 )
(assert
 (! 
  ; 1. lemma for join_3x1. direction: join to in
(forall ((a0 Atom)(a1 Atom)(a2 Atom)(r Rel3)) (=> (in_2 a0 a1 (join_3x1 r (a2r_1 a2))) (in_3 a0 a1 a2 r))) 
 :named l7 
 ) 
 )
(assert
 (! 
  ; 2. lemma for join_3x1. direction: in to join
(forall ((a0 Atom)(a1 Atom)(a2 Atom)(r Rel3)) (=> (in_3 a0 a1 a2 r) (in_2 a0 a1 (join_3x1 r (a2r_1 a2))))) 
 :named l8 
 ) 
 )
(assert
 (! 
  ; lemma about subset 3 and product 2x1 , using join
(forall ((R Rel3)(A Rel2)(B Rel1)) (=> (subset_3 R (prod_2x1 A B)) (forall ((a0 Atom)(a1 Atom)) (=> (in_2 a0 a1 A) (and (=> (no_3 (join_2x3 (a2r_2 a0 a1) R)) (not (in_2 a0 a1 (join_3x1 R B)))) (=> (not (in_2 a0 a1 (join_3x1 R B))) (no_3 (join_2x3 (a2r_2 a0 a1) R)))))))) 
 :named l9 
 ) 
 )
(assert
 (! 
  ; 1. lemma for join_1x3. direction: join to in
(forall ((a2 Atom)(a1 Atom)(a0 Atom)(r Rel3)) (=> (in_2 a1 a0 (join_1x3 ; (swapped)
(a2r_1 a2) r)) (in_3 a2 a1 a0 r))) 
 :named l10 
 ) 
 )
(assert
 (! 
  ; 2. lemma for join_1x3. direction: in to join
(forall ((a2 Atom)(a1 Atom)(a0 Atom)(r Rel3)) (=> (in_3 a2 a1 a0 r) (in_2 a1 a0 (join_1x3 ; (swapped)
(a2r_1 a2) r)))) 
 :named l11 
 ) 
 )
(assert
 (! 
  ; 1. lemma for join_3x4. direction: join to in
(forall ((a5 Atom)(a4 Atom)(a3 Atom)(a2 Atom)(a1 Atom)(a0 Atom)(r Rel4)) (=> (in_5 a5 a4 a2 a1 a0 (join_3x4 ; (swapped)
(a2r_3 a5 a4 a3) r)) (in_4 a3 a2 a1 a0 r))) 
 :named l12 
 ) 
 )
(assert
 (! 
  ; 2. lemma for join_3x4. direction: in to join
(forall ((a5 Atom)(a4 Atom)(a3 Atom)(a2 Atom)(a1 Atom)(a0 Atom)(r Rel4)) (=> (in_4 a3 a2 a1 a0 r) (in_5 a5 a4 a2 a1 a0 (join_3x4 ; (swapped)
(a2r_3 a5 a4 a3) r)))) 
 :named l13 
 ) 
 )
(assert
 (! 
  ; 1. lemma for join_4x1. direction: join to in
(forall ((a0 Atom)(a1 Atom)(a2 Atom)(a3 Atom)(r Rel4)) (=> (in_3 a0 a1 a2 (join_4x1 r (a2r_1 a3))) (in_4 a0 a1 a2 a3 r))) 
 :named l14 
 ) 
 )
(assert
 (! 
  ; 2. lemma for join_4x1. direction: in to join
(forall ((a0 Atom)(a1 Atom)(a2 Atom)(a3 Atom)(r Rel4)) (=> (in_4 a0 a1 a2 a3 r) (in_3 a0 a1 a2 (join_4x1 r (a2r_1 a3))))) 
 :named l15 
 ) 
 )
(assert
 (! 
  ; lemma about subset 4 and product 3x1 , using join
(forall ((R Rel4)(A Rel3)(B Rel1)) (=> (subset_4 R (prod_3x1 A B)) (forall ((a0 Atom)(a1 Atom)(a2 Atom)) (=> (in_3 a0 a1 a2 A) (and (=> (no_5 (join_3x4 (a2r_3 a0 a1 a2) R)) (not (in_3 a0 a1 a2 (join_4x1 R B)))) (=> (not (in_3 a0 a1 a2 (join_4x1 R B))) (no_5 (join_3x4 (a2r_3 a0 a1 a2) R)))))))) 
 :named l16 
 ) 
 )
(assert
 (! 
  ; 1. lemma for join_1x5. direction: join to in
(forall ((a4 Atom)(a3 Atom)(a2 Atom)(a1 Atom)(a0 Atom)(r Rel5)) (=> (in_4 a3 a2 a1 a0 (join_1x5 ; (swapped)
(a2r_1 a4) r)) (in_5 a4 a3 a2 a1 a0 r))) 
 :named l17 
 ) 
 )
(assert
 (! 
  ; 2. lemma for join_1x5. direction: in to join
(forall ((a4 Atom)(a3 Atom)(a2 Atom)(a1 Atom)(a0 Atom)(r Rel5)) (=> (in_5 a4 a3 a2 a1 a0 r) (in_4 a3 a2 a1 a0 (join_1x5 ; (swapped)
(a2r_1 a4) r)))) 
 :named l18 
 ) 
 )
(assert
 (! 
  ; 1. lemma for join_5x4. direction: join to in
(forall ((a0 Atom)(a1 Atom)(a2 Atom)(a3 Atom)(a4 Atom)(a5 Atom)(a6 Atom)(a7 Atom)(r Rel5)) (=> (in_7 a0 a1 a2 a3 a5 a6 a7 (join_5x4 r (a2r_4 a4 a5 a6 a7))) (in_5 a0 a1 a2 a3 a4 r))) 
 :named l19 
 ) 
 )
(assert
 (! 
  ; 2. lemma for join_5x4. direction: in to join
(forall ((a0 Atom)(a1 Atom)(a2 Atom)(a3 Atom)(a4 Atom)(a5 Atom)(a6 Atom)(a7 Atom)(r Rel5)) (=> (in_5 a0 a1 a2 a3 a4 r) (in_7 a0 a1 a2 a3 a5 a6 a7 (join_5x4 r (a2r_4 a4 a5 a6 a7))))) 
 :named l20 
 ) 
 )
(assert
 (! 
  ; lemma about subset 5 and product 1x4 , using join
(forall ((R Rel5)(A Rel1)(B Rel4)) (=> (subset_5 R (prod_1x4 A B)) (forall ((a0 Atom)) (=> (in_1 a0 A) (and (=> (no_4 (join_1x5 (a2r_1 a0) R)) (not (in_1 a0 (join_5x4 R B)))) (=> (not (in_1 a0 (join_5x4 R B))) (no_4 (join_1x5 (a2r_1 a0) R)))))))) 
 :named l21 
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
