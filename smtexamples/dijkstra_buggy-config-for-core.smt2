; found core! unsat
; (ax7 ax8 ax11 ax12 ax13 ax24 ax25 ax26 ax28 ax29 ax34 ax35 ax39 a1 a4 a10 c0 l0)
(set-option :macro-finder true)
(set-option :mbqi true)
(set-option :produce-unsat-cores true)
;; sorts
(declare-sort Rel1)
(declare-sort Atom)
(declare-sort Rel2)
(declare-sort Rel3)
;; --end sorts

;; functions
(declare-fun finite (Rel1) Bool)
(declare-fun ord (Rel1 Atom) Int)
(declare-fun at (Rel1 Int) Atom)
(declare-fun in_1 (Atom Rel1) Bool)
(declare-fun in_2 (Atom Atom Rel2) Bool)
(declare-fun none () Rel1)
(declare-fun nextMutex () Rel2)
(declare-fun trans (Rel2) Bool)
(declare-fun transClos (Rel2) Rel2)
(declare-fun domRestr_2 (Rel1 Rel2) Rel2)
(declare-fun subset_2 (Rel2 Rel2) Bool)
(declare-fun join_1x2 (Rel1 Rel2) Rel1)
(declare-fun a2r_1 (Atom) Rel1)
(declare-fun nextsMutex (Rel1) Rel1)
(declare-fun firstMutex () Rel1)
(declare-fun lastMutex () Rel1)
(declare-fun card_1 (Rel1) Int)
(declare-fun nextState () Rel2)
(declare-fun nextsState (Rel1) Rel1)
(declare-fun firstState () Rel1)
(declare-fun lastState () Rel1)
(declare-fun holds () Rel3)
(declare-fun prod_1x1 (Rel1 Rel1) Rel2)
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
(declare-fun waits () Rel3)
(declare-fun join_1x3 (Rel1 Rel3) Rel2)
(declare-fun disjoint_1 (Rel1 Rel1) Bool)
(declare-fun Initial (Rel1) Bool)
(declare-fun union_2 (Rel2 Rel2) Rel2)
(declare-fun no_2 (Rel2) Bool)
(declare-fun IsFree (Rel1 Rel1) Bool)
(declare-fun transp (Rel2) Rel2)
(declare-fun IsStalled (Rel1 Rel1) Bool)
(declare-fun some_1 (Rel1) Bool)
(declare-fun GrabMutex (Rel1 Rel1 Rel1 Rel1) Bool)
(declare-fun union_1 (Rel1 Rel1) Rel1)
(declare-fun diff_1 (Rel1 Rel1) Rel1)
(declare-fun one_1 (Rel1) Bool)
(declare-fun ReleaseMutex (Rel1 Rel1 Rel1 Rel1) Bool)
(declare-fun Deadlock () Bool)
(declare-fun GrabbedInOrder () Bool)
(declare-fun Mutex () Rel1)
(declare-fun Process () Rel1)
(declare-fun State () Rel1)
;; --end functions

;; axioms

(assert 
 (! 
  ; good
(forall ((a Atom)) (not (in_1 a none))) 
 :named ax2 
 ) 
 )
(assert 
 (! 
  ; good
(not (= none Mutex)) 
 :named ax4 
 ) 
 )

(assert 
 (! 
  ; core
(forall ((r1 Rel2)) (subset_2 r1 (transClos r1))) 
 :named ax7 
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
  ; this axiom satisfies that tcl should be idempotent
(forall ((r1 Rel2)) (= (transClos (transClos r1)) (transClos r1))) 
 :named ax9 
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
  ; axiom for the function 'nexts' of Mutex
(forall ((e Rel1)) (=> (subset_1 e Mutex) (= (nextsMutex e) (join_1x2 e (transClos nextMutex))))) 
 :named ax14 
 ) 
 )
(assert 
 (! 
  ; axiom for firstMutex
(= firstMutex (a2r_1 (at Mutex 1))) 
 :named ax15 
 ) 
 )
(assert 
 (! 
  ; axiom about finite Relations having a card > ord > 1
(forall ((a0 Atom)(R Rel1)) (=> (and (finite R) (in_1 a0 R)) (and (>= (card_1 R) (ord R a0)) (>= (ord R a0) 1)))) 
 :named ax16 
 ) 
 )
