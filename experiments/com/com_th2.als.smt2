; file: /amd.home/home/best/experiment/com/com_th2.als 
; hash:  2 1FE90F4B24CD9C1B97F493AE2 97C
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
(declare-fun aggregates () Rel2)
(declare-fun diff_1 (Rel1 Rel1) Rel1)
(declare-fun disjoint_1 (Rel1 Rel1) Bool)
(declare-fun eqs () Rel2)
(declare-fun first () Rel2)
(declare-fun identity () Rel2)
(declare-fun iids () Rel2)
(declare-fun iids1 () Rel2)
(declare-fun iidsKnown () Rel2)
(declare-fun in_1 (Atom Rel1) Bool)
(declare-fun in_2 (Atom Atom Rel2) Bool)
(declare-fun in_3 (Atom Atom Atom Rel3) Bool)
(declare-fun inter_1 (Rel1 Rel1) Rel1)
(declare-fun interfaces () Rel2)
(declare-fun join_1x2 (Rel1 Rel2) Rel1)
(declare-fun join_1x3 (Rel1 Rel3) Rel2)
(declare-fun join_2x1 (Rel2 Rel1) Rel1)
(declare-fun join_2x2 (Rel2 Rel2) Rel2)
(declare-fun lone_1 (Rel1) Bool)
(declare-fun no_1 (Rel1) Bool)
(declare-fun none () Rel1)
(declare-fun one_1 (Rel1) Bool)
(declare-fun prod_1x1 (Rel1 Rel1) Rel2)
(declare-fun prod_2x1 (Rel2 Rel1) Rel3)
(declare-fun qi () Rel3)
(declare-fun reaches () Rel2)
(declare-fun some_1 (Rel1) Bool)
(declare-fun subset_1 (Rel1 Rel1) Bool)
(declare-fun subset_2 (Rel2 Rel2) Bool)
(declare-fun subset_3 (Rel3 Rel3) Bool)
(declare-fun trans (Rel2) Bool)
(declare-fun transClos (Rel2) Rel2)
;; --end functions

;; axioms
(assert 
 (! 
  ; this axiom defines transitivity
(forall ((r Rel2)) (= (trans r) (forall ((a1 Atom)(a2 Atom)(a3 Atom)) (=> (and (in_2 a1 a2 r) (in_2 a2 a3 r)) (in_2 a1 a3 r))))) 
 :named axiom11718914 
 ) 
 )
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
  ; this axioms satisfies that r should be in transclos of r
(forall ((r Rel2)) (subset_2 r (transClos r))) 
 :named axiom24c02eb3 
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
  (forall ((A Rel1)(B Rel1)(a0 Atom)) (= (in_1 a0 (diff_1 A B)) (and (in_1 a0 A) (not (in_1 a0 B))))) 
 :named axiom63f656cf 
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
  ; this axiom satisfies minimality of transclos
(forall ((r1 Rel2)(r2 Rel2)) (=> (and (subset_2 r1 r2) (trans r2)) (subset_2 (transClos r1) r2))) 
 :named axioma79c8c27 
 ) 
 )
(assert 
 (! 
  (forall ((X Rel1)) (= (lone_1 X) (forall ((a0 Atom)(b0 Atom)) (=> (and (in_1 a0 X) (in_1 b0 X)) (= a0 b0))))) 
 :named axiomaa1ef80f 
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
  ; axiom for intersection 1
(forall ((a0 Atom)(R Rel1)(S Rel1)) (=> (in_1 a0 (inter_1 R S)) (or (in_1 a0 R) (in_1 a0 S)))) 
 :named axiombeb924e6 
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
  (forall ((A Rel1)) (= (some_1 A) (exists ((a0 Atom)) (in_1 a0 A)))) 
 :named axiomdf19d42f 
 ) 
 )
(assert 
 (! 
  ; axiom for the conversion function Atom -> Relation
(forall ((x0 Atom)) (and (in_1 x0 (a2r_1 x0)) (forall ((y0 Atom)) (=> (in_1 y0 (a2r_1 x0)) (= x0 y0))))) 
 :named axiome566b6fc 
 ) 
 )
(assert 
 (! 
  ; this axiom satisfies transitivity for transclos
(forall ((r Rel2)) (trans (transClos r))) 
 :named axiomeee40a91 
 ) 
 )
;; --end axioms

;; assertions
(assert 
 (! 
  (disjoint_1 IID Component) 
 :named assert10bbf32 
 ) 
 )
(assert 
 (! 
  (forall ((c Atom)) (=> (in_1 c Component) (and (= (join_1x2 (a2r_1 c) iids1) (join_1x2 (join_1x2 (a2r_1 c) interfaces) iids)) (forall ((i Atom)) (=> (and (in_1 i Interface) (in_1 i (join_1x2 (a2r_1 c) interfaces))) (forall ((x Atom)) (=> (in_1 x IID) (subset_1 (join_1x2 (a2r_1 x) (join_1x3 (a2r_1 i) qi)) (join_1x2 (a2r_1 c) interfaces))))))))) 
 :named assert1f4df55a 
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
  (subset_2 iidsKnown (prod_1x1 Interface IID)) 
 :named assert5474ebd8 
 ) 
 )
(assert 
 (! 
  (subset_2 eqs (prod_1x1 Component Component)) 
 :named assert589a4e48 
 ) 
 )
