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
(declare-fun disjoint_1 (Rel1 Rel1) Bool)
(declare-fun subset_1 (Rel1 Rel1) Bool)
(declare-fun one_1 (Rel1) Bool)
(declare-fun contents () Rel2)
(declare-fun in_2 (Atom Atom Rel2) Bool)
(declare-fun prod_1x1 (Rel1 Rel1) Rel2)
(declare-fun subset_2 (Rel2 Rel2) Bool)
(declare-fun join_1x2 (Rel1 Rel2) Rel1)
(declare-fun a2r_1 (Atom) Rel1)
(declare-fun trans (Rel2) Bool)
(declare-fun transClos (Rel2) Rel2)
(declare-fun iden () Rel2)
(declare-fun union_2 (Rel2 Rel2) Rel2)
(declare-fun join_2x1 (Rel2 Rel1) Rel1)
(declare-fun some_1 (Rel1) Bool)
(declare-fun diff_1 (Rel1 Rel1) Rel1)
(declare-fun Object () Rel1)
(declare-fun File () Rel1)
(declare-fun Root () Rel1)
(declare-fun Dir () Rel1)
;; --end functions

;; axioms
(assert 
 (! 
  (forall ((A Rel1)(B Rel1)) (= (disjoint_1 A B) (forall ((a0 Atom)) (=> (in_1 a0 A) (not (in_1 a0 B)))))) 
 :named ax0 
 ) 
 )
(assert 
 (! 
  (forall ((x Rel1)(y Rel1)) (= (subset_1 x y) (forall ((a0 Atom)) (=> (in_1 a0 x) (in_1 a0 y))))) 
 :named ax1 
 ) 
 )
(assert 
 (! 
  (forall ((X Rel1)) (= (one_1 X) (and (exists ((a0 Atom)) (in_1 a0 X)) (forall ((a0 Atom)(b0 Atom)) (=> (and (in_1 a0 X) (in_1 b0 X)) (= a0 b0)))))) 
 :named ax2 
 ) 
 )
(assert 
 (! 
  (forall ((A Rel1)(B Rel1)(x0 Atom)(y0 Atom)) (= (in_2 x0 y0 (prod_1x1 A B)) (and (in_1 x0 A) (in_1 y0 B)))) 
 :named ax3 
 ) 
 )
(assert 
 (! 
  (forall ((x Rel2)(y Rel2)) (= (subset_2 x y) (forall ((a0 Atom)(a1 Atom)) (=> (in_2 a0 a1 x) (in_2 a0 a1 y))))) 
 :named ax4 
 ) 
 )
(assert 
 (! 
  ; axiom for join_1x2
(forall ((A Rel1)(B Rel2)(y0 Atom)) (= (in_1 y0 (join_1x2 A B)) (exists ((x Atom)) (and (in_1 x A) (in_2 x y0 B))))) 
 :named ax5 
 ) 
 )
(assert 
 (! 
  (forall ((x0 Atom)) (and (in_1 x0 (a2r_1 x0)) (forall ((y0 Atom)) (=> (in_1 y0 (a2r_1 x0)) (= x0 y0))))) 
 :named ax6 
 ) 
 )
(assert 
 (! 
  (forall ((r Rel2)) (= (trans r) (forall ((a1 Atom)(a2 Atom)(a3 Atom)) (=> (and (in_2 a1 a2 r) (in_2 a2 a3 r)) (in_2 a1 a3 r))))) 
 :named ax7 
 ) 
 )
(assert 
 (! 
  (forall ((r Rel2)) (subset_2 r (transClos r))) 
 :named ax8 
 ) 
 )
(assert 
 (! 
  (forall ((r Rel2)) (trans (transClos r))) 
 :named ax9 
 ) 
 )
(assert 
 (! 
  (forall ((r1 Rel2)(r2 Rel2)) (=> (and (subset_2 r1 r2) (trans r2)) (subset_2 (transClos r1) r2))) 
 :named ax10 
 ) 
 )
(assert 
 (! 
  (forall ((a0 Atom)) (in_2 a0 a0 iden)) 
 :named ax11 
 ) 
 )
