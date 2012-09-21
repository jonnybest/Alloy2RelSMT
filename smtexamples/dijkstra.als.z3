(set-logic AUFLIA)
(set-option :macro-finder true)
(set-option :produce-unsat-cores true)
;; sorts
(declare-sort Rel1)
(declare-sort Atom)
(declare-sort Rel2)
(declare-sort Rel3)
;; --end sorts

;; functions
(declare-fun finite (Rel1) Bool)
(declare-fun N_Int () Rel1)
(declare-fun i2a (Int) Atom)
(declare-fun a2i (Atom) Int)
(declare-fun ord (Rel1 Atom) Int)
(declare-fun at (Rel1 Int) Atom)
(declare-fun in_1 (Atom Rel1) Bool)
(declare-fun in_2 (Atom Atom Rel2) Bool)
(declare-fun none () Rel1)
(declare-fun nextState () Rel2)
(declare-fun a2r_1 (Atom) Rel1)
(declare-fun firstState () Rel1)
(declare-fun lastState () Rel1)
(declare-fun card_1 (Rel1) Int)
(declare-fun nextMutex () Rel2)
(declare-fun firstMutex () Rel1)
(declare-fun lastMutex () Rel1)
(declare-fun holds () Rel3)
(declare-fun prod_1x1 (Rel1 Rel1) Rel2)
(declare-fun in_3 (Atom Atom Atom Rel3) Bool)
(declare-fun prod_2x1 (Rel2 Rel1) Rel3)
(declare-fun subset_3 (Rel3 Rel3) Bool)
(declare-fun waits () Rel3)
(declare-fun subset_2 (Rel2 Rel2) Bool)
(declare-fun join_1x3 (Rel1 Rel3) Rel2)
(declare-fun disjoint_1 (Rel1 Rel1) Bool)
(declare-fun Initial (Rel1) Bool)
(declare-fun union_2 (Rel2 Rel2) Rel2)
(declare-fun no_2 (Rel2) Bool)
(declare-fun IsFree (Rel1 Rel1) Bool)
(declare-fun transp (Rel2) Rel2)
(declare-fun join_1x2 (Rel1 Rel2) Rel1)
(declare-fun no_1 (Rel1) Bool)
(declare-fun IsStalled (Rel1 Rel1) Bool)
(declare-fun some_1 (Rel1) Bool)
(declare-fun GrabMutex (Rel1 Rel1 Rel1 Rel1) Bool)
(declare-fun subset_1 (Rel1 Rel1) Bool)
(declare-fun union_1 (Rel1 Rel1) Rel1)
(declare-fun diff_1 (Rel1 Rel1) Rel1)
(declare-fun one_1 (Rel1) Bool)
(declare-fun ReleaseMutex (Rel1 Rel1 Rel1 Rel1) Bool)
(declare-fun GrabOrRelease () Bool)
(declare-fun Deadlock () Bool)
(declare-fun GrabbedInOrder () Bool)
(declare-fun ShowDijkstra () Bool)
(declare-fun State () Rel1)
(declare-fun Mutex () Rel1)
(declare-fun Process () Rel1)
;; --end functions

;; axioms
(assert 
 (! 
  (forall ((a Atom)) (=> (in_1 a N_Int) (= (i2a (a2i a)) a))) 
 :named ax0 
 ) 
 )
(assert 
 (! 
  ; axiom for i2a and a2i
(forall ((i Int)) (=> (in_1 (i2a i) N_Int) (= (a2i (i2a i)) i))) 
 :named ax1 
 ) 
 )
(assert 
 (! 
  ; axiom for ord
(forall ((R Rel1)(a Atom)(b Atom)) (=> (and 
    (finite R)
    (in_1 a R)
    (in_1 b R)
    (= (ord R a) (ord R b))
  ) (= a b))) 
 :named ax2 
 ) 
 )
(assert 
 (! 
  ; axiom for at (the reverse of ord)
(forall ((R Rel1)(a Atom)) (=> (in_1 a R) (= (at R (ord R a)) a))) 
 :named ax3 
 ) 
 )
(assert 
 (! 
  ; axiom for empty set
(forall ((a Atom)) ) 
 :named ax4 
 ) 
 )
(assert 
 (! 
  ; axiom for nextState
(forall ((a Atom)(b Atom)) (=> (and (in_1 a State) (in_1 b State)) (= (in_2 a b nextState) (= (ord State b) (+ (ord State a) 1))))) 
 :named ax5 
 ) 
 )
(assert 
 (! 
  ; 'there is no empty ordered relation' axiom for nextState
(not (= none State)) 
 :named ax6 
 ) 
 )
