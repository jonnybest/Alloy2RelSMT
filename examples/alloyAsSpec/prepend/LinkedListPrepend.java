package examples.alloyAsSpec.prepend;

/*
 * Very simply implementation of a null-terminated linked list.
 */

class LL {
    private Entry head;

    void prepend(int d) {
	Entry oldHead = head;
	head = new Entry();
	head.next = oldHead;
	head.data = d;
    }
}

class Entry {
    Entry next;
    int data;
}

