; likely core of the marksweepgc_soundness1 problem
; [inlined subset axiom into ax21 for brevity]
;(ax0 ax9 ax17 ax21 a6 l7)

(set-logic AUFLIA)
(set-option :produce-unsat-cores true)
(set-option :macro-finder true)
;; sorts
(declare-sort Atom)
(declare-sort Rel1)
(declare-sort Rel2)
;; --end sorts

(declare-fun in_1 (Atom Rel1) Bool)
(declare-fun in_2 (Atom Atom Rel2) Bool)
(declare-fun prod_1x1 (Rel1 Rel1) Rel2)
(declare-fun disjoint_1 (Rel1 Rel1) Bool)
(declare-fun iden () Rel2)
(declare-fun reflTransClos (Rel2) Rel2)
(declare-fun HeapState () Rel1)
(declare-fun Node () Rel1)
(declare-fun Helper () Rel1)

;; axioms
(assert (! 
  (forall ((A Rel1)(B Rel1)(x0 Atom)(y0 Atom)) 
		(= (in_2 x0 y0 (prod_1x1 A B)) (and (in_1 x0 A) (in_1 y0 B)))) 
 :named ax0 ))
(assert (! 
  (forall ((A Rel1)(B Rel1)) 
		(= 
			(disjoint_1 A B) 
			(forall ((a0 Atom)) 
				(not (and 
					(in_1 a0 A) 
					(in_1 a0 B))))))
 :named ax9 ))
(assert (! 
  (forall ((a0 Atom)) 
		(in_2 a0 a0 iden))
 :named ax17  )  )
(assert (! 
  (forall ((r Rel2)(a0 Atom)(a1 Atom))
		(= (in_2 a0 a1 iden) (in_2 a0 a1 (reflTransClos r))))
 :named ax21 ))
(assert  (! (not 
  (disjoint_1 HeapState Node) )
 :named a6 ))
(assert  (! 
  (disjoint_1 Node Helper)
 :named helper ))
(assert (! 
  (forall ((a1 Atom)(a2 Atom)(r Rel2)) 
		(=> 
			(in_2 a1 a2 (reflTransClos r)) 
			(exists ((a3 Atom)) 
				(and 
					(in_2 a1 a3 (reflTransClos r)) 
					(in_2 a3 a2 r)))))
	:named l7 ))
(assert  (!  
  (forall ((r0 Rel1)(r1 Rel1))(= (= r0 r1) (forall ((a Atom))(= (in_1 a r0)(in_1 a r1)))))
 :named equality1 ))
(assert  (!  
  (forall ((r0 Rel2)(r1 Rel2))(= (= r0 r1) (forall ((a Atom)(b Atom))(= (in_2 a b r0)(in_2 a b r1)))))
 :named equality2 ))
(check-sat)
(get-model)