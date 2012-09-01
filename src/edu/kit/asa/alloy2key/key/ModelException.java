/**
 * 
 */
package edu.kit.asa.alloy2key.key;

/** This exception indicates a problem with the construction of the SMT model.
 *  Its purpose is to alert the developer of possible bugs and to allow sanity 
 *  testing inside the model. The end-user should never, ever see this Exception.
 * @author Jonny
 *
 */
@SuppressWarnings("serial")
public class ModelException extends Exception {

	final static String Explanation = " (This exception indicates a problem with the construction of the SMT model." +
			" Its purpose is to alert the developer of possible bugs and to allow " +
			"sanity testing inside the model. The end-user should never, ever see this Exception.)";
	
	public ModelException(String string) {		
		super(string + Explanation);
	}
}
