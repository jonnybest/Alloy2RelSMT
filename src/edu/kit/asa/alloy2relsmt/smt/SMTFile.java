/**
 * Created on 07.02.2011
 */
package edu.kit.asa.alloy2relsmt.smt;

import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Collection;
import java.util.LinkedList;
import java.util.Queue;

import edu.kit.asa.alloy2relsmt.modules.KeYModule;
import edu.kit.asa.alloy2relsmt.util.Util;

/**
 * capturing output to an .SMT file
 * 
 * @author Ulrich Geilmann
 * @author Jonny
 * @author Aboubakr Achraf El Ghazi
 *
 */
public class SMTFile {

	private Collection<Term> asserts;
	
	private Collection<Term> assump;
	
	private Collection<Term> axioms;
	
	private Collection<Term> cmdasserts;
	
	private Collection<Term> concl;
	
	private Collection<String> funcs;	
	
	private Collection<String> includes;	
	
	private Collection<Term> lemmas;
	
	/** referred modules */
	public Queue<KeYModule> modules = KeYModule.NIL;
	
	private Collection<String> preds;
	
	private Collection<Taclet> rules;
	
	private Collection<String> sorts;
	
	private RelTheory theory;
	
	public SMTFile () {
		includes = new LinkedList<String>();
		sorts = new LinkedList<String>();
		funcs  =  new LinkedList<String>();
		preds  = new LinkedList<String>();
		rules  = new LinkedList<Taclet>();
		assump = new LinkedList<Term>();
		concl  = new LinkedList<Term>();
		asserts = new LinkedList<Term>();
		lemmas = new LinkedList<Term>();
		axioms = new LinkedList<Term>();
		cmdasserts = new LinkedList<Term>();
		setTheory(new RelTheory(this));
	}
	
	public RelTheory getTheory() {
		return theory;
	}

	public void setTheory(RelTheory theory) {
		this.theory = theory;
	}

	/** 
	 * Add an SMT assertion (assert expression)
	 * @param term 
	 * Expression to be asserted (declare in SMT syntax)
	 */
	public void addAssertion(Term term) {
		// we don't need to assert the expression "TRUE"
		if (!term.equals(Term.TRUE)) {
			asserts.add(term);
		}
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
	void addAxiom(Term term) {
		// we don't need to assert the expression "TRUE"
		if (!term.equals(Term.TRUE)) {
			axioms.add(term);
		}
	}
	/** 
	 * Add an SMT assertion (assert expression)
	 * @param term 
	 * Expression to be asserted (declare in SMT syntax)
	 */
	public void addCmdAssertion(Term term) {
		cmdasserts.add(term);		
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
	 * Add a function declaration (free text)
	 * @param fun
	 * declaration in SMT syntax, e.g. (declare-fun MyFun bool);
	 */
	public void addFunction (String fun) {
		funcs.add(fun);
	}
	/**
	 * Add a typed function declaration with parameters
	 * @return TRUE if successfully added, FALSE if omitted
	 * @throws ModelException 
	 */
	public boolean addFunction(String type, String name, String...params) {		
		String checkedParams = params == null ? "" : Util.join(params, " ");
		String fun = String.format("(declare-fun %s (%s) %s)", name, checkedParams, type);
		if(!funcs.contains(fun)){
			funcs.add(fun);
			return true;
		}
		else {
			return false;
		}
	}
	/**
	 * Add an include statement
	 * @param f
	 * the filename to include
	 */
	public void addInclude (String f) {
		includes.add(f);
	}
	/** 
	 * Add an SMT assertion as "lemma" (assert expression)
	 * @param term 
	 * Expression to be asserted (declare in SMT syntax)
	 * @comment 
	 * there is no difference in SMT between lemmas and normal assertions. 
	 * lemmas are added by the converter to help the SMT solver find a solution.
	 */
	public void addLemma(Term term){
		lemmas.add(term);
	}
	
	/**
	 * Add a predicate declaration
	 * @param pred
	 * declaration in smt syntax, e.g. (declare-fun p (Rel1) bool)
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
	 * Add a sort declaration (free text)
	 * @param sortDeclaration
	 * declaration in SMT/Z3 syntax, e.g. (declare-sort MySort);
	 * @return TRUE if successfully added, FALSE if omitted
	 */
	public boolean addSort (String sortDeclaration) {
		if(!sorts.contains(sortDeclaration)){
			sorts.add(sortDeclaration);
			return true;
		}
		else {
			return false;
		}
	}

	public void output(OutputStream os) {
		PrintWriter out = new PrintWriter(os);
		//printTheory(out);
//		out.println ("\\include \"theory/alloyHeader.key\";");
//		for (String s : includes)
//			out.println ("\\include \""+s+"\";");
//		for (KeYModule m: modules) {
//			out.println ("\\include \"theory/"+m.filename()+"\";");
//		}
		out.println ("(set-logic AUFLIA)\n(set-option :macro-finder true)");
		
		// Only for sanity checks
		out.println ("(set-option :produce-unsat-cores true)");
		
		//
		out.println (";; sorts");
		out.println (Util.join(sorts, "\n"));
		out.println (";; --end sorts\n");
		out.println (";; functions");
		out.println (Util.join(funcs, "\n"));
		out.println (";; --end functions\n");
		out.println (";; axioms");
		
		int i = 0;
		for (Term a : axioms) {
			out.println (String.format("(assert \n (! \n  %s \n %s \n ) \n )", a.toString(), ":named ax" + i++));
		}
		
		out.println (";; --end axioms\n");
		out.println (";; assertions");
		
		int j = 0;
		for (Term a : asserts) {
			out.println (String.format("(assert \n (! \n  %s \n %s \n ) \n )", a.toString(), ":named a" + j++));
		}
		
		out.println (";; --end assertions\n");
		out.println (";; command");
		
		int k = 0;
		for (Term a : cmdasserts) {
			out.println (String.format("(assert \n (! \n  %s \n %s \n ) \n )", a.toString(), ":named c" + k++));
		}
		
		out.println (";; --end command\n");
		out.println (";; lemmas");
		
		int l = 0;
		for (Term a : lemmas) {
			out.println (String.format("(assert\n (! \n  %s \n %s \n ) \n )", a.toString(), ":named l" + l++));
		}
		
		out.println (";; --end lemmas\n");
		
		out.println (";; -- key stuff for debugging --");
//		out.println ("\\rules {");
//		out.println (Util.join(rules, "\n"));
//		out.println ("}\n");
		out.println (";\\problem {(");
		out.print(";");
		out.println (Util.join(assump, " &\n"));
		out.println (";)-> (");
		out.print(";");
		out.println (Util.join(concl, " &\n"));
		out.println (";;\\predicates {");
		out.println (Util.join(preds, "\n"));
		out.println (";;}\n");
		out.println (";; -- END key stuff --");
		
		out.println ("(check-sat)");
		
		// Only for sanity checks
		out.println ("(get-unsat-core)");
		
		out.close();
	}
}