///**
// * Created on 07.02.2011
// */
//package edu.kit.asa.alloy2key;
//
//import java.util.Collection;
//import java.util.HashMap;
//import java.util.HashSet;
//import java.util.LinkedList;
//import java.util.List;
//import java.util.Map;
//import java.util.Set;
//import java.util.Stack;
//import java.util.Vector;
//import java.util.regex.Pattern;
//
//import edu.kit.asa.alloy2key.key.Formula;
//import edu.kit.asa.alloy2key.key.KeYFile;
//import edu.kit.asa.alloy2key.key.Taclet;
//import edu.kit.asa.alloy2key.key.Term;
//import edu.kit.asa.alloy2key.modules.Ordering;
//import edu.mit.csail.sdg.alloy4.Err;
//import edu.mit.csail.sdg.alloy4.ErrorFatal;
//import edu.mit.csail.sdg.alloy4.Pair;
//import edu.mit.csail.sdg.alloy4.SafeList;
//import edu.mit.csail.sdg.alloy4.ast.Command;
//import edu.mit.csail.sdg.alloy4.ast.Decl;
//import edu.mit.csail.sdg.alloy4.ast.Expr;
//import edu.mit.csail.sdg.alloy4.ast.ExprBinary;
//import edu.mit.csail.sdg.alloy4.ast.ExprCall;
//import edu.mit.csail.sdg.alloy4.ast.ExprConstant;
//import edu.mit.csail.sdg.alloy4.ast.ExprHasName;
//import edu.mit.csail.sdg.alloy4.ast.ExprITE;
//import edu.mit.csail.sdg.alloy4.ast.ExprLet;
//import edu.mit.csail.sdg.alloy4.ast.ExprList;
//import edu.mit.csail.sdg.alloy4.ast.ExprQt;
//import edu.mit.csail.sdg.alloy4.ast.ExprUnary;
//import edu.mit.csail.sdg.alloy4.ast.ExprVar;
//import edu.mit.csail.sdg.alloy4.ast.Func;
//import edu.mit.csail.sdg.alloy4.ast.Module;
//import edu.mit.csail.sdg.alloy4.ast.Sig;
//import edu.mit.csail.sdg.alloy4.ast.Sig.Field;
//import edu.mit.csail.sdg.alloy4.ast.Sig.PrimSig;
//import edu.mit.csail.sdg.alloy4.ast.Sig.SubsetSig;
//import edu.mit.csail.sdg.alloy4.parser.ParsedModule;
//import edu.mit.csail.sdg.alloy4.parser.ParsedModule.Open;
//
///**
// * TODO support multiple variable bindings for one/lone quantifiers
// * TODO support "disjoint" declaration for quantification
// * 
// * Language features to be added
// * - integers, cardinality and all related operators
// * - modules (via open)
// * - private
// * 
// * Not supported language features:
// * - disj keyword on right-hand side of declaration (see Decl.disjoint2)
// * 
// * @author Ulrich Geilmann
// *
// */
////TODO get rid of namespace by using idMap for this purpose?
//public class Stage2 {
//	
//	// reserved identifiers in KeY
//	// TODO make more complete.
//	private static final Set<String> reserved = new HashSet<String>() {{
//		this.add ("add");
//	}};
//	
//	public Stage2 (ParsedModule m) {
//		this.mod = m;
//		this.idMap = new HashMap<Object,String>();
//	}
//
//	// the Alloy model to translate
//	private ParsedModule mod;
//	
//	/* mapping Alloy entities to the identifier of
//	 * their KeY counterpart.
//	 * Instances of Sig and Func are directly used
//	 * as keys. For ExprHasName instances, a String
//	 * is generated that is used as key.
//	 */
//	private Map<Object,String> idMap;
//	private Stack<Object> tmpIds;
//
//	/**
//	 * get the KeY identifier for an Alloy entity
//	 * @return
//	 * the KeY identifier associated with the Alloy entity
//	 * @throws Err
//	 */
//	private String id(Expr e) throws Err {
//		if (e instanceof Sig) {
//			return idMap.get(e);
//		}
//		if (e instanceof ExprHasName) {
//			if (((ExprHasName)e).label.equals("this"))
//				return "this";
//			return idMap.get(uniqueRepresentation((ExprHasName)e));
//		}
//		throw new ErrorFatal ("");
//	}
//	private String id(Func f) {
//		return idMap.get(f);
//	}
//	
//	/**
//	 * create an identifier for a temporary Alloy entity. The
//	 * identifier is added to <code>idMap</code> and can be
//	 * deleted from this map using the <code>popIdentifier</code> methods.
//	 * @return
//	 * the created KeY identifier
//	 */
//	private String temporaryIdentifier (ExprHasName e) throws Err {
//		String id = createIdentifier(e.label);
//		String k = uniqueRepresentation(e);
//		if (idMap.put(k, id) != null) {
//			throw new ErrorFatal ("Ambiguous named expression: "+e);
//		}
//		tmpIds.push(k);
//		return id;
//	}
//	
//	/**
//	 * remove the last (temporarily) added identifier
//	 * from <code>idMap</code>
//	 */
//	private void popIdentifier() {
//		idMap.remove(tmpIds.pop());
//	}
//	/**
//	 * remove the last <code>n</code> (temporarily) added
//	 * identifier from <code>idMap</code>
//	 */
//	private void popIdentifier(int n) {
//		for (int i = 0; i < n; ++i)
//			popIdentifier();
//	}
//	
//	/**
//	 * create a KeY identifier which is not yet present in
//	 * <code>idMap</code>
//	 * @param id
//	 * the Alloy identifier
//	 * @return
//	 * the created KeY identifier
//	 */
//	private String createIdentifier (String id) {
//		id = removeThisPrefix(id);
//		// identifiers x1, x2 etc. are reserved
//		Pattern pat = Pattern.compile ("^x\\d+$");
//		if (pat.matcher(id).matches())
//			id = id + "_";
//		// TODO single quote is probably not the only character allowed in Alloy identifiers but prohibited in KeY...
//		id = id.replace('\'', '_');
//		id = id.replace("\"", "__");
//		// append a number until it's unambiguous
//		int i = 0;
//		String kid = id;
//		while (idMap.containsValue(kid))
//			kid = id+(++i);
//		while (reserved.contains(kid))
//			kid = id+(++i);
//		return kid;
//	}
//	
//	/**
//	 * create a new identifier that is currently not present,
//	 * and not used within a given formula.
//	 * @param base
//	 * the new identifier will be based on this string
//	 * @param f
//	 * the new identifier is guaranteed to not occur in f
//	 * @return
//	 * the new identifier.
//	 */
//	private String newFreeIdentifier (String base, Formula f) {
//		String id = createIdentifier(base);
//		while (f.occurs(id))
//			id = createIdentifier(id);
//		return id;
//	}
//	
//	/**
//	 * Create a KeY identifier for all the signatures, fields,
//	 * predicates and functions in the Alloy model. The created
//	 * identifiers are stored in <code>idMap</code>.
//	 */
//	private void createStaticIdentifiers() {
//		tmpIds = new Stack<Object>();
//		// signatures and fields
//		for (Sig s : mod.getAllSigs()) {
//			idMap.put(s, createIdentifier(s.toString()));
//			for (Field f : s.getFields()) {
//				idMap.put(uniqueRepresentation(f),createIdentifier(f.label));
//			}
//		}
//		// functions/predicates
//		for (Func f : mod.getAllFunc()) {
//			idMap.put(f,createIdentifier(f.label));
//		}
//	}
//	
//	/**
//	 * @return
//	 * a (hopefully) unique String representing the expression,
//	 * that can be used as a key in <code>idMap</code>
//	 */
//	private String uniqueRepresentation (ExprHasName e) {
//		if (e instanceof Field) {
//			Field f = (Field)e;
//			return "Field$"+f.label+"$"+f.sig.label+"$"+arity(f);
//		}
//		if (e instanceof ExprVar) {
//			return "Var$"+e.label+"$"+arity(e);
//		}
//		System.err.println ("There seems to be some case missing.");
//		return e.label;
//	}
//	
//
//	/**
//	 * Handle all module imports
//	 * @param key
//	 * the results are stored here
//	 * @return
//	 * a set containing the signatures names
//	 * that have already been declared.
//	 */
//	private HashSet<String> translateModuleImports(KeYFile key) throws Err {
//		HashSet<String> declared = new HashSet<String>();
//		for (Open o : mod.getOpens()) {
//			Module m = o.getRealModule();
//			if (m.getModelName().equals("util/ordering")) {
//				if (o.args == null || o.args.size() < 1)
//					throw new ErrorFatal ("Opening module ordering requires an instantiation!");
//					
//				String inst = removeThisPrefix(o.args.get(0));
//				//TODO check no-alias case
//				for (Func f : m.getAllFunc()) {
//					String label = f.label.substring(o.alias.length()+1);
//					idMap.put(f,label+inst);
//				}
//				key.modules.add(new Ordering(o.args));
//				declared.add(inst);
//			}
//		}
//		return declared;
//	}
//	
//	/**
//	 * Translate a specification
//	 * @param m
//	 * specification to translate, has to be in intermediate representation
//	 * @return
//	 * KeYFile object containing the translation
//	 */
//	public KeYFile translate () throws Err {
//		KeYFile key = new KeYFile();
//		HashSet<String> declared = translateModuleImports (key);
//		createStaticIdentifiers();
//		HashSet<String> namespace = new HashSet<String>();
//		namespace.add("this");
//		
//		// translate signatures
//		SafeList<Sig> sigs = mod.getAllSigs();
//		for (Sig s : sigs) {
//			if (!declared.contains(s.label) && !declared.contains(removeThisPrefix(s.label)))
//				key.addFunction(String.format("Rel1 %s;",id(s)));
//			
//			// we have a PrimSig
//			if (s.isSubsig != null) {
//				if (!(s instanceof PrimSig)) throw new ErrorFatal("");
//				PrimSig ps = (PrimSig)s;
//				
//				// sig is abstract
//				if (ps.isAbstract != null) {
//					Formula disj = Formula.FALSE;
//					for (PrimSig sub : ps.children())
//						disj = disj.or(Formula.binaryPred("in", "this", id(sub)));
//					key.addAssumption (Formula.forallWithGuard("Atom", "this",
//							Formula.binaryPred("in", "this", id(ps)), disj));
//				}
//				
//				// all subsignatures are disjoint
//				for (int i = 0; i < ps.children().size(); ++i)
//					for (int j = i+1; j < ps.children().size(); ++j)
//						key.addAssumption (Formula.binaryPred("disj",
//								id(ps.children().get(i)),
//								id(ps.children().get(j))));
//				
//				// sig extends parent
//				if (ps.parent != null && ps.parent != Sig.UNIV) {
//					key.addAssumption (Formula.binaryPred("subrel",
//							id(ps), id(ps.parent)));
//				}
//			
//			// we have a SubsetSig
//			} else {
//				if (s.isSubset == null || !(s instanceof SubsetSig)) throw new ErrorFatal("");
//				SubsetSig ss = (SubsetSig)s;
//				if (ss.parents.size() == 1)
//					key.addAssumption(Formula.binaryPred("subrel",
//							id(ss), id(ss.parents.get(0))));
//				else {
//					Formula disj = Formula.FALSE;
//					for (Sig p : ss.parents)
//						disj = disj.or(Formula.binaryPred("in", "this", id(p)));
//					key.addAssumption (Formula.forallWithGuard("Atom", "this",
//							Formula.binaryPred("in", "this", id(ss)), disj));		
//				}
//			}
//
//			// sig's multiplicity is one
//			if (s.isOne != null)
//				key.addAssumption(Formula.unaryPred("one", id(s)));
//			
//			// sig's multiplicity is lone
//			if (s.isLone != null)
//				key.addAssumption(Formula.unaryPred("lone", id(s)));
//			
//			// sig's multiplicity is some
//			if (s.isSome != null)
//				key.addAssumption(Formula.unaryPred("some", id(s)));
//			
//			// process field declarations
//			for (Decl decl : s.getFieldDecls()) {
//				for (ExprHasName f : decl.names) {
//					int arity = arity(decl.expr)+1;
//					key.addFunction(String.format("Rel%d %s;",arity,id(f)));
//					Collection<Formula> cnstrs = generateMultConstr(Term.binaryFunc("join1x"+arity, Term.sin("this"), id(f)),
//							decl.expr, namespace, null);
//					for (Formula cnstr : cnstrs) {
//						key.addAssumption(cnstr.forallWithGuard("Atom", "this",
//								Formula.binaryPred("in", "this", id(s))));
//					}
//
//					// translate typing expression
//					Term keyExpr = translateExpression(decl.expr,namespace, null);
//					key.addAssumption(Formula.binaryPred("subrel", Term.binaryFunc("join1x"+arity, Term.sin("this"), id(f)),
//							keyExpr).forallWithGuard("Atom", "this", Formula.binaryPred("in", "this", id(s))));
//				}
//				
//				// might be a "disjoint" declaration
//				if (decl.disjoint != null) {
//					int arity = arity(decl.expr)+1;
//					for (int i = 0; i < decl.names.size(); ++i)
//						for (int j = i+1; j < decl.names.size(); ++j) {
//							Term t1 = Term.binaryFunc("join1x"+arity, Term.sin("this"), id(decl.names.get(i)));
//							Term t2 = Term.binaryFunc("join1x"+arity, Term.sin("this"), id(decl.names.get(j)));
//							key.addAssumption(Formula.binaryPred("disj", t1, t2).forallWithGuard("Atom", "this", 
//									Formula.binaryPred("in", "this", id(s))));
//						}
//				}
//			}
//			
//			// translate signature facts
//			for (Expr c : s.getFacts()) {
//				key.addAssumption(translateConstraint(c, namespace, null).forallWithGuard("Atom", "this",
//						Formula.binaryPred("in", "this", id(s))));
//			}
//		}
//		
//		// disjointness of top-level signatures
//		for (int i = 0; i < sigs.size(); ++i) {
//			if (sigs.get(i).isTopLevel()) {
//				for (int j = i+1; j < sigs.size(); ++j) {
//					if (sigs.get(j).isTopLevel()) {
//						key.addAssumption(Formula.binaryPred("disj", id(sigs.get(i)), id(sigs.get(j))));
//					}
//				}
//			}
//		}
//		//TODO top-level signatures partition the universe
//		
//		// translate facts
//		for (Pair<String,Expr> fact : mod.getAllFacts()) {
//			if (fact.a != null && fact.a.length() > 0) {
//				//TODO add rule?? if so, need a unique id
//				key.addAssumption(translateConstraint(fact.b,null,null));
//			} else {
//				key.addAssumption(translateConstraint(fact.b,null,null));
//			}
//		}
//		
//		// translate assertions
////		for (Pair<String,Expr> asrtn : mod.getAllAssertions()) {
////			if (asrtn.a == null || asrtn.a.length() == 0) continue;
////			Taclet tac = new Taclet (asrtn.a+"_def",
////					asrtn.a,
////					translateConstraint(asrtn.b,null));
////			key.addPredicate (asrtn.a+";");
////			key.addRule(tac);
////		}
//		
//		// translate check cmd
//		for (Command cmd : mod.getAllCommands()) {
//			if (!cmd.check) continue;
//			key.addConclusion(translateConstraint(cmd.formula.not(),null,null));
//		}
//		
//		// translate predicates and functions
//		for (Func fun : mod.getAllFunc()) {
//			Taclet tac = new Taclet(id(fun)+"_def");
//			Vector<Term> params = new Vector<Term>(fun.params().size());
//			StringBuffer paramDecl = new StringBuffer();
//			for (ExprVar v : fun.params()) {
//				temporaryIdentifier(v);
//				tac.addSchemaVar("Rel"+arity(v), id(v));
//				params.add (Term.name(id(v)));
//				if (paramDecl.length() > 0)
//					paramDecl.append(",");
//				paramDecl.append("Rel"+arity(v));
//			}
//			if (fun.isPred) {
//				key.addPredicate(String.format("%s%s;",id(fun),
//						(fun.count() == 0) ? "" : ("("+paramDecl+")")));
//				tac.setFind(Formula.pred(id(fun), params));
//				tac.setReplacewith(translateConstraint(fun.getBody(),null,null));
//			} else {
//				key.addFunction(String.format("Rel%d %s%s;",arity(fun.returnDecl),id(fun),
//						(fun.count() == 0) ? "" : ("("+paramDecl+")")));
//				tac.setFind(Term.func(id(fun), params));
//				tac.setReplacewith(translateExpression(fun.getBody(),null,null));
//			}
//			popIdentifier(params.size());
//			key.addRule (tac);
//		}
//		return key;
//	}
//	
//	/**
//	 * remove the prefix {@literal "this/"} from <code>s</code>, if present
//	 */
//	public static String removeThisPrefix (String s) {
//		if (s.startsWith("this/"))
//			return s.substring(5);
//		return s;
//	}
//	
//	/**
//	 * @param e
//	 * Alloy expression
//	 * @return
//	 * arity of the expression
//	 */
//	private static int arity (Expr e) {
//		return e.type().arity();
//	}
//	
//	/**
//	 * Get the multiplicity of a unary expression
//	 * @param e
//	 * the expression
//	 * @return
//	 * the annotated multiplicity, if any, ONE otherwise
//	 */
//	private static Mult mult (Expr e) throws Err {
//		if (e.mult == 0) return Mult.ONE;
//		if (!(e instanceof ExprUnary)) throw new ErrorFatal ("");
//		ExprUnary ue = (ExprUnary)e;
//		switch (ue.op) {
//			case ONEOF:
//				return Mult.ONE;
//			case SOMEOF:
//				return Mult.SOME;
//			case SETOF:
//				return Mult.SET;
//			case LONEOF:
//				return Mult.LONE;
//			case NOOP:
//				return mult (ue.sub);
//			default:
//				throw new ErrorFatal ("");
//		}
//	}
//	
//	/**
//	 * translate an Alloy expression to a KeY term
//	 * @param e
//	 * the Alloy expression
//	 * @param namespace
//	 * set containing all names of singleton identifiers,
//	 * e.g. quantification variables. namespace may be null
//	 * @param letBindings
//	 * mapping variables introduced by let to their bound.
//	 * can be null.
//	 * @return
//	 * the resulting KeY term
//	 */
//	private Term translateExpression (Expr e, Set<String> namespace, Map<ExprHasName,Term> letBindings) throws Err {
//		if (namespace == null) namespace = new HashSet<String>();
//		if (letBindings == null) letBindings = new HashMap<ExprHasName,Term>();
//		if (e instanceof Sig)                                        // signature
//			return Term.name(id(e));
//		if (e instanceof ExprHasName) {                              // identifier
//			String n = id(e);
//			if (namespace.contains(n)) 
//				return Term.sin(n);
//			if (letBindings.containsKey(e))
//				return letBindings.get(e);
//			return Term.name(n);
//		}
//		if (e == ExprConstant.IDEN)                                  // iden 
//			return Term.constFunc("iden");
//		if (e instanceof ExprUnary) {
//			ExprUnary ue = (ExprUnary)e;
//			if (ue.sub == null) throw new ErrorFatal("");
//			Term e_ = translateExpression(ue.sub, namespace, letBindings);
//			switch (ue.op) {
//			case TRANSPOSE:                                          // ~e
//				return Term.unaryFunc("transp", e_);
//			case CLOSURE:                                            // ^e
//				return Term.unaryFunc("transClos", e_);
//			case RCLOSURE:                                           // *e
//				return Term.unaryFunc("reflTransClos", e_);
//			default:
//				return e_;
//			}
//		}
//		if (e instanceof ExprBinary) {
//			ExprBinary be = (ExprBinary)e;
//			Term e1 = translateExpression (be.left, namespace, letBindings);
//			Term e2 = translateExpression (be.right, namespace, letBindings);
//			int ar1 = arity(be.left);
//			int ar2 = arity(be.right);
//			switch (be.op) {
//			case JOIN:                                               // e1.e2
//				return Term.binaryFunc("join"+ar1+"x"+ar2, e1, e2);
//			case DOMAIN:                                             // e1 <: e2
//				return Term.binaryFunc("domRestr"+ar2, e1, e2);
//			case RANGE:                                              // e1 :> e2
//				return Term.binaryFunc("rangeRestr"+ar1, e1, e2);
//			case INTERSECT:                                          // e1 & e2
//				return Term.binaryFunc("inter"+ar1, e1, e2);
//			case PLUSPLUS:                                           // e1 ++ e2
//				return Term.binaryFunc("overr"+ar1, e1, e2);
//			case PLUS:                                               // e1 + e2
//				return Term.binaryFunc("union"+ar1, e1, e2);
//			case MINUS:                                              // e1 - e2
//				return Term.binaryFunc("diff"+ar1, e1, e2);
//			case ARROW:                                              // e1 -> e2
//			case ANY_ARROW_SOME:
//			case ANY_ARROW_ONE:
//			case ANY_ARROW_LONE:
//			case SOME_ARROW_ANY:
//			case SOME_ARROW_SOME:
//			case SOME_ARROW_ONE:
//			case SOME_ARROW_LONE:
//			case ONE_ARROW_ANY:
//			case ONE_ARROW_SOME:
//			case ONE_ARROW_ONE:
//			case ONE_ARROW_LONE:
//			case LONE_ARROW_ANY:
//			case LONE_ARROW_SOME:
//			case LONE_ARROW_ONE:
//			case LONE_ARROW_LONE:
//				return Term.binaryFunc("prod"+ar1+"x"+ar2, e1, e2);
//			case ISSEQ_ARROW_LONE: //TODO
//			default:
//				throw new ErrorFatal ("Unexpected operator: "+be.op+" in expression "+e);
//			}
//		}
//		if (e instanceof ExprCall) {
//			ExprCall ce = (ExprCall)e;
//			if (ce.args.isEmpty())                                   // f 
//				return Term.constFunc(id(ce.fun));
//			Vector<Term> params = new Vector<Term>(ce.args.size());  // f [e1,...]
//			for (Expr a : ce.args) {
//				params.add (translateExpression(a, namespace, letBindings));
//			}
//			return Term.func(id(ce.fun), params);
//		}
//		if (e instanceof ExprITE) {                                  // c => e1 else e2
//			ExprITE ite = (ExprITE)e;
//			return Term.ite(translateConstraint(ite.cond, namespace, letBindings),
//					translateExpression(ite.left, namespace, letBindings),translateExpression(ite.right, namespace, letBindings));
//		}
//		if (e instanceof ExprLet) {                                  // let x = e | sub
//			ExprLet let = (ExprLet)e;
//			letBindings.put(let.var, translateExpression(let.expr, namespace, letBindings));
//			Term t = translateExpression(let.sub, namespace, letBindings);
//			letBindings.remove(let.var);
//			return t;
//		}
//		if (e instanceof ExprConstant) {
//			ExprConstant c = (ExprConstant)e;
//			switch (c.op) {
//			case IDEN:
//				return Term.constFunc("iden");
//			case EMPTYNESS:
//				return Term.none(1);
//			default:
//				throw new ErrorFatal ("Unknown constant symbol: "+c.op);
//			}
//		}
//		throw new ErrorFatal ("Could not translate expression. The expression was: "+e);
//	}
//	
//	/**
//	 * translate an Alloy constraint to a KeY term
//	 * @param 
//	 * the Alloy constraint
//	 * @param namespace
//	 * set containing all names of singleton identifiers,
//	 * e.g. quantification variables. namespace may be null
//	 * @param letBindings
//	 * mapping variable names introduced by let to their bound.
//	 * can be null.
//	 * @return
//	 * the KeY formula
//	 */
//	private Formula translateConstraint (Expr c, Set<String> namespace, Map<ExprHasName,Term> letBindings) throws Err {
//		if (namespace == null) namespace = new HashSet<String>();
//		if (letBindings == null) letBindings = new HashMap<ExprHasName,Term>();
//		if (c instanceof ExprUnary) {
//			ExprUnary uc = (ExprUnary)c;
//			if (uc.sub == null) throw new ErrorFatal("");
//			switch (uc.op) {
//			case NOT:                                                // !c
//				return translateConstraint(uc.sub, namespace, letBindings).not();
//			case NO:                                                 // no e
//				return translateExpression(uc.sub, namespace, letBindings).equal(Term.none(arity(uc.sub)));
//			case SOME:                                               // some e
//				return Formula.unaryPred("some", translateExpression(uc.sub, namespace, letBindings));
//			case LONE:                                               // lone e
//				return Formula.unaryPred("lone", translateExpression(uc.sub, namespace, letBindings));
//			case ONE:                                                // one e
//				return Formula.unaryPred("one", translateExpression(uc.sub, namespace, letBindings));
//			default:
//				return translateConstraint(uc.sub, namespace, letBindings);
//			}
//		}
//		if (c instanceof ExprBinary) {
//			ExprBinary bc = (ExprBinary)c;
//			switch (bc.op) {
//			case EQUALS:                                             // e1 = e2
//				return translateExpression(bc.left, namespace, letBindings).equal(translateExpression(bc.right, namespace, letBindings));
//			case NOT_EQUALS:                                         // e1 != e2
//				return translateExpression(bc.left, namespace, letBindings).equal(translateExpression(bc.right, namespace, letBindings)).not();
//			case IMPLIES:                                            // c1 => c2
//				return translateConstraint(bc.left, namespace, letBindings).implies(translateConstraint(bc.right, namespace, letBindings));
//			case IN:                                                 // e1 in e2
//				return translateExpression(bc.left, namespace, letBindings).binPred("subrel",
//						translateExpression(bc.right, namespace, letBindings));
//			case NOT_IN:                                             // e1 !in e2
//				return translateExpression(bc.left, namespace, letBindings).binPred("subrel",
//						translateExpression(bc.right, namespace, letBindings)).not();
//			case AND:                                                // c1 && c2
//				return translateConstraint(bc.left, namespace, letBindings).and(translateConstraint(bc.right, namespace, letBindings));
//			case OR:                                                 // c1 || c2
//				return translateConstraint(bc.left, namespace, letBindings).or(translateConstraint(bc.right, namespace, letBindings));
//			case IFF:                                                // c1 <=> c2
//				return translateConstraint(bc.left, namespace, letBindings).iff(translateConstraint(bc.right, namespace, letBindings));
//			case LT:                                                 // TODO integers
//			case LTE:
//			case GT:
//			case GTE:
//			case NOT_LT:
//			case NOT_LTE:
//			case NOT_GT:
//			case NOT_GTE:
//			case SHL:
//			case SHR:
//			case SHA:
//				throw new ErrorFatal ("Integers not yet supported!");
//			}
//		}
//		if (c instanceof ExprCall) {
//			ExprCall cc = (ExprCall)c;
//			if (cc.args.isEmpty())                                   // p
//				return Formula.constPred(id(cc.fun));
//			Vector<Term> params = new Vector<Term>(cc.args.size());  // p [e1,...]
//			for (Expr a : cc.args) {
//				params.add (translateExpression(a, namespace, letBindings));
//			}
//			return Formula.pred(id(cc.fun), params);
//		}
//		if (c instanceof ExprITE) {                                  // c1 => c2 else c3
//			ExprITE ite = (ExprITE)c;
//			return Formula.ite(translateConstraint(ite.cond, namespace, letBindings),
//					translateConstraint(ite.left, namespace, letBindings),translateConstraint(ite.right, namespace, letBindings));
//		}
//		if (c instanceof ExprList) {                                 // { c1 c2 }
//			ExprList el = (ExprList)c;
//			Formula result = (el.op == ExprList.Op.AND) ? (Formula.TRUE) : (Formula.FALSE);
//			for (Expr c_ : el.args) {
//				switch (el.op) {
//				case AND:
//					result = result.and(translateConstraint (c_,namespace, letBindings));
//					break;
//				case OR:
//					result = result.or(translateConstraint (c_,namespace, letBindings));
//					break;
//				default:
//					throw new ErrorFatal ("Unsupported list operator in "+c);
//				}
//			}
//			return result;
//		}
//		if (c instanceof ExprQt) {
//			ExprQt qt = (ExprQt)c;
//			for (int i = 0; i < qt.count(); ++i) {
//				temporaryIdentifier(qt.get(i));
//				Expr bound = qt.getBound(i);
//				if (arity(bound) == 1 && mult(bound) == Mult.ONE)
//					namespace.add(id(qt.get(i)));
//			}
//			Formula f = translateConstraint(qt.sub,namespace, letBindings);
//			for (int i = qt.count()-1; i >= 0; --i) {
//				ExprVar v = qt.get(i);
//				namespace.remove(id(v));
//				Expr be = qt.getBound(i);
//				String sort = "";
//				Formula bound = null;
//				// simple quantification
//				// TODO treat disjoint declaration
//				// TODO really correct when multiplicity involved?
//				if (arity(be) == 1) {
//					switch (mult(be)) {
//					case SET:
//						sort = "Rel1";
//						bound = Formula.binaryPred("subrel", id(v), translateExpression(be,namespace, letBindings));
//						break;
//					case ONE:
//						sort = "Atom";
//						bound = Formula.binaryPred("in", id(v), translateExpression(be,namespace, letBindings));
//						namespace.add (v.label);
//						break;
//					case LONE:
//						sort = "Rel1";
//						bound = Formula.binaryPred("subrel", id(v), translateExpression(be,namespace, letBindings))
//											.and(Formula.unaryPred("lone", id(v)));
//						break;
//					case SOME:
//						sort = "Rel1";
//						bound = Formula.binaryPred("subrel", id(v), translateExpression(be,namespace, letBindings))
//											.and(Formula.unaryPred("some", id(v)));
//						break;
//					}
//				} else {
//					throw new ErrorFatal ("Quantification bounding expression of arity highter than 1 are not yet supported.");
//				}
//				switch (qt.op) {
//				case NO:
//					if (i > 0)
//						f = bound.and(f).exists(sort, id(v));
//					else
//						f = bound.and(f).exists(sort, id(v)).not();
//					break;
//				case SOME:
//					f = bound.and(f).exists(sort, id(v));
//					break;
//				case ALL:
//					f = bound.implies(f).forall(sort,id(v));
//					break;
//				case LONE:{
//					if (qt.count() > 1) throw new ErrorFatal ("Multiple variable bindings are not supported for lone quantifier.");
//					String newVar = newFreeIdentifier("y", bound.and(f));
//					Formula boundY = bound.substitute(id(v), newVar);
//					Formula fY = f.substitute(id(v), newVar);
//					Formula b = bound.and(boundY);
//					Formula s1 = f.and(fY);
//					Formula eq = Term.name(id(v)).equal(Term.name(newVar));
//					f = b.implies(s1.implies(eq)).forall(sort, newVar).forall(sort, id(v));}
//					break;
//				case ONE:{
//					if (qt.count() > 1) throw new ErrorFatal ("Multiple variable bindings are not supported for one quantifier.");
//					String newVar = newFreeIdentifier("y", bound.and(f));
//					Formula boundY = bound.substitute(id(v), newVar);
//					Formula fY = f.substitute(id(v), newVar);
//					Formula eq = Term.name(id(v)).equal(Term.name(newVar));
//					Formula s1 = boundY.and(fY).implies(eq).forall(sort, newVar);
//					f = bound.and(f).and(s1).exists(sort, id(v));}
//					break;
//				default:
//					throw new ErrorFatal ("Unsupported quantifier in "+c);
//				}
//				popIdentifier();
//			}
//			return f;
//		}
//		if (c instanceof ExprLet) {                                  // let x = c | sub
//			ExprLet let = (ExprLet)c;
//			letBindings.put(let.var, translateExpression(let.expr, namespace, letBindings));
//			Formula f = translateConstraint(let.sub, namespace, letBindings);
//			letBindings.remove(let.var);
//			return f;
//		}
//		if (c instanceof ExprConstant) {
//			ExprConstant ec = (ExprConstant)c;
//			switch (ec.op) {
//			case TRUE:
//				return Formula.TRUE;
//			case FALSE:
//				return Formula.FALSE;
//			default:
//				throw new ErrorFatal ("Unknown constant symbol: "+ec.op);
//			}
//		}
//		throw new ErrorFatal ("Could not translate constraint. The constraint was: "+c);
//	}
//	
//	private enum Mult {
//		SET,
//		LONE,
//		ONE,
//		SOME
//	}
//	
//	
//	/**
//	 * Generate constraints for multiplicity annotations on the right-hand side of the arrow operator.<br>
//	 * The declaration considered here looks like this: <code>t : m1 e1 ->m2 e2 ->m3 e3</code>
//	 * @param t
//	 * The term being declared
//	 * @param typing
//	 * The chain of set valued terms, typing each component of the declared term,
//	 * i.e. the e1,e2 etc. in the exemplary declaration above.
//	 * @param mults
//	 * The right-hand side multiplicity annotations of the arrow operator,
//	 * i.e. the m1,m2 etc. in the exemplary declaration above. 
//	 * @return
//	 * the multiplicity constraints as KeY formulas
//	 */
//	private static Collection<Formula> generateMultConstrRight (Term t, List<Term> typing, List<Mult> mults) {
//		LinkedList<Formula> cnstrs = new LinkedList<Formula>();
//		// we have a multiplicity annotation
//		switch (mults.get(0)) {
//		case ONE:
//			cnstrs.add (Formula.unaryPred("one", t));
//			break;
//		case SOME:
//			cnstrs.add (Formula.unaryPred("some", t));
//			break;
//		case LONE:
//			cnstrs.add (Formula.unaryPred("lone", t));
//			break;
//		default:
//			break;
//		}
//		if (mults.size() > 1) {
//			Collection<Formula> subcnstrs = generateMultConstrRight (Term.binaryFunc("join1x"+typing.size(), Term.sin("x"+(typing.size()-1)), t),
//					typing.subList(1, typing.size()), mults.subList(1, mults.size()));
//			for (Formula f : subcnstrs) {
//				cnstrs.add(f.forallWithGuard("Atom", "x"+(typing.size()-1), Formula.binaryPred("in", "x"+(typing.size()-1), typing.get(0))));
//			}
//		}
//		return cnstrs;
//	}
//	
//	/**
//	 * Generate constraints for multiplicity annotations on the left-hand side of the arrow operator.<br>
//	 * The declaration considered here looks like this: <code>t : e1 m1-> e2 m2-> e3</code>
//	 * @param t
//	 * The term being declared
//	 * @param typing
//	 * The chain of set valued terms, typing each component of the declared term,
//	 * i.e. the e1,e2 etc. in the exemplary declaration above.
//	 * @param mults
//	 * The left-hand side multiplicity annotations of the arrow operator,
//	 * i.e. the m1,m2 etc. in the exemplary declaration above. 
//	 * @return
//	 * the multiplicity constraints as KeY formulas
//	 */
//	private static Collection<Formula> generateMultConstrLeft (Term t, List<Term> typing, List<Mult> mults) {
//		LinkedList<Formula> cnstrs = new LinkedList<Formula>();
//		// we have a multiplicity annotation
//		switch (mults.get(mults.size()-1)) {
//		case ONE:
//			cnstrs.add (Formula.unaryPred("one", t));
//			break;
//		case SOME:
//			cnstrs.add (Formula.unaryPred("some", t));
//			break;
//		case LONE:
//			cnstrs.add (Formula.unaryPred("lone", t));
//			break;
//		default:
//			break;
//		}
//		if (mults.size() > 1) {
//			Collection<Formula> subcnstrs = generateMultConstrLeft (Term.binaryFunc("join"+typing.size()+"x1", t, Term.sin("x"+(typing.size()-1))),
//					typing.subList(0, typing.size()-1), mults.subList(0, mults.size()-1));
//			for (Formula f : subcnstrs) {
//				cnstrs.add(f.forallWithGuard("Atom", "x"+(typing.size()-1), Formula.binaryPred("in", "x"+(typing.size()-1), typing.get(typing.size()-1))));
//			}
//		}
//		return cnstrs;
//	}
//	
//	/**
//	 * generate multiplicity constraints for a declaration of the form <code>t : [mult] e</code>
//	 * or <code>t : e1 n1->m1 e2 n2->m2 e3</code>
//	 * @param t
//	 * the term being declared
//	 * @param declExpr
//	 * the declaration expression with multiplicity annotations
//	 * @param namespace
//	 * namespace for translating the typing expressions
//	 * @param letBindings
//	 * letBindings for translating the typing expressions
//	 * @return
//	 * multiplicity constraints as KeY formulas
//	 */
//	private Collection<Formula> generateMultConstr (Term t, Expr declExpr, Set<String> namespace, Map<ExprHasName,Term> letBindings) throws Err {
//		// handle multiplicity of set-valued declaration expressions
//		if (declExpr.mult == 1) {
//			LinkedList<Formula> cnstrs = new LinkedList<Formula>();
//			switch (declExpr.mult()) {
//			case SOMEOF:
//				cnstrs.add (Formula.unaryPred("some", t));
//				break;
//			case LONEOF:
//				cnstrs.add (Formula.unaryPred("lone", t));
//				break;
//			case ONEOF:
//				cnstrs.add (Formula.unaryPred("one", t));
//				break;
//			case SETOF:
//				break;
//			}
//			return cnstrs;
//		} else if (arity(declExpr) == 1) {
//			// no explicit multiplicity defaults to one
//			LinkedList<Formula> cnstrs = new LinkedList<Formula>();
//			cnstrs.add (Formula.unaryPred("one", t));
//			return cnstrs;
//			
//		// handle multiplicity of relation-valued fields
//		} else if (declExpr.mult == 2) {
//			LinkedList<Formula> cnstrs = new LinkedList<Formula>();
//			List<Term> typing = createExprChain (declExpr,namespace,letBindings);
//			List<Mult> multR = createMultChainRight (declExpr);
//			List<Mult> multL = createMultChainLeft (declExpr);
//			if (typing.size() < 2 || multR.size() != multL.size() || multR.size()+1 != typing.size())
//				throw new ErrorFatal ("Must be a weird declaration expression: "+declExpr);
//			Collection<Formula> subcnstrs = generateMultConstrRight (Term.binaryFunc("join1x"+(typing.size()), Term.sin("x"+(typing.size()-1)), t), 
//					typing.subList(1,typing.size()), multR);
//			for (Formula f : subcnstrs) {
//				cnstrs.add (f.forallWithGuard("Atom", "x"+(typing.size()-1), Formula.binaryPred("in", "x"+(typing.size()-1), typing.get(0))));
//			}
//			subcnstrs = generateMultConstrLeft (Term.binaryFunc("join"+(typing.size())+"x1", t, Term.sin("x"+(typing.size()-1))), 
//					typing.subList(0,typing.size()-1), multL);
//			for (Formula f : subcnstrs) {
//				cnstrs.add (f.forallWithGuard("Atom", "x"+(typing.size()-1), Formula.binaryPred("in", "x"+(typing.size()-1), typing.get(typing.size()-1))));
//			}
//			return cnstrs;
//		}
//		// no multiplicity annotation for relation-valued field
//		return new LinkedList<Formula>();
//	}
//	
//
//	private List<Term> createExprChain (Expr expr, Set<String> namespace, Map<ExprHasName,Term> letBindings) throws Err {
//		LinkedList<Term> ret = new LinkedList<Term>();
//		if (arity(expr) == 1) {
//			ret.add(translateExpression(expr,namespace,letBindings));
//			return ret;
//		}
//		if (!(expr instanceof ExprBinary)) throw new ErrorFatal ("");
//		ExprBinary arrowExp = (ExprBinary)expr;
//		ret.addAll(createExprChain(arrowExp.left,namespace,letBindings));
//		ret.addAll(createExprChain(arrowExp.right,namespace,letBindings));
//		return ret;
//	}
//	// create chain of right-hand multiplicities of the arrow-operators
//	// first element in the chain will always be SET
//	private static List<Mult> createMultChainRight (Expr expr) throws Err {
//		if (arity(expr) == 1)
//			return new LinkedList<Mult>();
//		if (!(expr instanceof ExprBinary)) throw new ErrorFatal ("");
//		ExprBinary arrowExp = (ExprBinary)expr;
//		LinkedList<Mult> ret = new LinkedList<Mult>();
//		ret.addAll(createMultChainRight(arrowExp.left));
//		switch (arrowExp.op) {
//			case ARROW:
//			case SOME_ARROW_ANY:
//			case ONE_ARROW_ANY:
//			case LONE_ARROW_ANY:
//				ret.add(Mult.SET);
//				break;
//			case ANY_ARROW_SOME:
//			case SOME_ARROW_SOME:
//			case ONE_ARROW_SOME:
//			case LONE_ARROW_SOME:
//				ret.add(Mult.SOME);
//				break;
//			case ANY_ARROW_ONE:
//			case SOME_ARROW_ONE:
//			case ONE_ARROW_ONE:
//			case LONE_ARROW_ONE:
//				ret.add(Mult.ONE);
//				break;
//			case ANY_ARROW_LONE:
//			case SOME_ARROW_LONE:
//			case ONE_ARROW_LONE:
//			case LONE_ARROW_LONE:
//				ret.add(Mult.LONE);
//				break;
//			default:
//				throw new ErrorFatal("");
//		}
//		ret.addAll(createMultChainRight(arrowExp.right));
//		return ret;
//	}
//	// create chain of left-hand multiplicities of the arrow-operators
//	// first element in the chain will always be SET
//	private static List<Mult> createMultChainLeft (Expr expr) throws Err {
//		if (arity(expr) == 1)
//			return new LinkedList<Mult>();
//		if (!(expr instanceof ExprBinary)) throw new ErrorFatal ("");
//		ExprBinary arrowExp = (ExprBinary)expr;
//		LinkedList<Mult> ret = new LinkedList<Mult>();
//		ret.addAll(createMultChainLeft(arrowExp.left));
//		switch (arrowExp.op) {
//			case ARROW:
//			case ANY_ARROW_SOME:
//			case ANY_ARROW_ONE:
//			case ANY_ARROW_LONE:
//				ret.add(Mult.SET);
//				break;				
//			case SOME_ARROW_ANY:
//			case SOME_ARROW_SOME:
//			case SOME_ARROW_ONE:
//			case SOME_ARROW_LONE:
//				ret.add(Mult.SOME);
//				break;	
//			case ONE_ARROW_ANY:
//			case ONE_ARROW_SOME:
//			case ONE_ARROW_ONE:
//			case ONE_ARROW_LONE:
//				ret.add(Mult.ONE);
//				break;
//			case LONE_ARROW_ANY:
//			case LONE_ARROW_SOME:
//			case LONE_ARROW_ONE:
//			case LONE_ARROW_LONE:
//				ret.add(Mult.LONE);
//				break;
//			default:
//				throw new ErrorFatal("");
//		}
//		ret.addAll(createMultChainLeft(arrowExp.right));
//		return ret;
//	}
//	
//}
