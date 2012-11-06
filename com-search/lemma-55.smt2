; PREREQUISITES

; sig C {}
(C Rel1)
; sig B { S : C} 
(and 
	(B Rel1)
	(S Rel2)
	(subset_2 S (prod_1x1 B C))
)
; sig A { R : B }
(and 
	(A Rel1)
	(R Rel2)
	(subset_2 R (prod_1x1 A B))
)
; DEDUCTION1
; 45 all a: A| all b:a.R | b.S in a.R.S
(b Atom)
(a Atom)
(subset_1 
	(join_1x2 (a2r_1 b) S)
	(join_1x2 (a2r_1 a) (join_2x2 R S))
)

; DEDUCTION2
; 45 all a: A| all b:a.R | b.S in a.R.S
(b Atom)
(a Atom)
(subset_1 
	(join_1x2 (a2r_1 b) S)
	(join_1x2 (join_1x2 (a2r_1 a) R) S)
)

; IDEA
; a.(R.S) = (a.R).S
(=
	(join_1x2 A (join_2x2 R S))
	(join_1x2 (join_1x2 A R) S)
)