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
; this axiom satisfies transitivity for transclos
(forall ((r1 Rel2)) (trans (transClos r1))) 
:named ax6 
) 
)
(assert 
(! 
; this axioms satisfies that tcl is extensive
(forall ((r1 Rel2)) (subset_2 r1 (transClos r1))) 
:named ax7 
) 
)
(assert 
(! 
; this axiom satisfies that transclos is increasing
(forall ((r1 Rel2)(r2 Rel2)) (=> (subset_2 r1 r2) (subset_2 (transClos r1) r2))) 
:named ax8 
) 
)
(assert 
(! 
; this axiom satisfies that tcl should be idempotent
(forall ((r1 Rel2)) (= (transClos (transClos r1)) (transClos r1))) 
:named ax9 
) 
)
 
 (assert
 (! 
 (not
 ;(forall ((a1 Atom)(a3 Atom)(r Rel2)) (=> (in_2 a1 a3 (transClos r)) (exists ((a2 Atom)) (or (not (in_2 a1 a2 r)) (and (in_2 a1 a2 r) (in_2 a2 a3 (transClos r)))))))
  (forall ((a1 Atom)(a3 Atom)(r Rel2)) (=> (in_2 a1 a3 (transClos r)) (exists ((a2 Atom)) (or (not (in_2 a2 a3 r)) (and (in_2 a2 a3 r) (in_2 a1 a2 (transClos r)))))))
	)
 :named l13 
 ) 
 )
 
 (check-sat)
 (get-model)