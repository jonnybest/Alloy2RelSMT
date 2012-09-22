(set-logic AUFLIA)
(set-option :macro-finder true)
(set-option :produce-unsat-cores true)
;; sorts
(declare-sort Atom)
(declare-sort Rel1)
(declare-sort Rel2)
(declare-sort Rel3)
;; --end sorts

;; functions
(declare-fun holds () Rel3)
(declare-fun in_1 (Atom Rel1) Bool)
(declare-fun in_2 (Atom Atom Rel2) Bool)
(declare-fun prod_1x1 (Rel1 Rel1) Rel2)
(declare-fun in_3 (Atom Atom Atom Rel3) Bool)
(declare-fun prod_2x1 (Rel2 Rel1) Rel3)
(declare-fun subset_3 (Rel3 Rel3) Bool)
(declare-fun waits () Rel3)
(declare-fun subset_2 (Rel2 Rel2) Bool)
(declare-fun join_1x3 (Rel1 Rel3) Rel2)
(declare-fun a2r_1 (Atom) Rel1)
(declare-fun valid () Rel3)
(declare-fun overr_2 (Rel2 Rel2) Rel2)
(declare-fun disjoint_1 (Rel1 Rel1) Bool)
(declare-fun Process () Rel1)
(declare-fun Mutex () Rel1)
(declare-fun State () Rel1)
;; --end functions

;; axioms
(assert 
 (! 
  (forall ((A Rel1)(B Rel1)(x0 Atom)(y0 Atom)) (= (in_2 x0 y0 (prod_1x1 A B)) (and (in_1 x0 A) (in_1 y0 B)))) 
 :named ax0 
 ) 
 )
(assert 
 (! 
  (forall ((A Rel2)(B Rel1)(x0 Atom)(x1 Atom)(y0 Atom)) (= (in_3 x0 x1 y0 (prod_2x1 A B)) (and (in_2 x0 x1 A) (in_1 y0 B)))) 
 :named ax1 
 ) 
 )
(assert 
 (! 
  (forall ((x Rel3)(y Rel3)) (= (subset_3 x y) (forall ((a0 Atom)(a1 Atom)(a2 Atom)) (=> (in_3 a0 a1 a2 x) (in_3 a0 a1 a2 y))))) 
 :named ax2 
 ) 
 )
(assert 
 (! 
  (forall ((x Rel2)(y Rel2)) (= (subset_2 x y) (forall ((a0 Atom)(a1 Atom)) (=> (in_2 a0 a1 x) (in_2 a0 a1 y))))) 
 :named ax3 
 ) 
 )
(assert 
 (! 
  ; axiom for join_1x3
(forall ((A Rel1)(B Rel3)(y0 Atom)(y1 Atom)) (= (in_2 y0 y1 (join_1x3 A B)) (exists ((x Atom)) (and (in_1 x A) (in_3 x y0 y1 B))))) 
 :named ax4 
 ) 
 )
(assert 
 (! 
  (forall ((x0 Atom)) (and (in_1 x0 (a2r_1 x0)) (forall ((y0 Atom)) (=> (in_1 y0 (a2r_1 x0)) (= x0 y0))))) 
 :named ax5 
 ) 
 )
(assert 
 (! 
  ; axiom for override, arity 2
(forall ((a0 Atom)(a1 Atom)(P Rel2)(Q Rel2)) (=> (in_2 a0 a1 (overr_2 P Q)) (or (in_2 a0 a1 Q) (and (in_2 a0 a1 P) (exists ((b0 Atom)(b1 Atom)) (not (and (in_2 b0 b1 Q) (= a0 b0)))))))) 
 :named ax6 
 ) 
 )
(assert 
 (! 
  (forall ((A Rel1)(B Rel1)) (= (disjoint_1 A B) (forall ((a0 Atom)) (=> (in_1 a0 A) (not (in_1 a0 B)))))) 
 :named ax7 
 ) 
 )
(assert 
 (! 
  (forall ((A Rel1)(B Rel1)) (= (disjoint_1 A B) (forall ((a0 Atom)) (=> (in_1 a0 A) (not (in_1 a0 B)))))) 
 :named ax8 
 ) 
 )
(assert 
 (! 
  (forall ((A Rel1)(B Rel1)) (= (disjoint_1 A B) (forall ((a0 Atom)) (=> (in_1 a0 A) (not (in_1 a0 B)))))) 
 :named ax9 
 ) 
 )
;; --end axioms

;; assertions
(assert 
 (! 
  (subset_3 holds (prod_2x1 (prod_1x1 State Process) Mutex)) 
 :named a0 
 ) 
 )
(assert 
 (! 
  (subset_3 waits (prod_2x1 (prod_1x1 State Process) Mutex)) 
 :named a1 
 ) 
 )
(assert 
 (! 
  (subset_3 valid (prod_2x1 (prod_1x1 State Process) Mutex)) 
 :named a2 
 ) 
 )
(assert 
 (! 
  (forall ((this Atom)) (=> (in_1 this State) (subset_2 (join_1x3 (a2r_1 this) valid) (overr_2 (join_1x3 (a2r_1 this) holds) (join_1x3 (a2r_1 this) waits))))) 
 :named a3 
 ) 
 )
(assert 
 (! 
  (disjoint_1 Process Mutex) 
 :named a4 
 ) 
 )
(assert 
 (! 
  (disjoint_1 Process State) 
 :named a5 
 ) 
 )
(assert 
 (! 
  (disjoint_1 Mutex State) 
 :named a6 
 ) 
 )
;; --end assertions

;; command
;; --end command

;; lemmas
(assert
 (! 
  ; 1. lemma for join_1x3. direction: join to in
(forall ((a2 Atom)(a1 Atom)(a0 Atom)(r Rel3)) (=> (in_2 a1 a0 (join_1x3 ; (swapped)
(a2r_1 a2) r)) (in_3 a2 a1 a0 r))) 
 :named l0 
 ) 
 )
(assert
 (! 
  ; 2. lemma for join_1x3. direction: in to join
(forall ((a2 Atom)(a1 Atom)(a0 Atom)(r Rel3)) (=> (in_3 a2 a1 a0 r) (in_2 a1 a0 (join_1x3 ; (swapped)
(a2r_1 a2) r)))) 
 :named l1 
 ) 
 )
;; --end lemmas

;; -- key stuff for debugging --
;\problem {(
;(finite State)
;)-> (
;
;;\predicates {

;;}

;; -- END key stuff --
(check-sat)
(get-unsat-core)
