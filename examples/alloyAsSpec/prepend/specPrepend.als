/*
 * Specificaction for LL.java
 *
 * Challenges:
 * - in Alloy methodology, next is a partial function and the tail of
 *   the list ist not in its domain. In contrast to that, the implementation
 *   terminates the list with null
 * - the implementation of remove requires acyclicity.
 *   
 */

sig Entry extends Entry' {
	next: lone Entry,
	data: Int
}
sig Entry' {
	next': lone Entry',
	data': Int
}

sig LL extends LL' {
	head: lone Entry
}
sig LL' {
	head': lone Entry'
}

pred prepend[ll:LL, d: Int] {
	not self.head.data = d
   implies
	ll.head'.*next'.data' = ll.head.*next.data + d
}

run {
	some LL
}
