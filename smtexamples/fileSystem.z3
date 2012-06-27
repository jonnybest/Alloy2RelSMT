(set-logic UFBV)
(set-option :macro-finder true)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;
;; Tailored Background ...
;;

;; Sorts
(declare-sort Rel1)
(declare-sort Rel2)

(declare-sort Atom) ;; Atom = Atom



;; Operations 

(declare-fun in_1 (Atom Rel1) Bool)
(declare-fun in_2 (Atom Atom Rel2) Bool)
;// in_n are uninterpreted predicate

(declare-fun subSet_1 (Rel1 Rel1) Bool)
;// Axiomatization of subSet_1
(assert 
 (forall ( (r1 Rel1) (r2 Rel1) )
  (=
   (subSet_1 r1 r2)
   (forall ( (a Atom) )
    (=>
     (in_1 a r1)
     (in_1 a r2)
)))))

(declare-fun subSet_2 (Rel2 Rel2) Bool)
;// Axiomatization of subSet_2
(assert 
 (forall ( (r1 Rel2) (r2 Rel2) )
  (=
   (subSet_2 r1 r2)
   (forall ( (a1 Atom) (a2 Atom) )
    (=>
     (in_2 a1 a2 r1)
     (in_2 a1 a2 r2)
)))))


(declare-fun union_1 (Rel1 Rel1) Rel1)
;// Axiomatization of union_1
(assert 
 (forall ( (r1 Rel1) (r2 Rel1) (a Atom) )
  (=
   (in_1 a (union_1 r1 r2))
   (or
    (in_1 a r1)
    (in_1 a r2)
))))

(declare-fun inter_1 (Rel1 Rel1) Rel1)
;// Axiomatization of inter_1
(assert 
 (forall ( (r1 Rel1) (r2 Rel1) (a Atom) )
  (=
   (in_1 a (inter_1 r1 r2))
   (and
    (in_1 a r1)
    (in_1 a r2)
))))

(declare-fun diff_1 (Rel1 Rel1) Rel1)
;// Axiomatization of diff_1
(assert 
 (forall ( (r1 Rel1) (r2 Rel1) (a Atom) )
  (=
   (in_1 a (diff_1 r1 r2))
   (and
    (in_1 a r1)
    (not (in_1 a r2))
))))

(declare-fun join_1x2 (Rel1 Rel2) Rel1)
;;TODO: Axiomatization of join_1x2
(assert 
 (forall ( (r1 Rel1) (r2 Rel2) (a Atom) )
  (=
   (in_1 a (join_1x2 r1 r2))
   (exists ( (x Atom) )
    (and
     (in_1 x r1)
     (in_2 x a r2)
)))))


(declare-fun join_2x1 (Rel2 Rel1) Rel1)
;;TODO: Axiomatization of join_2x1
(assert 
 (forall ( (r1 Rel2) (r2 Rel1) (a Atom) )
  (=
   (in_1 a (join_2x1 r1 r2))
   (exists ( (x Atom) )
    (and
     (in_1 x r2)
     (in_2 a x r1)
)))))


(declare-fun a2r_1 (Atom) Rel1)
;;TODO: Axiomatization of a2r_1
(assert
 (forall ((a Atom))
  (in_1 a (a2r_1 a))
))
(assert
 (forall ((a1 Atom) (a2 Atom))
  (=>
   (in_1 a2 (a2r_1 a1))
   (= a2 a1)
)))


(declare-fun lone_1 (Rel1) Bool)
;;TODO: Axiomatization of lone_1
(assert
 (forall ( (r Rel1) )
  (=
   (lone_1 r)
   (forall ( (a1 Atom) (a2 Atom) ) 
    (=>
     (and
      (in_1 a1 r)
      (in_1 a2 r)
     )
     (= a1 a2)
)))))

(declare-fun some_1 (Rel1) Bool)
;;TODO: Axiomatization of some_1
(assert 
 (forall ( (r Rel1) ) 
  (=
   (some_1 r)
   (exists ( (a Atom) )
    (in_1 a r)
))))


(declare-fun one_1 (Rel1) Bool)
;;TODO: Axiomatization of one_1
(assert
 (forall ( (r Rel1) )
  (=
   (one_1 r)
   (and
    (some_1 r)
    (lone_1 r)
))))
;(assert
; (forall ( (r Rel1) )
;  (=
;   (one_1 r)
;   (exists ( (a0 Atom) ) 
;    (and
;     (in_1 a0 r)
;     (forall ( (a Atom))
;      (=>
;       (in_1 a r)
;       (= a a0)
;)))))))


(declare-fun transClos (Rel2) Rel2)
(declare-fun trans (Rel2) Bool)
(assert
 (forall ( (r Rel2) )
  (=
   (trans r)
   (forall ( (a1 Atom) (a2 Atom) (a3 Atom) )
    (=>
     (and
      (in_2 a1 a2 r)
      (in_2 a2 a3 r)
     )
    (in_2 a1 a3 r)
)))))

