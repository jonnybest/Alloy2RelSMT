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
(declare-fun subset_1 (Rel1 Rel1) Bool)
(declare-fun qi () Rel3)
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
(declare-fun iids () Rel2)
(declare-fun join_1x2 (Rel1 Rel2) Rel1)
(declare-fun iidsKnown () Rel2)
(declare-fun one_1 (Rel1) Bool)
(declare-fun reaches () Rel2)
(declare-fun interfaces () Rel2)
(declare-fun iids1 () Rel2)
(declare-fun first () Rel2)
(declare-fun identity () Rel2)
(declare-fun eqs () Rel2)
(declare-fun aggregates () Rel2)
(declare-fun disjoint_1 (Rel1 Rel1) Bool)
(declare-fun join_2x1 (Rel2 Rel1) Rel1)
(declare-fun a2r_2 (Atom Atom) Rel2)
(declare-fun trans (Rel2) Bool)
(declare-fun transClos (Rel2) Rel2)
(declare-fun inter_1 (Rel1 Rel1) Rel1)
(declare-fun some_1 (Rel1) Bool)
(declare-fun diff_1 (Rel1 Rel1) Rel1)
(declare-fun LegalInterface () Rel1)
(declare-fun Interface () Rel1)
(declare-fun IID () Rel1)
(declare-fun LegalComponent () Rel1)
(declare-fun Component () Rel1)
;; --end functions

;; axioms
(assert 
 (! 
  (forall ((x Rel1)(y Rel1)) (= (subset_1 x y) (forall ((a0 Atom)) (=> (in_1 a0 x) (in_1 a0 y))))) 
 :named ax0 
 ) 
 )
(assert 
 (! 
  (forall ((A Rel1)(B Rel1)(x0 Atom)(y0 Atom)) (= (in_2 x0 y0 (prod_1x1 A B)) (and (in_1 x0 A) (in_1 y0 B)))) 
 :named ax1 
 ) 
 )
(assert 
 (! 
  (forall ((A Rel2)(B Rel1)(x0 Atom)(x1 Atom)(y0 Atom)) (= (in_3 x0 x1 y0 (prod_2x1 A B)) (and (in_2 x0 x1 A) (in_1 y0 B)))) 
 :named ax2 
 ) 
 )
(assert 
 (! 
  (forall ((x Rel3)(y Rel3)) (= (subset_3 x y) (forall ((a0 Atom)(a1 Atom)(a2 Atom)) (=> (in_3 a0 a1 a2 x) (in_3 a0 a1 a2 y))))) 
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
  ; axiom for join_1x3
(forall ((A Rel1)(B Rel3)(y0 Atom)(y1 Atom)) (= (in_2 y0 y1 (join_1x3 A B)) (exists ((x Atom)) (and (in_1 x A) (in_3 x y0 y1 B))))) 
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
  (forall ((X Rel1)) (= (lone_1 X) (forall ((a0 Atom)(b0 Atom)) (=> (and (in_1 a0 X) (in_1 b0 X)) (= a0 b0))))) 
 :named ax7 
 ) 
 )
(assert 
 (! 
  ; axiom for join_1x2
(forall ((A Rel1)(B Rel2)(y0 Atom)) (= (in_1 y0 (join_1x2 A B)) (exists ((x Atom)) (and (in_1 x A) (in_2 x y0 B))))) 
 :named ax8 
 ) 
 )
(assert 
 (! 
  (forall ((X Rel1)) (= (one_1 X) (and (exists ((a0 Atom)) (in_1 a0 X)) (forall ((a0 Atom)(b0 Atom)) (=> (and (in_1 a0 X) (in_1 b0 X)) (= a0 b0)))))) 
 :named ax9 
 ) 
 )
(assert 
 (! 
  (forall ((A Rel1)(B Rel1)) (= (disjoint_1 A B) (forall ((a0 Atom)) (=> (in_1 a0 A) (not (in_1 a0 B)))))) 
 :named ax10 
 ) 
 )
(assert 
 (! 
  (forall ((A Rel1)(B Rel1)) (= (disjoint_1 A B) (forall ((a0 Atom)) (=> (in_1 a0 A) (not (in_1 a0 B)))))) 
 :named ax11 
 ) 
 )
(assert 
 (! 
  (forall ((A Rel1)(B Rel1)) (= (disjoint_1 A B) (forall ((a0 Atom)) (=> (in_1 a0 A) (not (in_1 a0 B)))))) 
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
  (forall ((x0 Atom)(x1 Atom)) (and (in_2 x0 x1 (a2r_2 x0 x1)) (forall ((y0 Atom)(y1 Atom)) (=> (in_2 y0 y1 (a2r_2 x0 x1)) (and (= x0 y0) (= x1 y1)))))) 
 :named ax14 
 ) 
 )
(assert 
 (! 
  (forall ((r Rel2)) (= (trans r) (forall ((a1 Atom)(a2 Atom)(a3 Atom)) (=> (and (in_2 a1 a2 r) (in_2 a2 a3 r)) (in_2 a1 a3 r))))) 
 :named ax15 
 ) 
 )