(assert 
 (! 
  ; axiom about finite Relations having atoms for certain numbers in ord
(forall ((a0 Atom)(R Rel1)(i Int)) (=> (and (finite R) (and (>= (card_1 R) (ord R a0)) (>= (ord R a0) 1))) (exists ((i Int)) (and (in_1 a0 R) (= (ord R a0) i))))) 
 :named ax17 
 ) 
 )
(assert 
 (! 
  ; finite axiom for lastMutex
(= lastMutex (a2r_1 (at Mutex (card_1 Mutex)))) 
 :named ax18 
 ) 
 )
(assert 
 (! 
  ; axiom for nextState
(forall ((a Atom)(b Atom)) (=> (and (in_1 a State) (in_1 b State)) (= (in_2 a b nextState) (= (ord State b) (+ (ord State a) 1))))) 
 :named ax19 
 ) 
 )
(assert 
 (! 
  ; 'there is no empty ordered relation' axiom for nextState
(not (= none State)) 
 :named ax20 
 ) 
 )
(assert 
 (! 
  ; axiom for the function 'nexts' of State
(forall ((e Rel1)) (=> (subset_1 e State) (= (nextsState e) (join_1x2 e (transClos nextState))))) 
 :named ax21 
 ) 
 )
(assert 
 (! 
  ; axiom for firstState
(= firstState (a2r_1 (at State 1))) 
 :named ax22 
 ) 
 )
(assert 
 (! 
  ; finite axiom for lastState
(= lastState (a2r_1 (at State (card_1 State)))) 
 :named ax23 
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
; core  ; subset axiom for Rel1
(forall ((x Rel1)(y Rel1)) (= (subset_1 x y) (forall ((a0 Atom)) (=> (in_1 a0 x) (in_1 a0 y))))) 
 :named ax25 
 ) 
 )
(assert 
 (! 
; core  ; axiom for join_2x1
(forall ((A Rel2)(B Rel1)(y0 Atom)) (= (in_1 y0 (join_2x1 A B)) (exists ((x Atom)) (and (in_2 y0 x A) (in_1 x B))))) 
 :named ax26 
 ) 
 )
(assert 
 (! 
  ; axiom for 'the expression is empty'
(forall ((a0 Atom)(R Rel1)) (=> (no_1 R) (not (in_1 a0 R)))) 
 :named ax27 
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
  ; axiom for join_2x3
(forall ((A Rel2)(B Rel3)(y0 Atom)(y1 Atom)(y2 Atom)) (= (in_3 y0 y1 y2 (join_2x3 A B)) (exists ((x Atom)) (and (in_2 y0 x A) (in_3 x y1 y2 B))))) 
 :named ax30 
 ) 
 )
(assert 
 (! 
  ; axiom for the conversion function Atom -> Relation
(forall ((x0 Atom)(x1 Atom)) (and (in_2 x0 x1 (a2r_2 x0 x1)) (forall ((y0 Atom)(y1 Atom)) (=> (in_2 y0 y1 (a2r_2 x0 x1)) (and (= x0 y0) (= x1 y1)))))) 
 :named ax31 
 ) 
 )
(assert 
 (! 
  ; axiom for join_3x1
(forall ((A Rel3)(B Rel1)(y0 Atom)(y1 Atom)) (= (in_2 y0 y1 (join_3x1 A B)) (exists ((x Atom)) (and (in_3 y0 y1 x A) (in_1 x B))))) 
 :named ax32 
 ) 
 )
(assert 
 (! 
  ; axiom for 'the expression is empty'
(forall ((a0 Atom)(a1 Atom)(a2 Atom)(R Rel3)) (=> (no_3 R) (not (in_3 a0 a1 a2 R)))) 
 :named ax33 
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
 (!  ; blocker?
  ; axiom for 'the expression is empty'
(forall ((a0 Atom)(a1 Atom)(R Rel2)) (=> (no_2 R) (not (in_2 a0 a1 R)))) 
 :named ax37 
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
(forall ((a1 Atom)(a3 Atom)(R Rel2)) (=> (in_2 a1 a3 (transClos R)) (forall ((a2 Atom)) (or (not (in_2 a1 a2 R)) (and (in_2 a1 a2 R) (in_2 a2 a3 (transClos R))))))) 
 :named l0 
 ) 
 )

 
(check-sat)
(get-unsat-core)