; file: D:\Entwicklung\workspace\alloy2relsmt\smtexamples\paintball-turnierplan2.als 
; hash: 84B3531C 0466F9E932238CD4C6427FC
(set-logic AUFLIA)
(set-option :macro-finder true)
;; sorts
(declare-sort Atom)
(declare-sort Rel1)
(declare-sort Rel2)
;; --end sorts

;; functions
(declare-fun Hyperball () Rel1)
(declare-fun Map () Rel1)
(declare-fun Match () Rel1)
(declare-fun Round () Rel1)
(declare-fun Speedball () Rel1)
(declare-fun Tactical () Rel1)
(declare-fun Team () Rel1)
(declare-fun Test () Bool)
(declare-fun Woodland () Rel1)
(declare-fun a2r_1 (Atom) Rel1)
(declare-fun at (Rel1 Int) Atom)
(declare-fun card_1 (Rel1) Int)
(declare-fun contestants () Rel2)
(declare-fun diff_1 (Rel1 Rel1) Rel1)
(declare-fun disjoint_1 (Rel1 Rel1) Bool)
(declare-fun finite (Rel1) Bool)
(declare-fun in_1 (Atom Rel1) Bool)
(declare-fun in_2 (Atom Atom Rel2) Bool)
(declare-fun join_1x2 (Rel1 Rel2) Rel1)
(declare-fun join_2x1 (Rel2 Rel1) Rel1)
(declare-fun map () Rel2)
(declare-fun match () Rel2)
(declare-fun one_1 (Rel1) Bool)
(declare-fun ord (Rel1 Atom) Int)
(declare-fun pause () Rel2)
(declare-fun prod_1x1 (Rel1 Rel1) Rel2)
(declare-fun rangeRestr_1 (Rel1 Rel1) Rel1)
(declare-fun ref () Rel2)
(declare-fun round () Rel2)
(declare-fun some_1 (Rel1) Bool)
(declare-fun subset_1 (Rel1 Rel1) Bool)
(declare-fun subset_2 (Rel2 Rel2) Bool)
(declare-fun type () Rel2)
(declare-fun union_1 (Rel1 Rel1) Rel1)
;; --end functions

;; axioms
(assert 
 (! 
  ; axiom for union of Rel1
(forall ((x0 Atom)(A Rel1)(B Rel1)) (= (in_1 x0 (union_1 A B)) (or (in_1 x0 A) (in_1 x0 B)))) 
 :named axiom105b8187 
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
  (forall ((A Rel1)(B Rel1)(a0 Atom)) (= (in_1 a0 (diff_1 A B)) (and (in_1 a0 A) (not (in_1 a0 B))))) 
 :named axiom63f656cf 
 ) 
 )
(assert 
 (! 
  ; axiom about finite Relations having a card > ord > 1
(forall ((a0 Atom)(R Rel1)) (=> (and (finite R) (in_1 a0 R)) (and (>= (card_1 R) (ord R a0)) (>= (ord R a0) 1)))) 
 :named axiom6cbb20cf 
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
  ; axiom for ord
(forall ((R Rel1)(a Atom)(b Atom)) (=> (and 
    (in_1 a R)
    (in_1 b R)
    (= (ord R a) (ord R b))
  ) (= a b))) 
 :named axiom850049b2 
 ) 
 )
(assert 
 (! 
  ; Axiom for range restriction of arity 1
(=> (and 
    (in_1 b0 R)
    (in_1 a S)
    (in_1 b0 (rangeRestr_1 R S))
  ) (= b0 a)) 
 :named axiom8c1635e8 
 ) 
 )