(assert 
 (! 
  (forall ((x0 Atom)) (and (in_1 x0 (a2r_1 x0)) (forall ((y0 Atom)) (=> (in_1 y0 (a2r_1 x0)) (= x0 y0))))) 
 :named ax7 
 ) 
 )
(assert 
 (! 
  ; axiom for firstState
(= firstState (a2r_1 (at State 1))) 
 :named ax8 
 ) 
 )
(assert 
 (! 
  ; axiom about finite Relations having a card > ord > 1
(forall ((a0 Atom)(R Rel1)) (=> (and (finite R) (in_1 a0 R)) (and (>= (card_1 R) (ord R a0)) (>= (ord R a0) 1)))) 
 :named ax9 
 ) 
 )
(assert 
 (! 
  ; axiom about finite Relations having atoms for certain numbers in ord
(forall ((a0 Atom)(R Rel1)(i Int)) (=> (and (finite R) (and (>= (card_1 R) (ord R a0)) (>= (ord R a0) 1))) (exists ((i Int)) (and (in_1 a0 R) (= (ord R a0) i))))) 
 :named ax10 
 ) 
 )
(assert 
 (! 
  ; finite axiom for lastState
(=> (finite State) (= lastState (a2r_1 (at State (card_1 State))))) 
 :named ax11 
 ) 
 )
(assert 
 (! 
  ; axiom for nextMutex
(forall ((a Atom)(b Atom)) (=> (and (in_1 a Mutex) (in_1 b Mutex)) (= (in_2 a b nextMutex) (= (ord Mutex b) (+ (ord Mutex a) 1))))) 
 :named ax12 
 ) 
 )
(assert 
 (! 
  ; 'there is no empty ordered relation' axiom for nextMutex
(not (= none Mutex)) 
 :named ax13 
 ) 
 )
(assert 
 (! 
  ; axiom for firstMutex
(= firstMutex (a2r_1 (at Mutex 1))) 
 :named ax14 
 ) 
 )
(assert 
 (! 
  ; infinite axiom for lastMutex
(=>  (= lastMutex none_1)) 
 :named ax15 
 ) 
 )
(assert 
 (! 
  (forall ((A Rel1)(B Rel1)(x0 Atom)(y0 Atom)) (= (in_2 x0 y0 (prod_1x1 A B)) (and (in_1 x0 A) (in_1 y0 B)))) 
 :named ax16 
 ) 
 )
(assert 
 (! 
  (forall ((A Rel2)(B Rel1)(x0 Atom)(x1 Atom)(y0 Atom)) (= (in_3 x0 x1 y0 (prod_2x1 A B)) (and (in_2 x0 x1 A) (in_1 y0 B)))) 
 :named ax17 
 ) 
 )
(assert 
 (! 
  (forall ((x Rel3)(y Rel3)) (= (subset_3 x y) (forall ((a0 Atom)(a1 Atom)(a2 Atom)) (=> (in_3 a0 a1 a2 x) (in_3 a0 a1 a2 y))))) 
 :named ax18 
 ) 
 )
(assert 
 (! 
  (forall ((x Rel2)(y Rel2)) (= (subset_2 x y) (forall ((a0 Atom)(a1 Atom)) (=> (in_2 a0 a1 x) (in_2 a0 a1 y))))) 
 :named ax19 
 ) 
 )
(assert 
 (! 
  ; axiom for join_1x3
(forall ((A Rel1)(B Rel3)(y0 Atom)(y1 Atom)) (= (in_2 y0 y1 (join_1x3 A B)) (exists ((x Atom)) (and (in_1 x A) (in_3 x y0 y1 B))))) 
 :named ax20 
 ) 
 )
(assert 
 (! 
  (forall ((A Rel1)(B Rel1)) (= (disjoint_1 A B) (forall ((a0 Atom)) (=> (in_1 a0 A) )))) 
 :named ax21 
 ) 
 )
(assert 
 (! 
  (forall ((A Rel1)(B Rel1)) (= (disjoint_1 A B) (forall ((a0 Atom)) (=> (in_1 a0 A) )))) 
 :named ax22 
 ) 
 )
(assert 
 (! 
  (forall ((A Rel1)(B Rel1)) (= (disjoint_1 A B) (forall ((a0 Atom)) (=> (in_1 a0 A) )))) 
 :named ax23 
 ) 
 )
(assert 
 (! 
  (forall ((x0 Atom)(x1 Atom)(A Rel2)(B Rel2)) (= (in_2 x0 x1 (union_2 A B)) (or (in_2 x0 x1 A) (in_2 x0 x1 B)))) 
 :named ax24 
 ) 
 )
