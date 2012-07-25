;(ax0 ax3 ax5 ax8 ax9 ax17 ax21 a4 a6 ~l3 l7)

(set-logic AUFLIA)
(set-option :macro-finder true)
(set-option :produce-unsat-cores true)
;; sorts
(declare-sort Atom)
(declare-sort Rel1)
(declare-sort Rel2)
;; --end sorts

;; functions
(declare-fun in_1 (Atom Rel1) Bool)
(declare-fun in_2 (Atom Atom Rel2) Bool)
(declare-fun a2r_1 (Atom) Rel1)
(declare-fun join_1x2 (Rel1 Rel2) Rel1)
;; --end functions

;; axioms

(assert 
 (! 
  (forall ((x0 Atom)) (and (in_1 x0 (a2r_1 x0)) (forall ((y0 Atom)) (=> (in_1 y0 (a2r_1 x0)) (= x0 y0))))) 
 :named ax5 
 ) 
 )

(assert 
 (! 
  ; axiom for join_1x2
(forall ((A Rel1)(B Rel2)(y0 Atom)) (= (in_1 y0 (join_1x2 A B)) (exists ((x Atom)) (and (in_1 x A) (in_2 x y0 B))))) 
 :named ax8 
 ) 
 )

 ;; lemmas
 ; (assert
 ; (! (not
  ; 1. lemma for join_1x2. direction: join to in
; (forall ((a1 Atom)(a0 Atom)(r Rel2)) (=> (in_1 a0 (join_1x2 ; (swapped)
; (a2r_1 a1) r)) (in_2 a1 a0 r))) )
 ; :named notl2 
 ; ) 
 ; )
(assert
 (! (not
 ; 2. lemma for join_1x2. direction: in to join
(forall ((a1 Atom)(a0 Atom)(r Rel2)) (=> (in_2 a1 a0 r) (in_1 a0 (join_1x2 ; (swapped)
(a2r_1 a1) r)))) )
 :named notl3 
 ) 
 )
 
;; --end lemmas

(check-sat)
(get-model)
(get-unsat-core)
