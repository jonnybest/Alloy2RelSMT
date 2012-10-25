; found core! unsat
; (ax7 ax8 ax11 ax12 ax13 ax24 ax28 ax29 ax34 ax35 ax39 a1 a4 a10 c0 l0)
(set-option :macro-finder true)
(set-option :mbqi false)
(set-option :produce-unsat-cores false)
;; sorts
(declare-sort Atom)
(declare-sort Rel1)
(declare-sort Rel2)
(declare-sort Rel3)
;; --end sorts

;; functions
(declare-fun transClos (Rel2) Rel2)							; good. ax7, ax8, l0
(declare-fun in_1 (Atom Rel1) Bool)
(declare-fun in_2 (Atom Atom Rel2) Bool)
(declare-fun prod_1x1 (Rel1 Rel1) Rel2)					; ax24, a1
(declare-fun subset_2 (Rel2 Rel2) Bool)					; ax7, ax8, ax11, 
(declare-fun join_1x2 (Rel1 Rel2) Rel1)					; ax12, a10
(declare-fun a2r_1 (Atom) Rel1)									; ax13, a10

(declare-fun subset_1 (Rel1 Rel1) Bool) 				; (ax25 good)
(declare-fun join_2x1 (Rel2 Rel1) Rel1)					; ax28
(declare-fun in_3 (Atom Atom Atom Rel3) Bool)		
(declare-fun prod_2x1 (Rel2 Rel1) Rel3)					; a1, uninterpreted
(declare-fun subset_3 (Rel3 Rel3) Bool)					; ax29, a1
(declare-const waits Rel3)											; a1
(declare-fun join_1x3 (Rel1 Rel3) Rel2)					; ax34, a10
(declare-fun disjoint_1 (Rel1 Rel1) Bool)				; ax35, a4
(declare-fun some_1 (Rel1) Bool)								; ax39, a10, c0
(declare-fun Deadlock () Bool)									; a10, c0
(declare-fun GrabbedInOrder () Bool)						; c0, uninterpreted
(declare-const Mutex Rel1)											; a1
(declare-const Process Rel1)										; a1, a4, a10, c0
(declare-const State Rel1)											; a1, a4, a10

;; --end functions

;; axioms
(assert 
 (! 
  ; core
(forall ((r1 Rel2)) (subset_2 r1 (transClos r1))) 
 :named ax7 
 ) 
 )
(assert 
 (! ; core
  (forall ((y0 Atom)(x0 Atom)(A Rel1)(B Rel1)) (= (in_2 x0 y0 (prod_1x1 A B)) (and (in_1 x0 A) (in_1 y0 B)))) 
 :named ax24 
 ) 
 )
(assert 
 (! 
  ; core
(forall ((r1 Rel2)(r2 Rel2)) (=> (subset_2 r1 r2) (subset_2 (transClos r1) r2))) 
 :named ax8 
 ) 
 )
(assert 
 (! 
  ; core
(forall ((x Rel2)(y Rel2)) (= (subset_2 x y) (forall ((a0 Atom)(a1 Atom)) (=> (in_2 a0 a1 x) (in_2 a0 a1 y))))) 
 :named ax11 
 ) 
 )
(assert 
 (! 
; core  ; axiom for join_1x2
(forall ((A Rel1)(B Rel2)(y0 Atom)) (= (in_1 y0 (join_1x2 A B)) (exists ((x Atom)) (and (in_1 x A) (in_2 x y0 B))))) 
 :named ax12 
 ) 
 )
(assert 
 (! 
; core  ; axiom for the conversion function Atom -> Relation
(forall ((x0 Atom)) (and (in_1 x0 (a2r_1 x0)) (forall ((y0 Atom)) (=> (in_1 y0 (a2r_1 x0)) (= x0 y0))))) 
 :named ax13 
 ) 
 )

(assert 
 (! 
; good assertion  ; subset axiom for Rel1
(forall ((x Rel1)(y Rel1)) (= (subset_1 x y) (forall ((a0 Atom)) (=> (in_1 a0 x) (in_1 a0 y))))) 
 :named ax25 
 ) 
 )
 (assert 
 (! 
 ; core
  (forall ((y0 Atom)(x0 Atom)(x1 Atom)(A Rel2)(B Rel1)) (= (in_3 x0 x1 y0 (prod_2x1 A B)) (and (in_2 x0 x1 A) (in_1 y0 B)))) 
 :named ax28 
 ) 
 )
(assert 
 (! 
; core  ; subset axiom for Rel3
(forall ((x Rel3)(y Rel3)) (= (subset_3 x y) (forall ((a0 Atom)(a1 Atom)(a2 Atom)) (=> (in_3 a0 a1 a2 x) (in_3 a0 a1 a2 y))))) 
 :named ax29 
 ) 
 )
(assert 
 (! 
; core  ; axiom for join_1x3
(forall ((A Rel1)(B Rel3)(y0 Atom)(y1 Atom)) (= (in_2 y0 y1 (join_1x3 A B)) (exists ((x Atom)) (and (in_1 x A) (in_3 x y0 y1 B))))) 
 :named ax34 
 ) 
 )
(assert 
 (! 
; core 
(forall ((A Rel1)(B Rel1)) (= (disjoint_1 A B) (forall ((a0 Atom)) (not (and (in_1 a0 A) (in_1 a0 B)))))) 
 :named ax35 
 ) 
 )

(assert 
 (! ; core
  (forall ((A Rel1)) (= (some_1 A) (exists ((a0 Atom)) (in_1 a0 A)))) 
 :named ax39 
 ) 
 )


;; --end axioms

;; assertions

(assert 
 (! ; core
  (subset_3 waits (prod_2x1 (prod_1x1 State Process) Mutex)) 
 :named a1 
 ) 
 )

(assert 
 (! ; core
  (disjoint_1 Process State) 
 :named a4 
 ) 
 )

(assert 
 (! ; core
  (= Deadlock (and (some_1 Process) (exists ((s Atom)) (and (in_1 s State) (forall ((p Atom)) (=> (in_1 p Process) (some_1 (join_1x2 (a2r_1 p) (join_1x3 (a2r_1 s) waits))))))))) 
 :named a10 
 ) 
 )
;; --end assertions

;; command
(assert 
 (! ; core
  (not (=> (and (some_1 Process) GrabbedInOrder) (not Deadlock))) 
 :named c0 
 ) 
 )
;; --end command
;; lemmas
(assert
 (! ; core
  ; lemma 1 for transClos about the second-last 'middle element'
(forall ((a1 Atom)(a3 Atom)(R Rel2)) (=> (in_2 a1 a3 (transClos R)) (forall ((a2 Atom)) (and (not (= a2 a3)) (or (not (in_2 a1 a2 R)) (and (in_2 a1 a2 R) (in_2 a2 a3 (transClos R))))))))
 :named l0 
 ) 
 )

(check-sat)
(get-unsat-core)