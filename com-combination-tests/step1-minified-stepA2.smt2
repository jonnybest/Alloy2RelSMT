; file: D:\Entwicklung\workspace\alloy2relsmt\com-combination-tests\step1-minified-stepA2.als 
; hash: 562DD3 BEC5BD655E81E52A3B21AA2E5
(set-logic AUFLIA)
(set-option :macro-finder true)
;; sorts
(declare-sort Atom)
(declare-sort Rel1)
(declare-sort Rel2)
(declare-sort Rel3)
;; --end sorts

;; functions
(declare-fun Component () Rel1)
(declare-fun IID () Rel1)
(declare-fun Interface () Rel1)
(declare-fun LegalComponent () Rel1)
(declare-fun LegalInterface () Rel1)
(declare-fun a2r_1 (Atom) Rel1)
(declare-fun a2r_2 (Atom Atom) Rel2)
(declare-fun disjoint_1 (Rel1 Rel1) Bool)
(declare-fun identity () Rel2)
(declare-fun iids () Rel2)
(declare-fun iids1 () Rel2)
(declare-fun iidsKnown () Rel2)
(declare-fun in_1 (Atom Rel1) Bool)
(declare-fun in_2 (Atom Atom Rel2) Bool)
(declare-fun in_3 (Atom Atom Atom Rel3) Bool)
(declare-fun interfaces () Rel2)
(declare-fun join_1x2 (Rel1 Rel2) Rel1)
(declare-fun join_1x3 (Rel1 Rel3) Rel2)
(declare-fun join_2x1 (Rel2 Rel1) Rel1)
(declare-fun join_2x2 (Rel2 Rel2) Rel2)
(declare-fun no_1 (Rel1) Bool)
(declare-fun none () Rel1)
(declare-fun one_1 (Rel1) Bool)
(declare-fun prod_1x1 (Rel1 Rel1) Rel2)
(declare-fun prod_2x1 (Rel2 Rel1) Rel3)
(declare-fun qi () Rel3)
(declare-fun reaches () Rel2)
(declare-fun subset_1 (Rel1 Rel1) Bool)
(declare-fun subset_2 (Rel2 Rel2) Bool)
(declare-fun subset_3 (Rel3 Rel3) Bool)
;; --end functions

;; axioms
(assert 
 (! 
  (forall ((X Rel1)) (= (one_1 X) (and (exists ((a0 Atom)) (in_1 a0 X)) (forall ((a0 Atom)(b0 Atom)) (=> (and (in_1 a0 X) (in_1 b0 X)) (= a0 b0)))))) 
 :named axiom12f951fb 
 ) 
 )
(assert 
 (! 
  (forall ((y0 Atom)(x0 Atom)(A Rel1)(B Rel1)) (= (in_2 x0 y0 (prod_1x1 A B)) (and (in_1 x0 A) (in_1 y0 B)))) 
 :named axiom19bef732 
 ) 
 )
(assert 
 (! 
  ; subset axiom for Rel2
(forall ((x Rel2)(y Rel2)) (= (subset_2 x y) (forall ((a0 Atom)(a1 Atom)) (=> (in_2 a0 a1 x) (in_2 a0 a1 y))))) 
 :named axiom225d0e51 
 ) 
 )
(assert 
 (! 
  ; (forall ((A Rel1)(B Rel1)) (= (disjoint_1 A B) (forall ((a0 Atom)) (=> (in_1 a0 A) (not (in_1 a0 B)))))); alternative
(forall ((A Rel1)(B Rel1)) (= (disjoint_1 A B) (forall ((a0 Atom)) (not (and (in_1 a0 A) (in_1 a0 B)))))) 
 :named axiom300ecb75 
 ) 
 )
(assert 
 (! 
  ; axiom for join_2x1
(forall ((A Rel2)(B Rel1)(y0 Atom)) (= (in_1 y0 (join_2x1 A B)) (exists ((x Atom)) (and (in_2 y0 x A) (in_1 x B))))) 
 :named axiom48f6aa73 
 ) 
 )
(assert 
 (! 
  ; axiom for 'the expression is empty'
(forall ((a0 Atom)(R Rel1)) (=> (no_1 R) (not (in_1 a0 R)))) 
 :named axiom6282b3bb 
 ) 
 )
(assert 
 (! 
  ; axiom for empty set
(forall ((a Atom)) (not (in_1 a none))) 
 :named axiom6cf65805 
 ) 
 )