(assert 
 (! 
  (forall ((c1 Atom)(c2 Atom)) (=> (and (in_1 c1 Component) (in_1 c2 Component)) (= (subset_2 (prod_1x1 (a2r_1 c1) (a2r_1 c2)) eqs) (= (join_1x2 (a2r_1 c1) identity) (join_1x2 (a2r_1 c2) identity))))) 
 :named assert5e6d7faa 
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
  (forall ((this Atom)) (=> (in_1 this Component) (and (one_1 (join_1x2 (a2r_1 this) identity)) (and (one_1 (join_1x2 (a2r_1 this) first)) (and (subset_1 (join_1x2 (a2r_1 this) first) (join_1x2 (a2r_1 this) interfaces)) (subset_1 (join_1x2 (a2r_1 this) identity) (join_1x2 (a2r_1 this) interfaces))))))) 
 :named assert68a440f7 
 ) 
 )
(assert 
 (! 
  (forall ((i Atom)) (=> (in_1 i Interface) (and (= (join_1x2 (a2r_1 i) iidsKnown) (join_2x1 (join_1x3 (a2r_1 i) qi) Interface)) (= (join_1x2 (a2r_1 i) reaches) (join_1x2 IID (join_1x3 (a2r_1 i) qi)))))) 
 :named assert88a89e21 
 ) 
 )
(assert 
 (! 
  (and (not (exists ((c Atom)) (and (in_1 c Component) (in_1 c (join_1x2 (a2r_1 c) (transClos aggregates)))))) (forall ((outer Atom)) (=> (in_1 outer Component) (forall ((inner Atom)) (=> (and (in_1 inner Component) (in_1 inner (join_1x2 (a2r_1 outer) aggregates))) (and (some_1 (inter_1 (join_1x2 (a2r_1 inner) interfaces) (join_1x2 (a2r_1 outer) interfaces))) (exists ((o Atom)) (and 
    (in_1 o Interface)
    (in_1 o (join_1x2 (a2r_1 outer) interfaces))
    (forall ((i Atom)) (=> (and (in_1 i Interface) (in_1 i (diff_1 (join_1x2 (a2r_1 inner) interfaces) (join_1x2 (a2r_1 inner) first)))) (forall ((x Atom)) (=> (in_1 x Component) (= (join_1x2 (join_1x2 (a2r_1 x) iids1) (join_1x3 (a2r_1 i) qi)) (join_1x2 (join_1x2 (a2r_1 x) iids1) (join_1x3 (a2r_1 o) qi)))))))
  )))))))) 
 :named assert8acd3412 
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
  (subset_2 aggregates (prod_1x1 Component Component)) 
 :named assert9898733b 
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
  (subset_2 first (prod_1x1 Component Interface)) 
 :named asserta35ba1ad 
 ) 
 )
(assert 
 (! 
  (subset_2 iids1 (prod_1x1 Component IID)) 
 :named assertb4a2a72a 
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
  (subset_2 iids (prod_1x1 Interface IID)) 
 :named assertc1b3ef19 
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
  (forall ((i Atom)) (=> (in_1 i LegalInterface) (subset_1 (join_1x2 (a2r_1 i) iids) (join_1x2 (a2r_1 i) iidsKnown)))) 
 :named assertc7a7d492 
 ) 
 )
(assert 
 (! 
  (forall ((this Atom)) (=> (in_1 this Interface) (forall ((x0 Atom)) (=> (in_1 x0 IID) (lone_1 (join_1x2 (a2r_1 x0) (join_1x3 (a2r_1 this) qi))))))) 
 :named assertcca8e859 
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
  (forall ((i Atom)(j Atom)) (=> (and (in_1 i LegalInterface) (in_1 j LegalInterface)) (=> (in_1 j (join_1x2 (a2r_1 i) reaches)) (subset_1 (join_1x2 (a2r_1 i) iids) (join_1x2 (a2r_1 j) iidsKnown))))) 
 :named assertd42a6246 
 ) 
 )
(assert 
 (! 
  (disjoint_1 Interface Component) 
 :named assertd8fdf29d 
 ) 
 )
(assert 
 (! 
  (forall ((i Atom)) (=> (in_1 i LegalInterface) (forall ((x Atom)) (=> (and (in_1 x IID) (in_1 x (join_1x2 (a2r_1 i) iidsKnown))) (in_1 x (join_1x2 (join_1x2 (a2r_1 x) (join_1x3 (a2r_1 i) qi)) iids)))))) 
 :named asserte1248f70 
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
;; --end assertions

;; command
(assert 
 (! 
  (not (forall ((outer Atom)) (=> (in_1 outer Component) (forall ((inner Atom)) (=> (and (in_1 inner Component) (in_1 inner (join_1x2 (a2r_1 outer) aggregates))) (=> (in_1 inner LegalComponent) (subset_1 (join_1x2 (a2r_1 inner) iids1) (join_1x2 (a2r_1 outer) iids1)))))))) 
 :named commande8795dcc 
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
  ; weak lemma 1 for transClos about the second-last 'middle element'
(forall ((a1 Atom)(a3 Atom)(R Rel2)) (=> (in_2 a1 a3 (transClos R)) (exists ((a2 Atom)) (in_2 a2 a3 R)))) 
 :named lemma6816308a 
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
