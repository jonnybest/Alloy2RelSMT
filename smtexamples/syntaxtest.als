sig A {}

sig B {
	fn : A -> lone B
}

fact {
	no (A ->fn->A)
}

assert notempty {
	some B
}

check notempty for 10
