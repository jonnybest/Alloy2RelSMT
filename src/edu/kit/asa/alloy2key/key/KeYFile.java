/**
 * Created on 07.02.2011
 */
package edu.kit.asa.alloy2key.key;

import java.io.OutputStream;
import java.io.PrintStream;
import java.util.Collection;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

import edu.kit.asa.alloy2key.modules.KeYModule;
import edu.kit.asa.alloy2key.util.Util;

/**
 * capturing output to a .key file
 * 
 * @author Ulrich Geilmann
 *
 */
public class KeYFile {



	public KeYFile () {
		includes = new LinkedList<String>();
		funcs  =  new LinkedList<String>();
		preds  = new LinkedList<String>();
		rules  = new LinkedList<Taclet>();
		assump = new LinkedList<Term>();
		concl  = new LinkedList<Term>();
		asserts = new LinkedList<Term>();
	}
	
	/** referred modules */
	public Queue<KeYModule> modules = KeYModule.NIL;
	
	/**
	 * Add a function declaration (free text)
	 * @param fun
	 * declaration in KeY syntax, e.g. Rel1 f;
	 */
	public void addFunction (String fun) {
		funcs.add(fun);
	}
	
	/**
	 * Add a typed function declaration with parameters
	 * @param Type
	 * @param Name
	 * @param Parameter-String
	 * @throws ModelException 
	 */
	public void addFunction(String type, String name, List<String> params) throws ModelException {
		String checkedParams = params == null ? "" : Util.join(params, " ");
		String fun = String.format("(declare-fun %s (%s) %s)", name, checkedParams, type);
		funcs.add(fun);
	}
	
	/** 
	 * Add an SMT assertion (assert expression)
	 * @param term 
	 * Expression to be asserted (declare in SMT syntax)
	 */
	public void addAssertion(Term term) {
		asserts.add(term);
	}	
	
	/**
	 * Add a predicate declaration
	 * @param pred
	 * declaration in KeY syntax, e.g. p(Rel1);
	 */
	public void addPredicate (String pred) {
		preds.add(pred);
	}
	
	/**
	 * Add a rule definition
	 * @param rule
	 * the taclet object
	 */
	public void addRule (Taclet rule) {
		rules.add(rule);
	}
	
	/**
	 * Add an assumption
	 * @param f
	 * formula in KeY syntax to be added as assumption
	 */
	public void addAssumption (Term f) {
		if (f != Term.TRUE)
			assump.add(f);
	}
	
	/**
	 * Add a conclusion
	 * @param f
	 * formula in KeY syntax to be added as conclusion
	 */
	public void addConclusion (Term f) {
		concl.add(f);
	}
	
	/**
	 * Add an include statement
	 * @param f
	 * the filename to include
	 */
	public void addInclude (String f) {
		includes.add(f);
	}
	
	private Collection<Term> asserts;
	private Collection<String> includes;
	private Collection<String> funcs;
	private Collection<String> preds;
	private Collection<Taclet> rules;
	private Collection<Term> assump;
	private Collection<Term> concl;
	
	public void output(OutputStream os) {
		PrintStream out = new PrintStream(os);
		printTheory(out);
//		out.println ("\\include \"theory/alloyHeader.key\";");
//		for (String s : includes)
//			out.println ("\\include \""+s+"\";");
//		for (KeYModule m: modules) {
//			out.println ("\\include \"theory/"+m.filename()+"\";");
//		}
		out.println (";; functions");
		out.println (Util.join(funcs, "\n"));
		out.println (";; --end functions\n");
		out.println (";; assertions");
		for (Term a : asserts) {
			out.println (String.format("(assert\n  %s\n)", a.toString()));
		}
		out.println (";; --end assertions\n");
		
		out.println (";; -- key stuff for debugging --");
		out.println ("\\rules {");
		out.println (Util.join(rules, "\n"));
		out.println ("}\n");
		out.println ("\\problem {(");
		out.println (Util.join(assump, " &\n"));
		out.println (")-> (");
		out.println (Util.join(concl, " &\n"));
		out.println (";;\\predicates {");
		out.println (Util.join(preds, "\n"));
		out.println (";;}\n");
		out.println (";; -- END key stuff --");
		
		out.println ("(check-sat)");
		out.close();
	}

	private void printTheory(PrintStream outStream) {
		// TODO generate a proper theory from model
		// for the meantime, just print our static axioms from file
		outStream.println("(declare-sort Rel1 0)"
+"(declare-sort AbstractRel2 2)"
+"(declare-sort AbstractRel3 3)"
+"(define-sort Rel2 () (AbstractRel2 Rel1 Rel1))"
+"(define-sort Rel3 () (AbstractRel3 Rel1 Rel1 Rel1))"
+"(declare-sort Atom 0)"
+"(declare-fun emptyset_1 () Rel1)"
+"(declare-fun in_1 (Atom Rel1) Bool)"
+"(declare-fun subset_1 (Rel1 Rel1) Bool)"
+"(declare-fun union_1 (Rel1 Rel1) Rel1)"
+"(declare-fun inter_1 (Rel1 Rel1) Rel1)"
+"(declare-fun diff_1 (Rel1 Rel1) Rel1)");		
	}
}