(assert 
 (! 
  (forall ((y0 Atom)(x0 Atom)(x1 Atom)(A Rel2)(B Rel1)) (= (in_3 x0 x1 y0 (prod_2x1 A B)) (and (in_2 x0 x1 A) (in_1 y0 B)))) 
 :named axiom6f1bf92f 
 ) 
 )
(assert 
 (! 
  ; subset axiom for Rel1
(forall ((x Rel1)(y Rel1)) (= (subset_1 x y) (forall ((a0 Atom)) (=> (in_1 a0 x) (in_1 a0 y))))) 
 :named axiom76d2de83 
 ) 
 )
(assert 
 (! 
  ; axiom for join_2x2
(forall ((A Rel2)(B Rel2)(y0 Atom)(y1 Atom)) (= (in_2 y0 y1 (join_2x2 A B)) (exists ((x Atom)) (and (in_2 y0 x A) (in_2 x y1 B))))) 
 :named axiom785d259e 
 ) 
 )
(assert 
 (! 
  ; axiom for the conversion function Atom -> Relation
(forall ((x0 Atom)(x1 Atom)) (and (in_2 x0 x1 (a2r_2 x0 x1)) (forall ((y0 Atom)(y1 Atom)) (=> (in_2 y0 y1 (a2r_2 x0 x1)) (and (= x0 y0) (= x1 y1)))))) 
 :named axiom7a8a4465 
 ) 
 )
(assert 
 (! 
  ; axiom for join_1x3
(forall ((A Rel1)(B Rel3)(y0 Atom)(y1 Atom)) (= (in_2 y0 y1 (join_1x3 A B)) (exists ((x Atom)) (and (in_1 x A) (in_3 x y0 y1 B))))) 
 :named axiom82f21aba 
 ) 
 )
(assert 
 (! 
  ; subset axiom for Rel3
(forall ((x Rel3)(y Rel3)) (= (subset_3 x y) (forall ((a0 Atom)(a1 Atom)(a2 Atom)) (=> (in_3 a0 a1 a2 x) (in_3 a0 a1 a2 y))))) 
 :named axiomb131cb24 
 ) 
 )
(assert 
 (! 
  ; axiom for join_1x2
(forall ((A Rel1)(B Rel2)(y0 Atom)) (= (in_1 y0 (join_1x2 A B)) (exists ((x Atom)) (and (in_1 x A) (in_2 x y0 B))))) 
 :named axiomc43ab575 
 ) 
 )
(assert 
 (! 
  ; axiom for the conversion function Atom -> Relation
(forall ((x0 Atom)) (and (in_1 x0 (a2r_1 x0)) (forall ((y0 Atom)) (=> (in_1 y0 (a2r_1 x0)) (= x0 y0))))) 
 :named axiome566b6fc 
 ) 
 )
;; --end axioms

;; assertions
(assert 
 (! 
  (subset_2 iids (prod_1x1 Component IID)) 
 :named assert1c53bbdd 
 ) 
 )
(assert 
 (! 
  (subset_1 LegalComponent Component) 
 :named assert2eafe484 
 ) 
 )
(assert 
 (! 
  (subset_2 identity (prod_1x1 Component Interface)) 
 :named assert5102f761 
 ) 
 )
(assert 
 (! 
  (forall ((i Atom)) (=> (in_1 i LegalInterface) (subset_1 (join_1x2 (a2r_1 i) iids1) (join_1x2 (a2r_1 i) iidsKnown)))) 
 :named assert5254527d 
 ) 
 )
(assert 
 (! 
  (subset_2 iidsKnown (prod_1x1 Interface IID)) 
 :named assert5474ebd8 
 ) 
 )
(assert 
 (! 
  (subset_2 iids1 (prod_1x1 Interface IID)) 
 :named assert5a02da66 
 ) 
 )
(assert 
 (! 
  (exists ((unknown Atom)) (and (in_1 unknown IID) (forall ((c Atom)) (=> (in_1 c Component) (forall ((i Atom)) (=> (and (in_1 i Interface) (in_1 i (join_1x2 (a2r_1 c) interfaces))) (= (join_1x2 (a2r_1 unknown) (join_1x3 (a2r_1 i) qi)) (join_1x2 (a2r_1 c) identity)))))))) 
 :named assert68a24311 
 ) 
 )
(assert 
 (! 
  (disjoint_1 Component Interface) 
 :named assert7037379d 
 ) 
 )
