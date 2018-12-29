package DataStructure.javaDNA;

import java.util.StringTokenizer;
import java.util.Vector;

import Analysis.NeedlemanWunsch;
import Compiler.Visiter;

public class FunctionCall extends Value {

	public String name;
	public String callType ="";
	public Vector<Value> vals = new Vector<Value>();

	@Override
	public void createFromString(String s) {
		name = s.substring(0,s.indexOf('('));
		String tmp = s.substring(s.indexOf('(')+1,s.lastIndexOf(')') );
	
		int k =0;
		while(k!=-1)
		{
			k = p.findIgnoreRoundBrackets(tmp, ',');
			String t;
			if(k!=-1)
			{
				 t = tmp.substring(0,k);
				 tmp = tmp.substring(k+1);
			}
			else
			{
				t = tmp;
			}
			t = t.trim();
			if(t.length()!=0)
			{	
				Value v = p.readValueTree(t);
				vals.add(v);
			}			
		}
	}

	@Override
	public String identifier() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Statement getCopy() {
		FunctionCall n = new FunctionCall();
		n.p = p;
		n.name = name;
		n.callType = callType;
		for(Value v:vals)
		{
			n.vals.add((Value)v.getCopy());
		}
		return n;
	}

	public String toString()
	{
		return  "call "+this.name;
	}
	
	@Override
	public int similarity(Statement o) {
		if(!(o instanceof FunctionCall)) return NeedlemanWunsch.unequal;
		FunctionCall a = (FunctionCall) o;
		int i =0;
		if(this.name.equals(a.name))
		{
			i+=NeedlemanWunsch.sametype;
			if(this.vals.size() == a.vals.size())
			{
				for(int k = 0;k<vals.size();k++)
				{
					i+=vals.get(k).similarity(a.vals.get(k));
				}
			}
		}
		else
		{
			i=NeedlemanWunsch.unequal;
		}
		
		return i;
	}
	
}