(assert 
 (! 
  (forall ((r Rel2)) (subset_2 r (transClos r))) 
 :named ax16 
 ) 
 )
(assert 
 (! 
  (forall ((r Rel2)) (trans (transClos r))) 
 :named ax17 
 ) 
 )
(assert 
 (! 
  (forall ((r1 Rel2)(r2 Rel2)) (=> (and (subset_2 r1 r2) (trans r2)) (subset_2 (transClos r1) r2))) 
 :named ax18 
 ) 
 )
(assert 
 (! 
  (forall ((A Rel1)) (= (some_1 A) (exists ((a0 Atom)) (in_1 a0 A)))) 
 :named ax19 
 ) 
 )
(assert 
 (! 
  (forall ((A Rel1)(B Rel1)(a0 Atom)) (= (in_1 a0 (diff_1 A B)) (and (in_1 a0 A) (not (in_1 a0 B))))) 
 :named ax20 
 ) 
 )
;; --end axioms

;; assertions
(assert 
 (! 
  (subset_1 LegalInterface Interface) 
 :named a0 
 ) 
 )
(assert 
 (! 
  (subset_3 qi (prod_2x1 (prod_1x1 Interface IID) Interface)) 
 :named a1 
 ) 
 )
(assert 
 (! 
  (forall ((this Atom)) (=> (in_1 this Interface) (forall ((x0 Atom)) (=> (in_1 x0 IID) (lone_1 (join_1x2 (a2r_1 x0) (join_1x3 (a2r_1 this) qi))))))) 
 :named a2 
 ) 
 )
(assert 
 (! 
  (subset_2 iids (prod_1x1 Interface IID)) 
 :named a3 
 ) 
 )
(assert 
 (! 
  (subset_2 iidsKnown (prod_1x1 Interface IID)) 
 :named a4 
 ) 
 )
(assert 
 (! 
  (forall ((this Atom)) (=> (in_1 this Interface) (one_1 (join_1x2 (a2r_1 this) iidsKnown)))) 
 :named a5 
 ) 
 )
(assert 
 (! 
  (subset_2 reaches (prod_1x1 Interface Interface)) 
 :named a6 
 ) 
 )
(assert 
 (! 
  (forall ((this Atom)) (=> (in_1 this Interface) (one_1 (join_1x2 (a2r_1 this) reaches)))) 
 :named a7 
 ) 
 )
(assert 
 (! 
  (subset_1 LegalComponent Component) 
 :named a8 
 ) 
 )
(assert 
 (! 
  (subset_2 interfaces (prod_1x1 Component Interface)) 
 :named a9 
 ) 
 )
(assert 
 (! 
  (subset_2 iids1 (prod_1x1 Component IID)) 
 :named a10 
 ) 
 )
(assert 
 (! 
  (subset_2 first (prod_1x1 Component Interface)) 
 :named a11 
 ) 
 )
(assert 
 (! 
  (subset_2 identity (prod_1x1 Component Interface)) 
 :named a12 
 ) 
 )
(assert 
 (! 
  (forall ((this Atom)) (=> (in_1 this Component) (and (one_1 (join_1x2 (a2r_1 this) identity)) (and (one_1 (join_1x2 (a2r_1 this) first)) (and (subset_1 (join_1x2 (a2r_1 this) first) (join_1x2 (a2r_1 this) interfaces)) (subset_1 (join_1x2 (a2r_1 this) identity) (join_1x2 (a2r_1 this) interfaces))))))) 
 :named a13 
 ) 
 )
(assert 
 (! 
  (subset_2 eqs (prod_1x1 Component Component)) 
 :named a14 
 ) 
 )
(assert 
 (! 
  (subset_2 aggregates (prod_1x1 Component Component)) 
 :named a15 
 ) 
 )
(assert 
 (! 
  (disjoint_1 Interface IID) 
 :named a16 
 ) 
 )
(assert 
 (! 
  (disjoint_1 Interface Component) 
 :named a17 
 ) 
 )
(assert 
 (! 
  (disjoint_1 IID Component) 
 :named a18 
 ) 
 )
(assert 
 (! 
  (forall ((i Atom)) (=> (in_1 i Interface) (and (= (join_1x2 (a2r_1 i) iidsKnown) (join_2x1 (join_1x3 (a2r_1 i) qi) Interface)) (= (join_1x2 (a2r_1 i) reaches) (join_1x2 IID (join_1x3 (a2r_1 i) qi)))))) 
 :named a19 
 ) 
 )
(assert 
 (! 
  (forall ((c1 Atom)(c2 Atom)) (=> (and (in_1 c1 Component) (in_1 c2 Component)) (= (subset_2 (prod_1x1 (a2r_1 c1) (a2r_1 c2)) eqs) (= (join_1x2 (a2r_1 c1) identity) (join_1x2 (a2r_1 c2) identity))))) 
 :named a20 
 ) 
 )
