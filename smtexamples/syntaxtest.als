sig A {}

sig B {
	fn : A -> lone B,
	ins : B
}

fact {
	no (A ->fn->A)
	some ins & ins
}

assert notempty {
	some B
}

check notempty for 10
