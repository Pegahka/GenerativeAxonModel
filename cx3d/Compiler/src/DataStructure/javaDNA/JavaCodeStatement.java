package DataStructure.javaDNA;

import Analysis.NeedlemanWunsch;
import Compiler.Visiter;

public class JavaCodeStatement extends Statement{
	
	public String javacode=""; 
	public String comment ="";
	
	@Override
	public void createFromString(String s) {
		javacode = s.substring(s.indexOf("JAVACODESTART")+13, s.indexOf("JAVACODESTOP"));
		comment = javacode.substring(0, javacode.indexOf("\n"));
		javacode = javacode.substring(javacode.indexOf("\n")+1);
	}

	@Override
	public String identifier() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Statement getCopy() {
		JavaCodeStatement n = new JavaCodeStatement();
		n.p = p;
		n.javacode = javacode;
		n.comment = comment;
		return n;
	}
	
	public String toString()
	{
		return  "java"+comment;
	}
	
	@Override
	public int similarity(Statement o) {
		if(!(o instanceof JavaCodeStatement)) return NeedlemanWunsch.unequal;
		JavaCodeStatement a = (JavaCodeStatement) o;
		int i = NeedlemanWunsch.sametype;
		
		return i;
	}
	
}
