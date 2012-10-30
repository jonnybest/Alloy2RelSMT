module chapter4/filesystem ----- The model from page 125

abstract sig Object {}

sig Dir extends Object {contents: set Object}

one sig Root extends Dir { }

sig File extends Object {}

fact {
	Object in Root.*contents
	}

assert FileInDir {
	all f: File | some contents.f
	}
//check FileInDir // This assertion is valid
