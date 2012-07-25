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
(declare-fun marked () Rel2)
(declare-fun HeapState () Rel1)
(declare-fun Node () Rel1)

;; axioms
(assert 
 (! 
  (forall ((A Rel1)(B Rel1)(x0 Atom)(y0 Atom)) (and
		; (or (not (in_2 x0 y0 (prod_1x1 A B)) (and (in_1 x0 A) (in_1 y0 B))))
		; (or (in_2 x0 y0 (prod_1x1 A B)) (not (and (in_1 x0 A) (in_1 y0 B))))
		(=> (in_2 x0 y0 (prod_1x1 A B)) (and (in_1 x0 A) (in_1 y0 B)))
		(=> (and (in_1 x0 A) (in_1 y0 B)) (in_2 x0 y0 (prod_1x1 A B)))
	)) 	
 :named ax0 
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
  (subset_2 marked (prod_1x1 HeapState Node)) 
 :named a3 
 ) 
 )
 (get-model)
 (check-sat)
 