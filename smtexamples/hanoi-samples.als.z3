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
(declare-fun on () Rel3)
(declare-fun in_1 (Atom Rel1) Bool)
(declare-fun in_2 (Atom Atom Rel2) Bool)
(declare-fun prod_1x1 (Rel1 Rel1) Rel2)
(declare-fun in_3 (Atom Atom Atom Rel3) Bool)
(declare-fun prod_2x1 (Rel2 Rel1) Rel3)
(declare-fun subset_3 (Rel3 Rel3) Bool)
(declare-fun subset_2 (Rel2 Rel2) Bool)
(declare-fun join_1x3 (Rel1 Rel3) Rel2)
(declare-fun a2r_1 (Atom) Rel1)
(declare-fun one_1 (Rel1) Bool)
(declare-fun disjoint_1 (Rel1 Rel1) Bool)
(declare-fun discsOnStake (Rel1 Rel1) Rel1)
(declare-fun transp (Rel2) Rel2)
(declare-fun join_1x2 (Rel1 Rel2) Rel1)
(declare-fun topDisc (Rel1 Rel1) Rel1)
(declare-fun union_1 (Rel1 Rel1) Rel1)
(declare-fun subset_1 (Rel1 Rel1) Bool)
(declare-fun Move (Rel1 Rel1 Rel1 Rel1) Bool)
(declare-fun diff_1 (Rel1 Rel1) Rel1)
(declare-fun Game1 () Bool)
(declare-fun some_1 (Rel1) Bool)
(declare-fun State () Rel1)
(declare-fun Stake () Rel1)
(declare-fun Disc () Rel1)
(declare-fun states () Rel1)
(declare-fun stakes () Rel1)
(declare-fun discs () Rel1)
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
  (forall ((X Rel1)) (= (one_1 X) (and (exists ((a0 Atom)) (in_1 a0 X)) (forall ((a0 Atom)(b0 Atom)) (=> (and (in_1 a0 X) (in_1 b0 X)) (= a0 b0)))))) 
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
(assert 
 (! 
  (forall ((a0 Atom)(a1 Atom)(R Rel2)) (= (in_2 a0 a1 (transp R)) (in_2 a1 a0 R))) 
 :named ax10 
 ) 
 )
(assert 
 (! 
  ; axiom for join_1x2
(forall ((A Rel1)(B Rel2)(y0 Atom)) (= (in_1 y0 (join_1x2 A B)) (exists ((x Atom)) (and (in_1 x A) (in_2 x y0 B))))) 
 :named ax11 
 ) 
 )
(assert 
 (! 
  (forall ((x0 Atom)(A Rel1)(B Rel1)) (= (in_1 x0 (union_1 A B)) (or (in_1 x0 A) (in_1 x0 B)))) 
 :named ax12 
 ) 
 )
(assert 
 (! 
  (forall ((x Rel1)(y Rel1)) (= (subset_1 x y) (forall ((a0 Atom)) (=> (in_1 a0 x) (in_1 a0 y))))) 
 :named ax13 
 ) 
 )
(assert 
 (! 
  (forall ((A Rel1)(B Rel1)(a0 Atom)) (= (in_1 a0 (diff_1 A B)) (and (in_1 a0 A) (not (in_1 a0 B))))) 
 :named ax14 
 ) 
 )
(assert 
 (! 
  (forall ((A Rel1)) (= (some_1 A) (exists ((a0 Atom)) (in_1 a0 A)))) 
 :named ax15 
 ) 
 )
;; --end axioms

;; assertions
(assert 
 (! 
  ; Alias constraint for State and states
(= State states) 
 :named a0 
 ) 
 )
(assert 
 (! 
  ; Alias constraint for Stake and stakes
(= Stake stakes) 
 :named a1 
 ) 
 )
(assert 
 (! 
  ; Alias constraint for Disc and discs
(= Disc discs) 
 :named a2 
 ) 
 )
(assert 
 (! 
  (subset_3 on (prod_2x1 (prod_1x1 State Disc) Stake)) 
 :named a3 
 ) 
 )
(assert 
 (! 
  (forall ((this Atom)) (=> (in_1 this State) (forall ((x0 Atom)) (=> (in_1 x0 Disc) (one_1 (join_1x2 (a2r_1 x0) (join_1x3 (a2r_1 this) on))))))) 
 :named a4 
 ) 
 )
(assert 
 (! 
  (disjoint_1 State Stake) 
 :named a5 
 ) 
 )
(assert 
 (! 
  (disjoint_1 State Disc) 
 :named a6 
 ) 
 )
(assert 
 (! 
  (disjoint_1 Stake Disc) 
 :named a7 
 ) 
 )
(assert 
 (! 
  (forall ((st Rel1)(stake Rel1)) (= (discsOnStake st stake) (join_1x2 stake (transp (join_1x3 st on))))) 
 :named a8 
 ) 
 )
(assert 
 (! 
  (forall ((st Rel1)(stake Rel1)) (= (topDisc st stake) compr1{Atom d;}(((and 
    (in_1 d Disc)
    (in_1 d (discsOnStake st stake))
    (subset_1 (discsOnStake st stake) (union_1 (nextsDisc (a2r_1 d)) (a2r_1 d)))
  ))))) 
 :named a9 
 ) 
 )
(assert 
 (! 
  (forall ((st1 Rel1)(fromStake Rel1)(toStake Rel1)(s_ Rel1)) (= (Move st1 fromStake toStake s_) (and 
    (subset_1 (discsOnStake st1 toStake) (nextsDisc (topDisc st1 fromStake)))
    (= (discsOnStake s_ fromStake) (diff_1 (discsOnStake st1 fromStake) (topDisc st1 fromStake)))
    (= (discsOnStake s_ toStake) (union_1 (discsOnStake st1 toStake) (topDisc st1 fromStake)))
    (= (discsOnStake s_ (diff_1 (diff_1 Stake fromStake) toStake)) (discsOnStake st1 (diff_1 (diff_1 Stake fromStake) toStake)))
  ))) 
 :named a10 
 ) 
 )
(assert 
 (! 
  (forall () (= Game1 (and 
    (subset_1 Disc (discsOnStake firstState firstStake))
    (exists ((finalState Atom)) (and (in_1 finalState State) (subset_1 Disc (discsOnStake (a2r_1 finalState) lastStake))))
    (forall ((preState Atom)) (=> (and (in_1 preState State) (in_1 preState (diff_1 State lastState))) (exists ((fromStake Atom)) (and (in_1 fromStake Stake) (and (some_1 (discsOnStake (a2r_1 preState) (a2r_1 fromStake))) (exists ((toStake Atom)) (and (in_1 toStake Stake) (Move (a2r_1 preState) (a2r_1 fromStake) (a2r_1 toStake) (join_1x2 (a2r_1 preState) nextState)))))))))
  ))) 
 :named a11 
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
;
;)-> (
;
;;\predicates {

;;}

;; -- END key stuff --
(check-sat)
(get-unsat-core)