(assert 
 (! 
  ; axiom for 'the expression is empty'
(forall ((a0 Atom)(a1 Atom)(R Rel2)) ) 
 :named ax25 
 ) 
 )
(assert 
 (! 
  (forall ((a0 Atom)(a1 Atom)(R Rel2)) (= (in_2 a0 a1 (transp R)) (in_2 a1 a0 R))) 
 :named ax26 
 ) 
 )
(assert 
 (! 
  ; axiom for join_1x2
(forall ((A Rel1)(B Rel2)(y0 Atom)) (= (in_1 y0 (join_1x2 A B)) (exists ((x Atom)) (and (in_1 x A) (in_2 x y0 B))))) 
 :named ax27 
 ) 
 )
(assert 
 (! 
  ; axiom for 'the expression is empty'
(forall ((a0 Atom)(R Rel1)) ) 
 :named ax28 
 ) 
 )
(assert 
 (! 
  (forall ((A Rel1)) (= (some_1 A) (exists ((a0 Atom)) (in_1 a0 A)))) 
 :named ax29 
 ) 
 )
(assert 
 (! 
  (forall ((x Rel1)(y Rel1)) (= (subset_1 x y) (forall ((a0 Atom)) (=> (in_1 a0 x) (in_1 a0 y))))) 
 :named ax30 
 ) 
 )
(assert 
 (! 
  (forall ((x0 Atom)(A Rel1)(B Rel1)) (= (in_1 x0 (union_1 A B)) (or (in_1 x0 A) (in_1 x0 B)))) 
 :named ax31 
 ) 
 )
(assert 
 (! 
  (forall ((A Rel1)(B Rel1)(a0 Atom)) (= (in_1 a0 (diff_1 A B)) (and (in_1 a0 A) ))) 
 :named ax32 
 ) 
 )
(assert 
 (! 
  (forall ((X Rel1)) (= (one_1 X) (and (exists ((a0 Atom)) (in_1 a0 X)) (forall ((a0 Atom)(b0 Atom)) (=> (and (in_1 a0 X) (in_1 b0 X)) (= a0 b0)))))) 
 :named ax33 
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
  (disjoint_1 State Mutex) 
 :named a2 
 ) 
 )
(assert 
 (! 
  (disjoint_1 State Process) 
 :named a3 
 ) 
 )
(assert 
 (! 
  (disjoint_1 Mutex Process) 
 :named a4 
 ) 
 )
(assert 
 (! 
  (forall ((s Rel1)) (= (Initial s) (no_2 (union_2 (join_1x3 s holds) (join_1x3 s waits))))) 
 :named a5 
 ) 
 )
(assert 
 (! 
  (forall ((s Rel1)(m Rel1)) (= (IsFree s m) (no_1 (join_1x2 m (transp (join_1x3 s holds)))))) 
 :named a6 
 ) 
 )
(assert 
 (! 
  (forall ((s Rel1)(p Rel1)) (= (IsStalled s p) (some_1 (join_1x2 p (join_1x3 s waits))))) 
 :named a7 
 ) 
 )
(assert 
 (! 
  (forall ((s Rel1)(p Rel1)(m Rel1)(s_ Rel1)) (= (GrabMutex s p m s_) (and 
    (ite (IsFree s m) (and (= (join_1x2 p (join_1x3 s_ holds)) (union_1 (join_1x2 p (join_1x3 s holds)) m)) (no_1 (join_1x2 p (join_1x3 s_ waits)))) (and (= (join_1x2 p (join_1x3 s_ holds)) (join_1x2 p (join_1x3 s holds))) (= (join_1x2 p (join_1x3 s_ waits)) m)))
    (forall ((otherProc Atom)) (=> (and (in_1 otherProc Process) (in_1 otherProc (diff_1 Process p))) (and (= (join_1x2 (a2r_1 otherProc) (join_1x3 s_ holds)) (join_1x2 (a2r_1 otherProc) (join_1x3 s holds))) (= (join_1x2 (a2r_1 otherProc) (join_1x3 s_ waits)) (join_1x2 (a2r_1 otherProc) (join_1x3 s waits))))))
  ))) 
 :named a8 
 ) 
 )
