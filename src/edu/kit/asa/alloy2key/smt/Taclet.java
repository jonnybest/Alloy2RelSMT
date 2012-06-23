/**
 * Created on 07.02.2011
 */
package edu.kit.asa.alloy2key.smt;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;

import edu.mit.csail.sdg.alloy4.Pair;

/**
 * Represent a KeY taclet
 * 
 * @author Ulrich Geilmann
 *
 */
public class Taclet {
	
	// the taclet's name
	protected String name;
	
	// the taclet's find sequent
	private List<Term> findAntecedent;
	private List<Term> findSuccedent;
	// the taclet's find term
	private Term findTerm;

	// the taclet's replacewith sequent
	private List<Term> replaceAntecedent;
	private List<Term> replaceSuccedent;
	// the taclet's replacewith term
	private Term replaceTerm;
	
	// term schema variable declarations
	private List<Pair<String,String>> schemaVars;
	
	private String heuristics;
	
	/**
	 * construct simple term rewrite taclet
	 * @param name
	 * the taclet's name
	 * @param find
	 * the \find term
	 * @param replacewith
	 * the \replacewith term
	 */
	public Taclet (String name, Term find, Term replacewith) {
		this(name);
		this.findTerm = find;
		this.replaceTerm = replacewith;
	}
	
	public Taclet (String name) {
		this.name = name;
		findAntecedent = null;
		findSuccedent = null;
		findTerm = null;
		replaceAntecedent = null;
		replaceSuccedent = null;
		replaceTerm = null;
		schemaVars = new LinkedList<Pair<String,String>>();
		heuristics = "simplify_enlarging";
	}
	
	/**
	 * Add a \schemaVar \term declaration
	 * @param s
	 * the sort of the schema variable
	 * @param n
	 * the name of the schema variable
	 */
	public void addSchemaVar (String s, String n) {
		schemaVars.add (new Pair<String,String>(s,n));
	}
	
	private List<Pair<String,String>> quantVars() {
		LinkedList<Pair<String,String>> quantVars = new LinkedList<Pair<String,String>>();
		if (findTerm != null)
			quantVars.addAll (findTerm.getQuantVars());
		if (replaceTerm != null)
			quantVars.addAll(replaceTerm.getQuantVars());
		if (findAntecedent != null)
			for (Term f : findAntecedent)
				quantVars.addAll (f.getQuantVars());
		if (findSuccedent != null)
			for (Term f : findSuccedent)
				quantVars.addAll (f.getQuantVars());
		if (replaceAntecedent != null)
			for (Term f : replaceAntecedent)
				quantVars.addAll (f.getQuantVars());
		if (replaceSuccedent != null)
			for (Term f : replaceSuccedent)
				quantVars.addAll (f.getQuantVars());
		return quantVars;
	}
	
	public String toString() {
		StringBuffer buf = new StringBuffer();
		
		List<Pair<String,String>> quantVars = quantVars();
		resolveQuantVarNameConflicts(quantVars);
		
		// write schema variables
		for (Pair<String,String> qv : quantVars) {
			buf.append("  \\schemaVar \\variables "+qv.a+" "+qv.b+";\n");
		}
		for (Pair<String,String> sv : schemaVars) {
			buf.append("  \\schemaVar \\term "+sv.a+" "+sv.b+";\n");
		}

		// find clause
		if (findTerm != null)
			buf.append(String.format("  \\find(%s)\n", findTerm.toStringTaclet()));
		if (findAntecedent != null && findSuccedent != null) {
			StringBuffer findSequent = new StringBuffer();
			boolean b = false;
			for (Term f: findAntecedent) {
				if (b) {
					findSequent.append (",");
					b = true;
				}
				findSequent.append (f.toStringTaclet());
			}
			b = false;
			findSequent.append (" ==> ");
			for (Term f : findSuccedent) {
				if (b) {
					findSequent.append(",");
					b = true;
				}
				findSequent.append (f.toStringTaclet());
			}
			buf.append (String.format("  \find(%s)\n", findSequent));
		}
		
		// variable conditions
		if (schemaVars.size() > 0 && quantVars.size() > 0) {
			buf.append ("  \\varcond (");
			boolean b = false;
			for (Pair<String,String> qv : quantVars) {
				if (b) {
					buf.append(",");
				}
				buf.append ("\\notFreeIn("+qv.b);
				for (Pair<String,String> sv : schemaVars) {
					buf.append(","+sv.b);
				}
				buf.append(")");
				b = true;
			}
			buf.append (")\n");
		}

		// replacewith clause
		if (replaceTerm != null)
			buf.append(String.format("  \\replacewith(%s)\n", replaceTerm.toStringTaclet()));
		if (replaceAntecedent != null && replaceSuccedent != null) {
			StringBuffer replaceSequent = new StringBuffer();
			boolean b = false;
			for (Term f: replaceAntecedent) {
				if (b) {
					replaceSequent.append (",");
					b = true;
				}
				replaceSequent.append (f.toStringTaclet());
			}
			b = false;
			replaceSequent.append (" ==> ");
			for (Term f : replaceSuccedent) {
				if (b) {
					replaceSequent.append(",");
					b = true;
				}
				replaceSequent.append (f.toStringTaclet());
			}
			buf.append (String.format("  \replacewith(%s)\n", replaceSequent));
		}
		if (heuristics != null)
			buf.append(String.format("  \\heuristics(%s)\n",heuristics));
		return String.format ("%s {\n%s};",name,buf);
	}

	public void setReplacewith(Term replacewith) {
		this.replaceTerm = replacewith;
	}

	public void setFind(Term find) {
		this.findTerm = find;
	}
	
	public void setHeuristics(String heuristics) {
		this.heuristics = heuristics;
	}
	
	/**
	 * a quantification variable of the same name
	 * might occur more than once in the formula.
	 */
	private void resolveQuantVarNameConflicts(List<Pair<String,String>> quantVars) {
		HashMap<String,String> hash = new HashMap<String,String>();
		int i = 0;
		while (i < quantVars.size()) {
			Pair<String,String> sv = quantVars.get(i);
			if (hash.containsKey(sv.b)) {
				// collision
				if (hash.get(sv.b).equals(sv.a)) {
					// harmless collision
					quantVars.remove(i);
				} else {
					throw new RuntimeException ("Usage of the same quantification variable " +
												"with different multiplicities is not (yet)" +
												"supported!");
				}
			} else {
				hash.put(sv.b, sv.a);
				++i;
			}
		}
	}
	
	/**
	 * @return a special taclet that introduces ==> disj(s1,s2) to
	 * the sequent if s1 can be found in the sequent. Thus, if s1 is
	 * never used, the disjointness does not appear in the sequent.
	 * This is especially desired for the Int signature.
	 */
	public static Taclet disjointTaclet(String s1, String s2) {
		return new DisjTaclet(s1,s2);
	}
	
	private static class DisjTaclet extends Taclet {
		private String s1,s2;
		private DisjTaclet (String s1, String s2) {
			super ("disj_"+s1+"_"+s2);
			this.s1 = s1; this.s2 = s2;
		}
		/** {@inheritDoc} */
		@Override
		public String toString() {
			return name+"{\n"
				+ "    \\find ("+s1+")\n"
				+ "    \\add (disj("+s1+","+s2+") ==>)\n"
				+ "    \\heuristics (implications4)\n"
				+ "};";
		}
		
	}
	
}