;; TODO: Axiomstization of transClos
;; 1. Approach
(assert
 (forall ( (r Rel2) ) 
  (subSet_2 r (transClos r))
))
(assert
 (forall ( (r Rel2) )
  (trans (transClos r))
))
(assert
 (forall ( (r1 Rel2) (r2 Rel2) )
  (=>
   (and
    (subSet_2 r1 r2)
    (trans r2)
   )
   (subSet_2 (transClos r1) r2)
)))


;; Constants
(declare-fun emptySet_1 () Rel1)
(assert
 (forall ((t Atom))
  (not (in_1 t emptySet_1))
 )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;Lemmas
;;

;;; in + join
(assert
 (forall ( (r Rel2) (a1 Atom) (a2 Atom) )
  (=>
   (in_2 a1 a2 r)
   (in_1 a2 (join_1x2 (a2r_1 a1) r))
)))
(assert
 (forall ( (r Rel2) (a1 Atom) (a2 Atom) )
  (=>
   (in_1 a2 (join_1x2 (a2r_1 a1) r))
   (in_2 a1 a2 r)
)))
;
;; For transClos
(assert
 (forall ( (r Rel2) (a1 Atom) (a2 Atom) )
  (=>
   (in_2 a1 a2 (transClos r))
   (exists ( (a3 Atom) )
    (and
     (in_2 a1 a3 r)
     (in_2 a3 a2 (transClos r))
)))))
(assert
 (forall ( (r Rel2) (a1 Atom) (a2 Atom) )
  (=>
   (in_2 a1 a2 (transClos r))
   (exists ( (a3 Atom) )
    (and
     (in_2 a3 a2 r)
     (in_2 a1 a3 (transClos r))
)))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Actual system specification
;;

;; abstract sig FSO 
(declare-fun FSO () Rel1)

;;sig File extends FSO
(declare-fun File () Rel1)

;; sig Dir extends FSO
(declare-fun Dir () Rel1)

;;sig Root extends Dir 
(declare-fun Root () Rel1)

;;parent: Parent -> lone Dir
(declare-fun parent () Rel2)

;; entries: Dir -> set FSO
(declare-fun entries () Rel2)

;; Additional type constraints
(assert
 (subSet_1 File FSO))

(assert
 (subSet_1 Dir FSO))

(assert
 (= (inter_1 File Dir) emptySet_1))

(assert
 (= (union_1 File Dir) FSO))

(assert
 (forall ( (a Atom) )
  (=> 
   (in_1 a FSO)
   (subSet_1 (join_1x2 (a2r_1 a) parent) Dir)
)))

(assert
 (forall ( (a Atom) )
  (=> 
   (in_1 a Dir)
   (subSet_1 (join_2x1 parent (a2r_1 a)) FSO)
)))

(assert
 (forall ((a Atom))
   (=>
    (in_1 a FSO)
    (lone_1 (join_1x2 (a2r_1 a) parent)))))


(assert
 (forall ( (a Atom) )
  (=> 
   (in_1 a Dir)
   (subSet_1 (join_1x2 (a2r_1 a) entries) FSO)
)))

(assert
 (forall ( (a Atom) )
  (=> 
   (in_1 a FSO)
   (subSet_1 (join_2x1 entries (a2r_1 a)) Dir)
)))

;; fact: one Root
(assert (one_1 Root))

;; fact: no Root.parent
(assert
 (= (join_1x2 Root parent) emptySet_1)
)

;; FSO = Root + Root.entries
(assert
 (forall ((a Atom))
  (=
   (in_1 a FSO)
   (or
    (in_1 a Root)
    (in_1 a (join_1x2 Root entries))
))))
;;; FSO = Root + Root.^entries
;(assert
; (forall ((a Atom))
;  (=
;   (in_1 a FSO)
;   (or
;    (in_1 a Root)
;    (in_1 a (join_1x2 Root (transClos entries)))
;))))


;; fact: all o: FSO, d: Dir | o in d.entries => o.parent = d
(assert
 (forall ((o Atom) (d Atom))
  (=>
   (and
    (in_1 o FSO)
    (in_1 d Dir)
   )
   (=>
    (in_1 o (join_1x2 (a2r_1 d) entries))
    (= (join_1x2 (a2r_1 o) parent) (a2r_1 d))
))))



;;assertion:  
;; oneParent {
;;	all o: FSO-Root | one o.parent}
;
(assert
 (not
  (forall ((o Atom))
   (=>
    (in_1 o (diff_1 FSO Root))
    (one_1 (join_1x2 (a2r_1 o) parent))
))))

(check-sat)
(get-model)

