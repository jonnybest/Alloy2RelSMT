; probably sat
; (does not terminate)
(set-option :macro-finder true)

;; sorts
(declare-sort Atom)
(declare-sort Rel1)
(declare-sort Rel2)
(declare-sort Rel3)
;; --end sorts

;; functions
(declare-fun in_1 (Atom Rel1) Bool)
(declare-fun in_2 (Atom Atom Rel2) Bool)
(declare-fun prod_1x1 (Rel1 Rel1) Rel2)					; ax24, a1
(declare-fun subset_2 (Rel2 Rel2) Bool)					; ax7, ax8, ax11, 
(declare-fun join_1x2 (Rel1 Rel2) Rel1)					; ax12, a10
(declare-fun a2r_1 (Atom) Rel1)									; ax13, a10

(declare-fun subset_1 (Rel1 Rel1) Bool)
(declare-fun join_2x1 (Rel2 Rel1) Rel1)
(declare-fun in_3 (Atom Atom Atom Rel3) Bool)
(declare-fun prod_2x1 (Rel2 Rel1) Rel3)
(declare-fun subset_3 (Rel3 Rel3) Bool)
(declare-const waits Rel3)											; a1
(declare-fun join_1x3 (Rel1 Rel3) Rel2)
(declare-fun disjoint_1 (Rel1 Rel1) Bool)
(declare-fun some_1 (Rel1) Bool)
(declare-fun Deadlock () Bool)
(declare-fun GrabbedInOrder () Bool)
(declare-const Mutex Rel1)											; a1
(declare-const Process Rel1)										; a1, a4, a10, c0
(declare-const State Rel1)											; a1, a4, a10
(declare-fun no_1 (Rel1) Bool)
(declare-fun a2r_2 (Atom Atom) Rel2)
(declare-fun join_3x1 (Rel3 Rel1) Rel2)
(declare-fun no_3 (Rel3) Bool)
(declare-fun one_1 (Rel1) Bool)
(declare-fun join_2x3 (Rel2 Rel3) Rel3)
;; --end functions

;; axioms
 ; missing: (forall ((r1 Rel2)) (subset_2 r1 (transClos r1))) 
 ; missing: (forall ((r1 Rel2)(r2 Rel2)) (=> (subset_2 r1 r2) (subset_2 (transClos r1) r2))) 
(assert 
 (! 
  (forall ((y0 Atom)(x0 Atom)(A Rel1)(B Rel1)) (= (in_2 x0 y0 (prod_1x1 A B)) (and (in_1 x0 A) (in_1 y0 B)))) 
 :named ax0 
 ) 
 )
(assert 
 (! 
  ; subset axiom for Rel2
  ; core
(forall ((x Rel2)(y Rel2)) (= (subset_2 x y) (forall ((a0 Atom)(a1 Atom)) (=> (in_2 a0 a1 x) (in_2 a0 a1 y))))) 
 :named ax1 
 ) 
 )
(assert 
 (! 
; core  ; axiom for join_1x2
(forall ((A Rel1)(B Rel2)(y0 Atom)) (= (in_1 y0 (join_1x2 A B)) (exists ((x Atom)) (and (in_1 x A) (in_2 x y0 B))))) 
 :named ax2 
 ) 
 )
(assert 
 (! 
; core  ; axiom for the conversion function Atom -> Relation
(forall ((x0 Atom)) (and (in_1 x0 (a2r_1 x0)) (forall ((y0 Atom)) (=> (in_1 y0 (a2r_1 x0)) (= x0 y0))))) 
 :named ax3 
 ) 
 )

(assert 
 (! 
; good assertion  ; subset axiom for Rel1
(forall ((x Rel1)(y Rel1)) (= (subset_1 x y) (forall ((a0 Atom)) (=> (in_1 a0 x) (in_1 a0 y))))) 
 :named ax4 
 ) 
 )
(assert 
 (! 
 ; core
  (forall ((y0 Atom)(x0 Atom)(x1 Atom)(A Rel2)(B Rel1)) (= (in_3 x0 x1 y0 (prod_2x1 A B)) (and (in_2 x0 x1 A) (in_1 y0 B)))) 
 :named ax7 
 ) 
 )
(assert 
 (! 
; core  ; subset axiom for Rel3
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
; core  ; axiom for join_1x3
(forall ((A Rel1)(B Rel3)(y0 Atom)(y1 Atom)) (= (in_2 y0 y1 (join_1x3 A B)) (exists ((x Atom)) (and (in_1 x A) (in_3 x y0 y1 B))))) 
 :named ax13 
 ) 
 )
(assert 
 (! 
; core 
(forall ((A Rel1)(B Rel1)) (= (disjoint_1 A B) (forall ((a0 Atom)) (not (and (in_1 a0 A) (in_1 a0 B)))))) 
 :named ax14 
 ) 
 )
(assert 
 (! ; core
  (forall ((A Rel1)) (= (some_1 A) (exists ((a0 Atom)) (in_1 a0 A)))) 
 :named ax15 
 ) 
 )
(assert 
 (! 
  (forall ((X Rel1)) (= (one_1 X) (and (exists ((a0 Atom)) (in_1 a0 X)) (forall ((a0 Atom)(b0 Atom)) (=> (and (in_1 a0 X) (in_1 b0 X)) (= a0 b0)))))) 
 :named ax16 
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
;; --end axioms

;; assertions
(assert 
 (! ; core
  (subset_3 waits (prod_2x1 (prod_1x1 State Process) Mutex)) 
 :named a0 
 ) 
 )
(assert 
 (! 
  (disjoint_1 Mutex Process) 
 :named a1 
 ) 
 )
(assert 
 (! 
  (disjoint_1 Mutex State) 
 :named a2 
 ) 
 )
(assert 
 (! ; core
  (disjoint_1 Process State) 
 :named a3 
 ) 
 )
(assert 
 (! ; core
  (= Deadlock (and (some_1 Process) (exists ((s Atom)) (and (in_1 s State) (forall ((p Atom)) (=> (in_1 p Process) (some_1 (join_1x2 (a2r_1 p) (join_1x3 (a2r_1 s) waits))))))))) 
 :named a4 
 ) 
 )
(assert 
 (! 
  (= GrabbedInOrder true) 
 :named a5 
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

;; 
(assert
 (! ; core
	; missing: (forall ((a1 Atom)(a3 Atom)(R Rel2)) (=> (in_2 a1 a3 (transClos R)) (forall ((a2 Atom)) (or (not (in_2 a1 a2 R)) (and (in_2 a1 a2 R) (in_2 a2 a3 (transClos R))))))) 
	true ; stand-in for the transClos lemma
 ) 
 )
(assert
 (! 
  ; 1. lemma for join_1x2. direction: join to in
(forall ((a1 Atom)(a0 Atom)(r Rel2)) (=> (in_1 a0 (join_1x2 ; (swapped)
(a2r_1 a1) r)) (in_2 a1 a0 r))) 
 :named l12 
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
;; --end lemmas

(check-sat)
