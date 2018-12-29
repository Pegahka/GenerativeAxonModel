package DataStructure.javaDNA;

import java.util.Vector;

import Analysis.NeedlemanWunsch;
import Compiler.Visiter;
import Compiler.IParser;
import Compiler.Visitable;

public class ForEachStaement extends Statement {

	public Vector<Statement> statements = new Vector<Statement>();
	public Variable iterating;
	public Variable collection;

	@Override
	public void createFromString(String s) {
		s = s.trim();
		String value = s.substring(0,s.indexOf('{'));
		
		value = value.trim();
		value = value.substring(value.indexOf('(')+1, value.lastIndexOf(')'));
		String iter = value.substring(0, value.indexOf(':'));
		String col = value.substring(value.indexOf(':'));
		
		iterating = new Variable();
		iterating.setParser(p);
		iterating.createFromString(iter);
		
		collection = new Variable();
		collection.setParser(p);
		collection.createFromString(col);
		
		int [] index = p.extractFirstBlock(s);
		String block = s.substring(index[0],index[1]);	
		while(block.length()>0)
		{
			block = p.readStatement(block,statements);
		}
	}

	@Override
	public String identifier() {
		// TODO Auto-generated method stub
		return null;
	}

	
	@Override
	public Statement getCopy() {
		ForEachStaement n = new ForEachStaement();
		n.iterating = (Variable) iterating.getCopy();
		n.collection = (Variable) collection.getCopy();
		n.p = p;
		for(Statement s:statements)
		{
			n.statements.add(s.getCopy());
		}
		return n;
	}
	
	public String toString()
	{
		return  "for("+this.iterating.toString()+" : "+this.collection.toString()+")";
	}
	
	@Override
	public int similarity(Statement o) {
		if(!(o instanceof ForEachStaement)) return NeedlemanWunsch.unequal;
		ForEachStaement a = (ForEachStaement) o;
		int i = NeedlemanWunsch.sametype;
		i+=  iterating.similarity(iterating);
		i+=  collection.similarity(collection);
		i+=  NeedlemanWunsch.similarityValue(this.statements, a.statements)/2;
		
		return i;
	}

}
