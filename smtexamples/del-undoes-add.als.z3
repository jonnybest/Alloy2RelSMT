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
(declare-fun addr () Rel3)
(declare-fun in_1 (Atom Rel1) Bool)
(declare-fun in_2 (Atom Atom Rel2) Bool)
(declare-fun prod_1x1 (Rel1 Rel1) Rel2)
(declare-fun in_3 (Atom Atom Atom Rel3) Bool)
(declare-fun prod_2x1 (Rel2 Rel1) Rel3)
(declare-fun subset_3 (Rel3 Rel3) Bool)
(declare-fun subset_2 (Rel2 Rel2) Bool)
(declare-fun join_1x3 (Rel1 Rel3) Rel2)
(declare-fun a2r_1 (Atom) Rel1)
(declare-fun lone_1 (Rel1) Bool)
(declare-fun disjoint_1 (Rel1 Rel1) Bool)
(declare-fun add1 (Rel1 Rel1 Rel1 Rel1) Bool)
(declare-fun union_2 (Rel2 Rel2) Rel2)
(declare-fun del (Rel1 Rel1 Rel1) Bool)
(declare-fun diff_2 (Rel2 Rel2) Rel2)
(declare-fun join_1x2 (Rel1 Rel2) Rel1)
(declare-fun some_1 (Rel1) Bool)
(declare-fun one_1 (Rel1) Bool)
(declare-fun Book () Rel1)
(declare-fun Addr () Rel1)
(declare-fun Name () Rel1)
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
  (forall ((X Rel1)) (= (lone_1 X) (forall ((a0 Atom)(b0 Atom)) (=> (and (in_1 a0 X) (in_1 b0 X)) (= a0 b0))))) 
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
  (forall ((x0 Atom)(x1 Atom)(A Rel2)(B Rel2)) (= (in_2 x0 x1 (union_2 A B)) (or (in_2 x0 x1 A) (in_2 x0 x1 B)))) 
 :named ax10 
 ) 
 )
(assert 
 (! 
  (forall ((A Rel2)(B Rel2)(a0 Atom)(a1 Atom)) (= (in_2 a0 a1 (diff_2 A B)) (and (in_2 a0 a1 A) (not (in_2 a0 a1 B))))) 
 :named ax11 
 ) 
 )
(assert 
 (! 
  ; axiom for join_1x2
(forall ((A Rel1)(B Rel2)(y0 Atom)) (= (in_1 y0 (join_1x2 A B)) (exists ((x Atom)) (and (in_1 x A) (in_2 x y0 B))))) 
 :named ax12 
 ) 
 )
(assert 
 (! 
  (forall ((A Rel1)) (= (some_1 A) (exists ((a0 Atom)) (in_1 a0 A)))) 
 :named ax13 
 ) 
 )
(assert 
 (! 
  (forall ((X Rel1)) (= (one_1 X) (and (exists ((a0 Atom)) (in_1 a0 X)) (forall ((a0 Atom)(b0 Atom)) (=> (and (in_1 a0 X) (in_1 b0 X)) (= a0 b0)))))) 
 :named ax14 
 ) 
 )
;; --end axioms

;; assertions
(assert 
 (! 
  (subset_3 addr (prod_2x1 (prod_1x1 Book Name) Addr)) 
 :named a0 
 ) 
 )
(assert 
 (! 
  (forall ((this Atom)) (=> (in_1 this Book) (forall ((x0 Atom)) (=> (in_1 x0 Name) (lone_1 (join_1x2 (a2r_1 x0) (join_1x3 (a2r_1 this) addr))))))) 
 :named a1 
 ) 
 )
(assert 
 (! 
  (disjoint_1 Book Addr) 
 :named a2 
 ) 
 )
(assert 
 (! 
  (disjoint_1 Book Name) 
 :named a3 
 ) 
 )
(assert 
 (! 
  (disjoint_1 Addr Name) 
 :named a4 
 ) 
 )
(assert 
 (! 
  (forall ((b Rel1)(b_ Rel1)(n Rel1)(a Rel1)) (= (add1 b b_ n a) (= (join_1x3 b_ addr) (union_2 (join_1x3 b addr) (prod_1x1 n a))))) 
 :named a5 
 ) 
 )
(assert 
 (! 
  (forall ((b Rel1)(b_ Rel1)(n Rel1)) (= (del b b_ n) (= (join_1x3 b_ addr) (diff_2 (join_1x3 b addr) (prod_1x1 n Addr))))) 
 :named a6 
 ) 
 )
;; --end assertions

;; command
(assert 
 (! 
  (not (forall ((b Atom)(b_ Atom)(b__ Atom)(n Atom)(a Atom)) (=> (and 
    (in_1 b Book)
    (in_1 b_ Book)
    (in_1 b__ Book)
    (in_1 n Name)
    (in_1 a Addr)
  ) (=> (and 
    (not (some_1 (join_1x2 (a2r_1 n) (join_1x3 (a2r_1 b) addr))))
    (add1 (a2r_1 b) (a2r_1 b_) (a2r_1 n) (a2r_1 a))
    (del (a2r_1 b_) (a2r_1 b__) (a2r_1 n))
  ) (= (join_1x3 (a2r_1 b) addr) (join_1x3 (a2r_1 b__) addr)))))) 
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
;
;)-> (
;
;;\predicates {

;;}

;; -- END key stuff --
(check-sat)
(get-model)