(assert 
 (! 
  (not (exists ((c Atom)) (and (in_1 c LegalComponent) (exists ((i Atom)) (and 
    (in_1 i Interface)
    (in_1 i (join_1x2 (a2r_1 c) interfaces))
    (not (= (join_1x2 (a2r_1 i) iidsKnown) (join_1x2 (a2r_1 c) iids)))
  ))))) 
 :named assert704e1745 
 ) 
 )
(assert 
 (! 
  (forall ((this Atom)) (=> (in_1 this Interface) (one_1 (join_1x2 (a2r_1 this) iidsKnown)))) 
 :named assert8367b169 
 ) 
 )
(assert 
 (! 
  (forall ((i Atom)) (=> (in_1 i Interface) (= (join_1x2 (a2r_1 i) reaches) (join_1x2 IID (join_1x3 (a2r_1 i) qi))))) 
 :named assert8690da5e 
 ) 
 )
(assert 
 (! 
  (subset_2 reaches (prod_1x1 Interface Interface)) 
 :named assert8d43835a 
 ) 
 )
(assert 
 (! 
  (subset_2 interfaces (prod_1x1 Component Interface)) 
 :named assert9dd48c3d 
 ) 
 )
(assert 
 (! 
  (forall ((c Atom)) (=> (in_1 c Component) (= (join_1x2 (a2r_1 c) iids) (join_1x2 (join_1x2 (a2r_1 c) interfaces) iids1)))) 
 :named assert9e56141d 
 ) 
 )
(assert 
 (! 
  (disjoint_1 Component IID) 
 :named asserta3ec40b2 
 ) 
 )
(assert 
 (! 
  (forall ((this Atom)) (=> (in_1 this Interface) (one_1 (join_1x2 (a2r_1 this) reaches)))) 
 :named assertb39992b6 
 ) 
 )
(assert 
 (! 
  (forall ((i Atom)(j Atom)) (=> (and (in_1 i LegalInterface) (in_1 j LegalInterface)) (=> (in_1 j (join_1x2 (a2r_1 i) reaches)) (subset_1 (join_1x2 (a2r_1 i) iids1) (join_1x2 (a2r_1 j) iidsKnown))))) 
 :named assertb86ae29f 
 ) 
 )
(assert 
 (! 
  (disjoint_1 IID Interface) 
 :named assertbc6f7676 
 ) 
 )
(assert 
 (! 
  (subset_3 qi (prod_2x1 (prod_1x1 Interface IID) Interface)) 
 :named assertc394fc36 
 ) 
 )
(assert 
 (! 
  (forall ((this Atom)) (=> (in_1 this Component) (and (one_1 (join_1x2 (a2r_1 this) identity)) (subset_1 (join_1x2 (a2r_1 this) identity) (join_1x2 (a2r_1 this) interfaces))))) 
 :named assertc493310 
 ) 
 )
(assert 
 (! 
  (subset_1 (join_1x2 LegalComponent interfaces) LegalInterface) 
 :named assertd15e0402 
 ) 
 )
(assert 
 (! 
  (forall ((i Atom)(j Atom)) (=> (and (in_1 i LegalInterface) (in_1 j LegalInterface)) (=> (in_1 j (join_1x2 (a2r_1 i) reaches)) (subset_1 (join_1x2 (a2r_1 j) iidsKnown) (join_1x2 (a2r_1 i) iidsKnown))))) 
 :named asserte2b27e6f 
 ) 
 )
(assert 
 (! 
  (subset_1 LegalInterface Interface) 
 :named asserte3e0e0c 
 ) 
 )
(assert 
 (! 
  (forall ((i Atom)) (=> (in_1 i LegalInterface) (forall ((x Atom)) (=> (and (in_1 x IID) (in_1 x (join_1x2 (a2r_1 i) iidsKnown))) (in_1 x (join_1x2 (join_1x2 (a2r_1 x) (join_1x3 (a2r_1 i) qi)) iids1)))))) 
 :named assertea9f38c1 
 ) 
 )
;; --end assertions

;; command
(assert 
 (! 
  (not (not (exists ((c Atom)) (and (in_1 c LegalComponent) (exists ((i Atom)) (and 
    (in_1 i Interface)
    (in_1 i (join_1x2 (a2r_1 c) interfaces))
    (not (subset_1 (join_1x2 (a2r_1 c) iids) (join_1x2 (a2r_1 i) iidsKnown)))
  )))))) 
 :named commandb3a58e52 
 ) 
 )
;; --end command

;; lemmas
(assert
 (! 
  ; lemma about subsets within joins, from com-theorem1, related to step 45
(forall ((a Rel1)(A Rel1)(B Rel1)(R Rel2)) (=> (subset_1 a A) (subset_1 (join_1x2 a R) (join_1x2 A R)))) 
 :named lemma1aecfc94 
 ) 
 )