(assert 
 (! 
  (exists ((unknown Atom)) (and (in_1 unknown IID) (forall ((c Atom)) (=> (in_1 c Component) (forall ((i Atom)) (=> (and (in_1 i Interface) (in_1 i (join_1x2 (a2r_1 c) interfaces))) (= (join_1x2 (a2r_1 unknown) (join_1x3 (a2r_1 i) qi)) (join_1x2 (a2r_1 c) identity)))))))) 
 :named a21 
 ) 
 )
(assert 
 (! 
  (forall ((c Atom)) (=> (in_1 c Component) (and (= (join_1x2 (a2r_1 c) iids1) (join_1x2 (join_1x2 (a2r_1 c) interfaces) iids)) (forall ((i Atom)) (=> (and (in_1 i Interface) (in_1 i (join_1x2 (a2r_1 c) interfaces))) (forall ((x Atom)) (=> (in_1 x IID) (subset_1 (join_1x2 (a2r_1 x) (join_1x3 (a2r_1 i) qi)) (join_1x2 (a2r_1 c) interfaces))))))))) 
 :named a22 
 ) 
 )
(assert 
 (! 
  (forall ((i Atom)) (=> (in_1 i LegalInterface) (forall ((x Atom)) (=> (and (in_1 x IID) (in_1 x (join_1x2 (a2r_1 i) iidsKnown))) (in_1 x (join_1x2 (join_1x2 (a2r_1 x) (join_1x3 (a2r_1 i) qi)) iids)))))) 
 :named a23 
 ) 
 )
(assert 
 (! 
  (subset_1 (join_1x2 LegalComponent interfaces) LegalInterface) 
 :named a24 
 ) 
 )
(assert 
 (! 
  (forall ((i Atom)) (=> (in_1 i LegalInterface) (subset_1 (join_1x2 (a2r_1 i) iids) (join_1x2 (a2r_1 i) iidsKnown)))) 
 :named a25 
 ) 
 )
(assert 
 (! 
  (forall ((i Atom)(j Atom)) (=> (and (in_1 i LegalInterface) (in_1 j LegalInterface)) (=> (in_1 j (join_1x2 (a2r_1 i) reaches)) (subset_1 (join_1x2 (a2r_1 i) iids) (join_1x2 (a2r_1 j) iidsKnown))))) 
 :named a26 
 ) 
 )
(assert 
 (! 
  (forall ((i Atom)(j Atom)) (=> (and (in_1 i LegalInterface) (in_1 j LegalInterface)) (=> (in_1 j (join_1x2 (a2r_1 i) reaches)) (subset_1 (join_1x2 (a2r_1 j) iidsKnown) (join_1x2 (a2r_1 i) iidsKnown))))) 
 :named a27 
 ) 
 )
(assert 
 (! 
  (and (not (exists ((c Atom)) (and (in_1 c Component) (in_1 c (join_1x2 (a2r_1 c) (transClos aggregates)))))) (forall ((outer Atom)) (=> (in_1 outer Component) (forall ((inner Atom)) (=> (and (in_1 inner Component) (in_1 inner (join_1x2 (a2r_1 outer) aggregates))) (and (some_1 (inter_1 (join_1x2 (a2r_1 inner) interfaces) (join_1x2 (a2r_1 outer) interfaces))) (exists ((o Atom)) (and 
    (in_1 o Interface)
    (in_1 o (join_1x2 (a2r_1 outer) interfaces))
    (forall ((i Atom)) (=> (and (in_1 i Interface) (in_1 i (diff_1 (join_1x2 (a2r_1 inner) interfaces) (join_1x2 (a2r_1 inner) first)))) (forall ((x Atom)) (=> (in_1 x Component) (= (join_1x2 (join_1x2 (a2r_1 x) iids1) (join_1x3 (a2r_1 i) qi)) (join_1x2 (join_1x2 (a2r_1 x) iids1) (join_1x3 (a2r_1 o) qi)))))))
  )))))))) 
 :named a28 
 ) 
 )
;; --end assertions

;; command
(assert 
 (! 
  (not (forall ((c Atom)) (=> (in_1 c LegalComponent) (forall ((i Atom)) (=> (and (in_1 i Interface) (in_1 i (join_1x2 (a2r_1 c) interfaces))) (= (join_1x2 (a2r_1 i) iidsKnown) (join_1x2 (a2r_1 c) iids1))))))) 
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
(assert
 (! 
  (forall ((a1 Atom)(a2 Atom)(r Rel2)) (=> (in_2 a1 a2 (transClos r)) (exists ((a3 Atom)) (and (in_2 a1 a3 r) (in_2 a3 a2 (transClos r)))))) 
 :named l6 
 ) 
 )
(assert
 (! 
  (forall ((a1 Atom)(a2 Atom)(r Rel2)) (=> (in_2 a1 a2 (transClos r)) (exists ((a3 Atom)) (and (in_2 a1 a3 (transClos r)) (in_2 a3 a2 r))))) 
 :named l7 
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
