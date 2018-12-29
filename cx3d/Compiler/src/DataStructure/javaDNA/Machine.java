package DataStructure.javaDNA;

import java.util.ArrayList;
import java.util.Stack;
import java.util.StringTokenizer;

import Analysis.NeedlemanWunsch;
import Compiler.Visiter;
import Compiler.IParser;
import Compiler.Visitable;

public class Machine implements Visitable{

	public ArrayList<FunctionDefinition> functions = new ArrayList<FunctionDefinition>();
	public ArrayList<AbstractFunctionDefinition> abstractfunctions = new ArrayList<AbstractFunctionDefinition>();
	public FunctionDefinition run;
	public ArrayList<MemoryElement> memoryElements = new ArrayList<MemoryElement>();
	public Parser p;
	public boolean isabstract;
	public String name;
	public String basemachine="";
	public int complexity=0;
	
	public void setParser(IParser p)
	{
		this.p =(Parser) p;
	}
	@Override
	public void createFromString(String s) {
		s = findMachineName(s);
		s = findfunctions(s);
		s = findAbstractFunctions(s);
		s = findmemoryElements(s);
		
	}

	private String findmemoryElements(String s) {
		
		StringTokenizer t = new StringTokenizer(s,";");
		while(t.hasMoreElements())
		{
			String tmp = (String)t.nextElement();
			tmp = tmp.trim();
			if(tmp.length()==0) continue;
			s.replaceAll(tmp, "");
			MemoryElement mem = new MemoryElement();
			mem.setParser(p);
			mem.createFromString(tmp.trim());
			memoryElements.add(mem);
			
		}
		return s;
	}
	
	private String findAbstractFunctions(String s) {
		
		StringTokenizer t = new StringTokenizer(s,";");
		while(t.hasMoreElements())
		{
			String tmp = (String)t.nextElement();
			tmp = tmp.trim();
			if(tmp.length()<0) continue;
			if(tmp.contains("abstract "))
			{
				AbstractFunctionDefinition f = new AbstractFunctionDefinition();
				f.setParser(p);
				f.createFromString(tmp.trim());
				abstractfunctions.add(f);
				s = s.replace(tmp,"");
			}
		}
		return s;
	}
	
	
	private String findMachineName(String s) {
		
		String res = s.substring(s.indexOf("{")+1,s.lastIndexOf('}'));
		String toAnalyze =  s.substring(0,s.indexOf("{"));
		
		StringTokenizer t = new StringTokenizer(toAnalyze," ");
		while(t.hasMoreElements())
		{
			String tmp = (String)t.nextElement();
			tmp = tmp.trim();
			if(tmp.toLowerCase().equals("class"))
			{
				name = ((String) t.nextElement()).trim();
			}
			if(tmp.toLowerCase().equals("abstract")){ 
				isabstract = true;
			}
			if(tmp.toLowerCase().equals("extends")){ 
				basemachine =((String) t.nextElement()).trim();
			}		
		}
		if(name==null)
		{
			System.out.println(s);
		}
		return res;
	}
	private String findfunctions(String s) {
		
		while(s.contains("}"))
		{
			
			int [] i = p.extractFirstBlock(s);
			String tmp = s.substring(0, i[0]+1);
			
			if(tmp.contains(";"))
			{
				 i[0] = tmp.lastIndexOf(';')+1;
			}
			else
			{
				i[0]  = 0;
			}
			
			FunctionDefinition f = new FunctionDefinition();
			f.setParser(p);
			String tmp2 = s.substring(i[0],i[1]+1);
			f.createFromString(tmp2.trim());
			functions.add(f);
			s = s.substring(0, i[0])+s.substring(i[1]+1, s.length());
		}
		
		return s;
	}
	
	@Override
	public String identifier() {
		// TODO Auto-generated method stub
		return null;
	}

	
	public String toString()
	{
		return  "machine "+name;
	}
	
	
	public int similarity(Machine o) {
		
		int i =0;
		if(this.basemachine.equals(o.basemachine)) 
			i+=20;
		for(FunctionDefinition f : functions)
		{
			int k = Integer.MIN_VALUE;
			for(FunctionDefinition f2 : o.functions)
			{
				int t = f2.similarity(f);
				if(t>k)
				{
					k = t;
				}
			}
			i+=k;
		}
		return i;

	}
	
}