(assert
 (! 
  ; 2. lemma for join_2x2. direction: in to join
(forall ((a2 Atom)(a1 Atom)(a0 Atom)(r Rel2)) (=> (in_2 a1 a0 r) (in_2 a2 a0 (join_2x2 ; (swapped)
(a2r_2 a2 a1) r)))) 
 :named lemma3bc35ca3 
 ) 
 )
(assert
 (! 
  ; 2. lemma for join_2x1. direction: in to join
(forall ((a0 Atom)(a1 Atom)(r Rel2)) (=> (in_2 a0 a1 r) (in_1 a0 (join_2x1 r (a2r_1 a1))))) 
 :named lemma50960a04 
 ) 
 )
(assert
 (! 
  ; equality Lemma (newly introduced. Be careful, this is very costly.
(forall ((x Rel1)(y Rel1)) (=> (= x y) (and (subset_1 x y) (subset_1 y x)))) 
 :named lemma68418934 
 ) 
 )
(assert
 (! 
  ; 2. lemma for join_1x2. direction: in to join
(forall ((a1 Atom)(a0 Atom)(r Rel2)) (=> (in_2 a1 a0 r) (in_1 a0 (join_1x2 ; (swapped)
(a2r_1 a1) r)))) 
 :named lemma6ec6a62 
 ) 
 )
(assert
 (! 
  ; 2. lemma for join_1x3. direction: in to join
(forall ((a2 Atom)(a1 Atom)(a0 Atom)(r Rel3)) (=> (in_3 a2 a1 a0 r) (in_2 a1 a0 (join_1x3 ; (swapped)
(a2r_1 a2) r)))) 
 :named lemma823ccdc0 
 ) 
 )
(assert
 (! 
  ; lemma for step 21 of the com-theorem1 for join_1x2: R=(i.qi) S=iids
(forall ((R Rel2)(S Rel2)(x Atom)) (=> (no_1 (join_1x2 (a2r_1 x) R)) (no_1 (join_1x2 (a2r_1 x) (join_2x2 R S))))) 
 :named lemma844803cd 
 ) 
 )
(assert
 (! 
  ; lstep20: lemma about subset 2 and product 1x1 , using join
(forall ((R Rel2)(A Rel1)(B Rel1)) (=> (subset_2 R (prod_1x1 A B)) (forall ((a0 Atom)) (= (not (in_1 a0 (join_2x1 R B))) (no_1 (join_1x2 (a2r_1 a0) R)))))) 
 :named lemma8f0bdd2 
 ) 
 )
(assert
 (! 
  ; 1. lemma for join_2x2. direction: join to in
(forall ((a2 Atom)(a1 Atom)(a0 Atom)(r Rel2)) (=> (in_2 a2 a0 (join_2x2 ; (swapped)
(a2r_2 a2 a1) r)) (in_2 a1 a0 r))) 
 :named lemmaaa5ad85c 
 ) 
 )
(assert
 (! 
  ; joinOfProdRel: originally introduced for COM-theorem1 step 19->20 with R=qi, A=C=Interface, B=IID
(forall ((a Atom)(A Rel1)(B Rel1)(C Rel1)(R Rel3)) (= (subset_3 R (prod_2x1 (prod_1x1 A B) C)) (subset_2 (join_1x3 (a2r_1 a) R) (prod_1x1 B C)))) 
 :named lemmacb5f335f 
 ) 
 )
(assert
 (! 
  ; 1. lemma for join_1x3. direction: join to in
(forall ((a2 Atom)(a1 Atom)(a0 Atom)(r Rel3)) (=> (in_2 a1 a0 (join_1x3 ; (swapped)
(a2r_1 a2) r)) (in_3 a2 a1 a0 r))) 
 :named lemmadc7b01cf 
 ) 
 )
(assert
 (! 
  ; 1. lemma for join_2x1. direction: join to in
(forall ((a0 Atom)(a1 Atom)(r Rel2)) (=> (in_1 a0 (join_2x1 r (a2r_1 a1))) (in_2 a0 a1 r))) 
 :named lemmaec517cdd 
 ) 
 )
(assert
 (! 
  ; 1. lemma for join_1x2. direction: join to in
(forall ((a1 Atom)(a0 Atom)(r Rel2)) (=> (in_1 a0 (join_1x2 ; (swapped)
(a2r_1 a1) r)) (in_2 a1 a0 r))) 
 :named lemmaf97e883f 
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