(assert 
 (! 
  ; axiom for at (the reverse of ord)
(forall ((R Rel1)(a Atom)) (=> (in_1 a R) (= (at R (ord R a)) a))) 
 :named axiom9d8f87d2 
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
;; --end axioms

;; assertions
(assert 
 (! 
  (forall ((this Atom)) (=> (in_1 this Round) (some_1 (join_1x2 (a2r_1 this) pause)))) 
 :named assert123d708 
 ) 
 )
(assert 
 (! 
  (forall ((t Atom)) (=> (in_1 t Team) (and (< 1 (card_1 (join_2x1 pause (a2r_1 t)))) (< (card_1 (join_2x1 pause (a2r_1 t))) 4)))) 
 :named assert12764ea 
 ) 
 )
(assert 
 (! 
  (forall ((this Atom)) (=> (in_1 this Team) (in_1 this (join_1x2 Match contestants)))) 
 :named assert22657e73 
 ) 
 )
(assert 
 (! 
  (disjoint_1 Hyperball Woodland) 
 :named assert237645d2 
 ) 
 )
(assert 
 (! 
  (and (forall ((r Atom)(m Atom)) (=> (and (in_1 r Round) (and (in_1 m Match) (in_1 m (join_1x2 (a2r_1 r) match)))) (not (subset_1 (join_1x2 (a2r_1 m) ref) (union_1 (join_1x2 (diff_1 (join_1x2 (a2r_1 r) match) (a2r_1 m)) ref) (join_1x2 (diff_1 (join_1x2 (a2r_1 r) match) (a2r_1 m)) contestants)))))) (forall ((r Atom)(m Atom)(t Atom)) (=> (and 
    (in_1 r Round)
    (and (in_1 m Match) (in_1 m (join_1x2 (a2r_1 r) match)))
    (and (in_1 t Team) (in_1 t (join_1x2 (a2r_1 m) contestants)))
  ) (not (in_1 t (union_1 (join_1x2 (diff_1 (join_1x2 (a2r_1 r) match) (a2r_1 m)) ref) (join_1x2 (diff_1 (join_1x2 (a2r_1 r) match) (a2r_1 m)) contestants))))))) 
 :named assert25ee9f77 
 ) 
 )
(assert 
 (! 
  (subset_2 contestants (prod_1x1 Match Team)) 
 :named assert2615d8d1 
 ) 
 )
(assert 
 (! 
  (disjoint_1 Hyperball Speedball) 
 :named assert26ed2982 
 ) 
 )
(assert 
 (! 
  (= Test true) 
 :named assert3d29ff58 
 ) 
 )
(assert 
 (! 
  (forall ((this Atom)) (=> (in_1 this Match) (and 
    (in_1 this (join_1x2 (join_1x2 (a2r_1 this) round) match))
    (= 2 (card_1 (join_1x2 (a2r_1 this) contestants)))
    (not (subset_1 (join_1x2 (a2r_1 this) ref) (join_1x2 (a2r_1 this) contestants)))
  ))) 
 :named assert47c53e70 
 ) 
 )
(assert 
 (! 
  (subset_1 Tactical Map) 
 :named assert4a34f546 
 ) 
 )
(assert 
 (! 
  (one_1 Woodland) 
 :named assert4e48d241 
 ) 
 )
(assert 
 (! 
  (disjoint_1 Match Round) 
 :named assert4f9463a0 
 ) 
 )
(assert 
 (! 
  (one_1 Speedball) 
 :named assert566c2af3 
 ) 
 )
(assert 
 (! 
  (disjoint_1 Hyperball Tactical) 
 :named assert58b1b9e7 
 ) 
 )
(assert 
 (! 
  (forall ((this Atom)) (=> (in_1 this Match) (one_1 (join_1x2 (a2r_1 this) map)))) 
 :named assert58db6425 
 ) 
 )
(assert 
 (! 
  (disjoint_1 Map Match) 
 :named assert5b2a152 
 ) 
 )
(assert 
 (! 
  (forall ((a Atom)(b Atom)) (=> (and (in_1 a Team) (in_1 b Team)) (exists ((m Atom)) (and (in_1 m Match) (subset_1 (union_1 (a2r_1 a) (a2r_1 b)) (join_1x2 (a2r_1 m) contestants)))))) 
 :named assert658806c3 
 ) 
 )
(assert 
 (! 
  (and (= (prod_1x1 (join_1x2 Match map) (join_1x2 Match contestants)) (prod_1x1 Map Team)) (forall ((t Atom)(m Atom)) (=> (and (in_1 t Team) (in_1 m Map)) (and (< 1 (card_1 (rangeRestr_1 (join_2x1 contestants (a2r_1 t)) (join_2x1 map (a2r_1 m))))) (< (card_1 (rangeRestr_1 (join_2x1 contestants (a2r_1 t)) (join_2x1 map (a2r_1 m)))) 5))))) 
 :named assert661bf888 
 ) 
 )
(assert 
 (! 
  (forall ((this Atom)) (=> (in_1 this Match) (one_1 (join_1x2 (a2r_1 this) ref)))) 
 :named assert67a103dc 
 ) 
 )
(assert 
 (! 
  (subset_2 ref (prod_1x1 Match Team)) 
 :named assert77e9fc5e 
 ) 
 )
(assert 
 (! 
  (subset_2 pause (prod_1x1 Round Team)) 
 :named assert79be9ef2 
 ) 
 )
(assert 
 (! 
  (subset_2 round (prod_1x1 Match Round)) 
 :named assert7fd2abe8 
 ) 
 )
(assert 
 (! 
  (forall ((r Atom)(m Atom)) (=> (and (in_1 r Round) (and (in_1 m Match) (in_1 m (join_1x2 (a2r_1 r) match)))) (not (subset_1 (join_1x2 (a2r_1 m) map) (join_1x2 (diff_1 (join_1x2 (a2r_1 r) match) (a2r_1 m)) map))))) 
 :named assert829ecd31 
 ) 
 )
(assert 
 (! 
  (one_1 Tactical) 
 :named assert83844656 
 ) 
 )
(assert 
 (! 
  (disjoint_1 Map Team) 
 :named assert84b4455e 
 ) 
 )
(assert 
 (! 
  (forall ((this Atom)) (=> (in_1 this Map) (one_1 (join_1x2 (a2r_1 this) type)))) 
 :named assert89c5b868 
 ) 
 )
(assert 
 (! 
  (forall ((this Atom)) (=> (in_1 this Map) (or 
    (in_1 this Hyperball)
    (in_1 this Speedball)
    (in_1 this Tactical)
    (in_1 this Woodland)
   ))) 
 :named assert8b947dae 
 ) 
 )
(assert 
 (! 
  (subset_1 Speedball Map) 
 :named assert8faf5ecb 
 ) 
 )
(assert 
 (! 
  (forall ((this Atom)) (=> (in_1 this Round) (and (= (a2r_1 this) (join_1x2 (join_1x2 (a2r_1 this) match) round)) (forall ((t Atom)) (=> (and (in_1 t Team) (in_1 t (join_1x2 (a2r_1 this) pause))) (not (in_1 t (union_1 (join_1x2 (join_1x2 (a2r_1 this) match) contestants) (join_1x2 (join_1x2 (a2r_1 this) match) ref))))))))) 
 :named assert958c808e 
 ) 
 )
(assert 
 (! 
  (one_1 Hyperball) 
 :named assert9c3cfbee 
 ) 
 )
(assert 
 (! 
  (forall ((this Atom)) (=> (in_1 this Match) (one_1 (join_1x2 (a2r_1 this) round)))) 
 :named asserta4b68917 
 ) 
 )
(assert 
 (! 
  (subset_2 type (prod_1x1 Map Int)) 
 :named asserta4c09df2 
 ) 
 )
(assert 
 (! 
  (disjoint_1 Speedball Woodland) 
 :named assertaf5b2c6d 
 ) 
 )
(assert 
 (! 
  (disjoint_1 Team Match) 
 :named assertb322c89d 
 ) 
 )
(assert 
 (! 
  (forall ((this Atom)) (=> (in_1 this Map) (subset_1 (join_1x2 (a2r_1 this) type) (I (+ 0 1))))) 
 :named assertb3742fa5 
 ) 
 )
(assert 
 (! 
  (disjoint_1 Team Round) 
 :named assertbc70e9f4 
 ) 
 )
(assert 
 (! 
  (forall ((this Atom)) (=> (in_1 this Woodland) (= (sum (join_1x2 Woodland type)) 1))) 
 :named assertbe9eda96 
 ) 
 )
(assert 
 (! 
  (forall ((this Atom)) (=> (in_1 this Tactical) (= (sum (join_1x2 Tactical type)) 0))) 
 :named assertc03d14d 
 ) 
 )
(assert 
 (! 
  (subset_1 Woodland Map) 
 :named assertc6ab93b1 
 ) 
 )
(assert 
 (! 
  (forall ((this Atom)) (=> (in_1 this Speedball) (= (sum (join_1x2 Speedball type)) 1))) 
 :named assertca3f26f0 
 ) 
 )
(assert 
 (! 
  (subset_2 map (prod_1x1 Match Map)) 
 :named assertd80f2344 
 ) 
 )
(assert 
 (! 
  (forall ((this Atom)) (=> (in_1 this Hyperball) (= (sum (join_1x2 Hyperball type)) 0))) 
 :named assertddc400b1 
 ) 
 )
(assert 
 (! 
  (disjoint_1 Speedball Tactical) 
 :named asserte496a082 
 ) 
 )
(assert 
 (! 
  (subset_1 Hyperball Map) 
 :named assertee693a46 
 ) 
 )
(assert 
 (! 
  (disjoint_1 Map Round) 
 :named assertf00c2a9 
 ) 
 )
(assert 
 (! 
  (forall ((this Atom)) (=> (in_1 this Round) (some_1 (join_1x2 (a2r_1 this) match)))) 
 :named assertf44d0b57 
 ) 
 )
(assert 
 (! 
  (disjoint_1 Tactical Woodland) 
 :named assertf902a55e 
 ) 
 )
(assert 
 (! 
  (subset_2 match (prod_1x1 Round Match)) 
 :named assertffb9545f 
 ) 
 )
;; --end assertions

;; command
;; --end command

;; lemmas
(assert
 (! 
  ; 2. lemma for join_2x1. direction: in to join
(forall ((a0 Atom)(a1 Atom)(r Rel2)) (=> (in_2 a0 a1 r) (in_1 a0 (join_2x1 r (a2r_1 a1))))) 
 :named lemma50960a04 
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