(assert 
 (! 
  (forall ((x0 Atom)(x1 Atom)(A Rel2)(B Rel2)) (= (in_2 x0 x1 (union_2 A B)) (or (in_2 x0 x1 A) (in_2 x0 x1 B)))) 
 :named ax12 
 ) 
 )
(assert 
 (! 
  ; axiom for join_2x1
(forall ((A Rel2)(B Rel1)(y0 Atom)) (= (in_1 y0 (join_2x1 A B)) (exists ((x Atom)) (and (in_2 y0 x A) (in_1 x B))))) 
 :named ax13 
 ) 
 )
(assert 
 (! 
  (forall ((A Rel1)) (= (some_1 A) (exists ((a0 Atom)) (in_1 a0 A)))) 
 :named ax14 
 ) 
 )
(assert 
 (! 
  (forall ((A Rel1)(B Rel1)(a0 Atom)) (= (in_1 a0 (diff_1 A B)) (and (in_1 a0 A) (not (in_1 a0 B))))) 
 :named ax15 
 ) 
 )
;; --end axioms

;; assertions
(assert 
 (! 
  (forall ((this Atom)) (=> (in_1 this Object) (or (in_1 this Dir) (in_1 this File)))) 
 :named a0 
 ) 
 )
(assert 
 (! 
  (disjoint_1 Dir File) 
 :named a1 
 ) 
 )
(assert 
 (! 
  (subset_1 File Object) 
 :named a2 
 ) 
 )
(assert 
 (! 
  (subset_1 Root Dir) 
 :named a3 
 ) 
 )
(assert 
 (! 
  (one_1 Root) 
 :named a4 
 ) 
 )
(assert 
 (! 
  (subset_1 Dir Object) 
 :named a5 
 ) 
 )
(assert 
 (! 
  (subset_2 contents (prod_1x1 Dir Object)) 
 :named a6 
 ) 
 )
(assert 
 (! 
  (subset_1 Object (join_1x2 Root (union_2 (transClos contents) iden))) 
 :named a7 
 ) 
 )
;; --end assertions

;; command
(assert 
 (! 
  (not (forall ((o Atom)) (=> (and (in_1 o Object) (in_1 o (diff_1 Object Root))) (some_1 (join_2x1 contents (a2r_1 o)))))) 
 :named c0 
 ) 
 )
(assert 
 (! 
  (not (forall ((f Atom)) (=> (in_1 f File) (some_1 (join_2x1 contents (a2r_1 f)))))) 
 :named c1 
 ) 
 )
;; --end command

;; lemmas
(assert
 (! 
  ; 1. lemma for join_1x2. direction: join to in
(forall ((a1 Atom)(a0 Atom)(r Rel2)) (=> (in_1 a0 (join_1x2 ; (swapped)
(a2r_1 a1) r)) (in_2 a1 a0 r))) 
 :named l0 
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
  (forall ((a1 Atom)(a2 Atom)(r Rel2)) (=> (in_2 a1 a2 (transClos r)) (exists ((a3 Atom)) (and (in_2 a1 a3 r) (in_2 a3 a2 (transClos r)))))) 
 :named l2 
 ) 
 )
(assert
 (! 
  (forall ((a1 Atom)(a2 Atom)(r Rel2)) (=> (in_2 a1 a2 (transClos r)) (exists ((a3 Atom)) (and (in_2 a1 a3 (transClos r)) (in_2 a3 a2 r))))) 
 :named l3 
 ) 
 )
(assert
 (! 
  ; 1. lemma for join_2x1. direction: join to in
(forall ((a0 Atom)(a1 Atom)(r Rel2)) (=> (in_1 a0 (join_2x1 r (a2r_1 a1))) (in_2 a0 a1 r))) 
 :named l4 
 ) 
 )
(assert
 (! 
  ; 2. lemma for join_2x1. direction: in to join
(forall ((a0 Atom)(a1 Atom)(r Rel2)) (=> (in_2 a0 a1 r) (in_1 a0 (join_2x1 r (a2r_1 a1))))) 
 :named l5 
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
