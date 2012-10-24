(set-option :macro-finder true)
;(set-option :produce-unsat-cores true)

;; sorts
(declare-sort Atom)
(declare-sort Rel1)
(declare-sort Rel2)

(declare-fun in_2 (Atom Atom Rel2) Bool)
(declare-fun subset_2 (Rel2 Rel2) Bool)
(declare-fun trans (Rel2) Bool)
(declare-fun transClos (Rel2) Rel2)

(assert 
 (! 
  ; subset axiom for Rel2
(forall ((x Rel2)(y Rel2)) (= (subset_2 x y) (forall ((a0 Atom)(a1 Atom)) (=> (in_2 a0 a1 x) (in_2 a0 a1 y))))) 
 :named ax2 
 ) 
 )
 (assert 
 (! 
  ; this axiom defines transitivity
(forall ((r Rel2)) (= (trans r) (forall ((a1 Atom)(a2 Atom)(a3 Atom)) (=> (and (in_2 a1 a2 r) (in_2 a2 a3 r)) (in_2 a1 a3 r))))) 
 :named ax17 
 ) 
 )
(assert 
 (! 
  ; this axioms satisfies that r should be in transclos of r.				extensive
(forall ((r Rel2)) (subset_2 r (transClos r))) 
 :named ax18 
 ) 
 )
(assert 
 (! 
  ; this axiom satisfies transitivity for transclos. 								transitive
(forall ((r Rel2)) (trans (transClos r))) 
 :named ax19 
 ) 
 )
(assert 
 (! 
  ; this axiom satisfies minimality of transclos. 									?
 (forall ((r1 Rel2)(r2 Rel2)) (=> (and (subset_2 r1 r2) (trans r2)) (subset_2 (transClos r1) r2))) 
 :named ax20 
 ) 
 )
 
 (assert
 (! 
 (not
  (forall ((a1 Atom)(a2 Atom)(r Rel2)) (=> (in_2 a1 a2 (transClos r)) (exists ((a3 Atom)) (and (in_2 a1 a3 (transClos r)) (in_2 a3 a2 r))))) 
	)
 :named l13 
 ) 
 )
 
 (check-sat)
 (get-model)