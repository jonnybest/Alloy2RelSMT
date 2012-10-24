(set-option :macro-finder true)
(set-option :ematching false)
;; sorts
(declare-sort Atom)
(declare-sort Rel1)
(declare-sort Rel2)
(declare-sort Rel3)
(declare-sort Rel4)
(declare-sort Rel5)
;; --end sorts

;; functions
(declare-const fn Rel3)
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
(declare-fun join_1x2 (Rel1 Rel2) Rel1)
(declare-fun disjoint_1 (Rel1 Rel1) Bool)
(declare-fun in_4 (Atom Atom Atom Atom Rel4) Bool)
(declare-fun prod_3x1 (Rel3 Rel1) Rel4)
(declare-fun in_5 (Atom Atom Atom Atom Atom Rel5) Bool)
(declare-fun prod_1x4 (Rel1 Rel4) Rel5)
(declare-fun no_5 (Rel5) Bool)
(declare-fun some_1 (Rel1) Bool)
(declare-const A Rel1)
(declare-const B Rel1)
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
  ; subset axiom for Rel3
(forall ((x Rel3)(y Rel3)) (= (subset_3 x y) (forall ((a0 Atom)(a1 Atom)(a2 Atom)) (=> (in_3 a0 a1 a2 x) (in_3 a0 a1 a2 y))))) 
 :named ax2 
 ) 
 )
(assert 
 (! 
  ; subset axiom for Rel2
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
  ; axiom for the conversion function Atom -> Relation
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
  ; axiom for join_1x2
(forall ((A Rel1)(B Rel2)(y0 Atom)) (= (in_1 y0 (join_1x2 A B)) (exists ((x Atom)) (and (in_1 x A) (in_2 x y0 B))))) 
 :named ax7 
 ) 
 )
(assert 
 (! 
  ; (forall ((A Rel1)(B Rel1)) (= (disjoint_1 A B) (forall ((a0 Atom)) (=> (in_1 a0 A) (not (in_1 a0 B)))))); alternative
(forall ((A Rel1)(B Rel1)) (= (disjoint_1 A B) (forall ((a0 Atom)) (not (and (in_1 a0 A) (in_1 a0 B)))))) 
 :named ax8 
 ) 
 )
(assert 
 (! 
  (forall ((A Rel3)(B Rel1)(x0 Atom)(x1 Atom)(x2 Atom)(y0 Atom)) (= (in_4 x0 x1 x2 y0 (prod_3x1 A B)) (and (in_3 x0 x1 x2 A) (in_1 y0 B)))) 
 :named ax9 
 ) 
 )
(assert 
 (! 
  (forall ((A Rel1)(B Rel4)(x0 Atom)(y0 Atom)(y1 Atom)(y2 Atom)(y3 Atom)) (= (in_5 x0 y0 y1 y2 y3 (prod_1x4 A B)) (and (in_1 x0 A) (in_4 y0 y1 y2 y3 B)))) 
 :named ax10 
 ) 
 )
(assert 
 (! 
  ; axiom for 'the expression is empty'
(forall ((a0 Atom)(a1 Atom)(a2 Atom)(a3 Atom)(a4 Atom)(R Rel5)) (=> (no_5 R) (not (in_5 a0 a1 a2 a3 a4 R)))) 
 :named ax11 
 ) 
 )
(assert 
 (! 
  (forall ((A Rel1)) (= (some_1 A) (exists ((a0 Atom)) (in_1 a0 A)))) 
 :named ax12 
 ) 
 )
;; --end axioms

;; assertions
(assert 
 (! 
  (subset_3 fn (prod_2x1 (prod_1x1 B A) B)) 
 :named a0 
 ) 
 )
(assert 
 (! 
  (forall ((this Atom)) (=> (in_1 this B) (forall ((x0 Atom)) (=> (in_1 x0 A) (lone_1 (join_1x2 (a2r_1 x0) (join_1x3 (a2r_1 this) fn))))))) 
 :named a1 
 ) 
 )
(assert 
 (! 
  (disjoint_1 B A) 
 :named a2 
 ) 
 )
(assert 
 (! 
  (no_5 (prod_1x4 A (prod_3x1 fn A))) 
 :named a3 
 ) 
 )
;; --end assertions

;; command
(assert 
 (! 
  (not (some_1 B)) 
 :named c0 
 ) 
 )
;; --end command


;; -- END key stuff --
(check-sat)
(get-model)