(assert 
 (! 
  (forall ((s Rel1)(p Rel1)(m Rel1)(s_ Rel1)) (= (ReleaseMutex s p m s_) (and 
    (subset_1 m (join_1x2 p (join_1x3 s holds)))
    (= (join_1x2 p (join_1x3 s_ holds)) (diff_1 (join_1x2 p (join_1x3 s holds)) m))
    (no_1 (join_1x2 p (join_1x3 s_ waits)))
    (ite (no_1 (join_1x2 m (transp (join_1x3 s waits)))) (and (no_1 (join_1x2 m (transp (join_1x3 s_ holds)))) (no_1 (join_1x2 m (transp (join_1x3 s_ waits))))) (exists ((lucky Atom)) (and 
    (in_1 lucky Process)
    (in_1 lucky (join_1x2 m (transp (join_1x3 s waits))))
    (and (= (join_1x2 m (transp (join_1x3 s_ waits))) (diff_1 (join_1x2 m (transp (join_1x3 s waits))) (a2r_1 lucky))) (= (join_1x2 m (transp (join_1x3 s_ holds))) (a2r_1 lucky)))
  )))
    (forall ((mu Atom)) (=> (and (in_1 mu Mutex) (in_1 mu (diff_1 Mutex m))) (and (= (join_1x2 (a2r_1 mu) (transp (join_1x3 s_ waits))) (join_1x2 (a2r_1 mu) (transp (join_1x3 s waits)))) (= (join_1x2 (a2r_1 mu) (transp (join_1x3 s_ holds))) (join_1x2 (a2r_1 mu) (transp (join_1x3 s holds)))))))
  ))) 
 :named a9 
 ) 
 )
(assert 
 (! 
  (forall () (= GrabOrRelease (and (Initial firstState) (forall ((pre Atom)) (=> (and (in_1 pre State) (in_1 pre (diff_1 State lastState))) (or 
    (and (= (join_1x3 (join_1x2 (a2r_1 pre) nextState) holds) (join_1x3 (a2r_1 pre) holds)) (= (join_1x3 (join_1x2 (a2r_1 pre) nextState) waits) (join_1x3 (a2r_1 pre) waits)))
    (exists ((p Atom)(m Atom)) (and 
    (in_1 p Process)
    (in_1 m Mutex)
    (GrabMutex (a2r_1 pre) (a2r_1 p) (a2r_1 m) (join_1x2 (a2r_1 pre) nextState))
  ))
    (exists ((p Atom)(m Atom)) (and 
    (in_1 p Process)
    (in_1 m Mutex)
    (ReleaseMutex (a2r_1 pre) (a2r_1 p) (a2r_1 m) (join_1x2 (a2r_1 pre) nextState))
  ))
   )))))) 
 :named a10 
 ) 
 )
(assert 
 (! 
  (forall () (= Deadlock (and (some_1 Process) (exists ((s Atom)) (and (in_1 s State) (forall ((p Atom)) (=> (in_1 p Process) (some_1 (join_1x2 (a2r_1 p) (join_1x3 (a2r_1 s) waits)))))))))) 
 :named a11 
 ) 
 )
(assert 
 (! 
  (forall () (= GrabbedInOrder (forall ((pre Atom)) (=> (and (in_1 pre State) (in_1 pre (diff_1 State lastState))) (=> (some_1 (diff_1 (join_1x2 Process (join_1x3 (join_1x2 (a2r_1 pre) nextState) holds)) (join_1x2 Process (join_1x3 (a2r_1 pre) holds)))) (subset_1 (diff_1 (join_1x2 Process (join_1x3 (join_1x2 (a2r_1 pre) nextState) holds)) (join_1x2 Process (join_1x3 (a2r_1 pre) holds))) (nextsMutex (join_1x2 Process (join_1x3 (a2r_1 pre) holds))))))))) 
 :named a12 
 ) 
 )
(assert 
 (! 
  (forall () (= ShowDijkstra (and 
    GrabOrRelease
    Deadlock
    (some_3 waits)
  ))) 
 :named a13 
 ) 
 )
;; --end assertions

;; command
(assert 
 (! 
   
 :named c0 
 ) 
 )
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
(assert
 (! 
  ; 1. lemma for join_1x2. direction: join to in
(forall ((a1 Atom)(a0 Atom)(r Rel2)) (=> (in_1 a0 (join_1x2 ; (swapped)
(a2r_1 a1) r)) (in_2 a1 a0 r))) 
 :named l2 
 ) 
 )
(assert
 (! 
  ; 2. lemma for join_1x2. direction: in to join
(forall ((a1 Atom)(a0 Atom)(r Rel2)) (=> (in_2 a1 a0 r) (in_1 a0 (join_1x2 ; (swapped)
(a2r_1 a1) r)))) 
 :named l3 
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
