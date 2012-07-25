module tour/addressBook1h ------- Page 14..16

sig Name, Addr { }

sig Book {
	addr: Name -> lone Addr
}

pred add [b, b': Book, n: Name, a: Addr] {
	b'.addr = b.addr + n->a
}

pred del [b, b': Book, n: Name] {
	b'.addr = b.addr - n->Addr
}

assert delUndoesAdd {
	all b, b', b'': Book, n: Name, a: Addr |
		no n.(b.addr) and add [b, b', n, a] and del [b', b'', n]
		implies
		b.addr = b''.addr
}


// This command should not find any counterexample.
check delUndoesAdd for 20 but 3 Book
