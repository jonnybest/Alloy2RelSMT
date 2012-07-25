;(ax0 ~ax3 ax5 ax8 ax9 ax17 ax21 a4 a6 l3 l7)

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
(declare-fun prod_1x1 (Rel1 Rel1) Rel2)
(declare-fun subset_2 (Rel2 Rel2) Bool)
(declare-fun a2r_1 (Atom) Rel1)
(declare-fun join_1x2 (Rel1 Rel2) Rel1)
(declare-fun freeList () Rel2)
(declare-fun disjoint_1 (Rel1 Rel1) Bool)
(declare-fun trans (Rel2) Bool)
(declare-fun transClos (Rel2) Rel2)
(declare-fun iden () Rel2)
(declare-fun reflTransClos (Rel2) Rel2)
(declare-fun HeapState () Rel1)
(declare-fun Node () Rel1)
;; --end functions

;; axioms
(assert 
 (! 
  (forall ((A Rel1)(B Rel1)(x0 Atom)(y0 Atom)) (= (in_2 x0 y0 (prod_1x1 A B)) (and (in_1 x0 A) (in_1 y0 B)))) 
 :named ax0 
 ) 
 )

(assert 
 (! (not
  (forall ((x Rel2)(y Rel2)) (= (subset_2 x y) (forall ((a0 Atom)(a1 Atom)) (=> (in_2 a0 a1 x) (in_2 a0 a1 y))))) )
 :named ax3 
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
  ; axiom for join_1x2
(forall ((A Rel1)(B Rel2)(y0 Atom)) (= (in_1 y0 (join_1x2 A B)) (exists ((x Atom)) (and (in_1 x A) (in_2 x y0 B))))) 
 :named ax8 
 ) 
 )
(assert 
 (! 
  (forall ((A Rel1)(B Rel1)) (= (disjoint_1 A B) (forall ((a0 Atom)) (=> (in_1 a0 A) (not (in_1 a0 B)))))) 
 :named ax9 
 ) 
 )
(assert 
 (! 
  (forall ((a0 Atom)) (in_2 a0 a0 iden)) 
 :named ax17 
 ) 
 )
(assert 
 (! 
  (forall ((r Rel2)) (subset_2 iden (reflTransClos r))) 
 :named ax21 
 ) 
 )
;; --end axioms

;; assertions
(assert 
 (! 
  (subset_2 freeList (prod_1x1 HeapState Node)) 
 :named a4 
 ) 
 )
(assert 
 (! 
  (disjoint_1 HeapState Node) 
 :named a6 
 ) 
 )

 ;; lemmas
(assert
 (! 
  ; 2. lemma for join_1x2. direction: in to join
(forall ((a1 Atom)(a0 Atom)(r Rel2)) (=> (in_2 a1 a0 r) (in_1 a0 (join_1x2 ; (swapped)
(a2r_1 a1) r)))) 
 :named l3 
 ) 
 )
(assert
 (! 
  (forall ((a1 Atom)(a2 Atom)(r Rel2)) (=> (in_2 a1 a2 (reflTransClos r)) (exists ((a3 Atom)) (and (in_2 a1 a3 (reflTransClos r)) (in_2 a3 a2 r)))))  
	:named l7)
 )
;; --end lemmas

(check-sat)
(get-model)
(get-unsat-core)
