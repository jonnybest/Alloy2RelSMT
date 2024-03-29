/**
 * Created on 26.03.2011
 */
package edu.kit.asa.alloy2relsmt.modules;

import java.io.File;
import java.io.IOException;
import java.util.Comparator;
import java.util.List;
import java.util.PriorityQueue;
import java.util.Queue;
import java.util.Set;

import edu.kit.asa.alloy2relsmt.Identifiers;
import edu.mit.csail.sdg.alloy4.Err;
import edu.mit.csail.sdg.alloy4.ast.Sig;
import edu.mit.csail.sdg.alloy4.parser.ParsedModule;

/**
 * A module to be included
 * 
 * @author Ulrich Geilmann
 *
 */
public abstract class KeYModule {
	
	/** determine the order in which the modules have to be included */
	protected int order = 0;
	protected boolean isOrdering = false;
	
	/**
	 * Indicates whether this module is an instance of util/ordering (or not).
	 * @return True if util/ordering. Else false.
	 */
	public boolean isOrdering() {
		return isOrdering;
	}

	/**
	 * create an instance
	 * @param mod
	 * the Alloy module
	 * @param insts
	 * the instantiations
	 * @return
	 * an instance of KeYModule or null, if the module does not
	 * have a built-in translation
	 */
	public static KeYModule createFor (ParsedModule mod, List<Sig> insts, Identifiers ids) {
		if (mod.getModelName().equals("util/ordering")) {
			if (insts.size() < 1) {
				throw new RuntimeException ("No instantiation for ordering module");
			}
			KeYModule m = new Ordering(mod, insts.get(0), ids);
			m.isOrdering = true;
			return m;
		}
		return null;
	}

	/**
	 * Write out the KeY module
	 * @param dir
	 * the directory to write to
	 * @throws Err
	 */
	public abstract void buildModule (File dir) throws IOException;
	
	/**
	 * suggest a filename to store the module in
	 * @return
	 */
	public abstract String filename();
	
	/**
	 * @return
	 * all Alloy entities defined in this module, i.e.
	 * the sigs, fields, facts, predicates and functions
	 */
	public abstract Set<Object> defined();

	public static final Queue<KeYModule> NIL = new PriorityQueue<KeYModule>(5,Compare.INSTANCE);
	
	private static class Compare implements Comparator<KeYModule> {
		private static final Compare INSTANCE = new Compare();

		/** {@inheritDoc} */
		public int compare(KeYModule o1, KeYModule o2) {
			if (o1.order < o2.order)
				return -1;
			if (o1.order > o2.order)
				return 1;
			return 0;
		}
	}
	
}
