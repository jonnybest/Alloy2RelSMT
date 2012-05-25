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
	public void addFunction(String type, String name, String...params) {		
		String checkedParams = params == null ? "" : Util.join(params, " ");
		String fun = String.format("(declare-fun %s (%s) %s)", name, checkedParams, type);
		if(!funcs.contains(fun))
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
		//printTheory(out);
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
		out.close();
	}

	private void printTheory(PrintStream outStream) {		
		// TODO generate a proper theory from model
		// for the meantime, just print our static axioms from file
		outStream.println("(declare-sort Rel1 0)\n"
+"(declare-sort Rel2 2)\n"
+"(declare-sort Rel3 3)\n"
+"(declare-sort Atom 0)\n"
+"(declare-fun emptyset_1 () Rel1)\n"
+"(declare-fun in_1 (Atom Rel1) Bool)\n"
+"(declare-fun subset_1 (Rel1 Rel1) Bool)\n"
+"(declare-fun subset_2 (Rel1 Rel1) Bool)\n"
+"(declare-fun union_1 (Rel1 Rel1) Rel1)\n"
+"(declare-fun inter_1 (Rel1 Rel1) Rel1)\n"
+"(declare-fun diff_1 (Rel1 Rel1) Rel1)\n"
+"(declare-fun disjoint_1 (Rel1 Rel1) Bool)\n"
+"(declare-fun prod_1x1 (Rel1 Rel1) Rel2)\n"
+"(declare-fun a2r (Atom) Rel1)\n");		
	}

	/** adds declaration and theory for Atom */
	public void declareAtom() {
		// TODO Auto-generated method stub
		
	}
	
	/** adds a declaration and theory for disjoint 
	 * @param arity arity of the expression
	 */
	public void declareDisjoint(int arity) {
		// TODO Auto-generated method stub
		
	}

	/** adds a declaration and theory for subset and subrel 
	 * @param arity arity of the expression
	 */
	public void declareSubset(int i) {
		// TODO Auto-generated method stub
		
	}

	/** adds a declaration and theory for the converter function 
	 * @param arity arity of the expression
	 */
	public void declareA2r(int ar) {
		// TODO Auto-generated method stub
		
	}

	/** adds a declaration for in (no theory) 
	 * @param arity arity of the expression
	 * @throws ModelException couldn't declare this add this function because of "addFunction"
	 */
	public void declareIn(int ar)   {
		String[] strings = new String[ar];
		List<String> params = new LinkedList<String>();
		for(int i = 0; i < ar; i++)
			params.add("Atom");
		params.add("Rel" + ar);
		this.addFunction("Bool", "in_" + ar, params.toArray(strings));
	}

	/** adds a declaration and theory for "none" 
	 * @param arity arity of none
	 */
	public void declareNone(int ar) {
		// TODO Auto-generated method stub
		
	}

	public void declareProduct(int i, int j) {
		// TODO Auto-generated method stub
		
	}

	public void declareJoin(int lar, int rar) {
		this.addFunction("Bool", "join_" + lar + "x" + rar);
	}

	public void declareUnion(int i) {
		this.addFunction("Rel" + i, "union_" + i);	
	}

	public void declareOne(int i)  {		
		this.addFunction("Bool", "one_" + i, "Rel" + i);
	}

	public void declareLone(int i) {
		// TODO Auto-generated method stub
		
	}

	public void declareSome(int i) {
		// TODO Auto-generated method stub
		
	}

	// arity is always 2
	public void declareTranspose() {
		// TODO Auto-generated method stub
		
	}

	public void declareTransitiveClosure() {
		// TODO Auto-generated method stub
		
	}

	public void declareReflexiveTransitiveClosure() {
		// TODO Auto-generated method stub
		
	}

	public void declareCardinality(int arity) {
		// TODO Auto-generated method stub
		
	}

	/** Declares the domain restriction operator
	 * @param rar arity of the right-hand parameter
	 */
	public void declareDomainRestriction(int rar) {
		// left-hand arity is required to be 1 (type:set)
		// TODO Auto-generated method stub
		
	}

	public void declareDifference(int ar1) {
		// TODO Auto-generated method stub
		
	}

	public void declareOverride(int ar1) {
		// TODO Auto-generated method stub
		
	}

	public void declareIntersection(int ar1) {
		// TODO Auto-generated method stub
		
	}

	public void declareRangeRestriction(int ar1) {
		// TODO Auto-generated method stub
		
	}

	public void declareIdentity() {
		// TODO Auto-generated method stub
		
	}
}