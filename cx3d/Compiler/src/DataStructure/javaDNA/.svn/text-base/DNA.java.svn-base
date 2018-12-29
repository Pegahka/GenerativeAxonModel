package DataStructure.javaDNA;

import java.util.ArrayList;

import Compiler.Visiter;
import Compiler.IParser;
import Compiler.Visitable;

public class DNA implements Visitable{
	public ArrayList<Machine> machines = new ArrayList<Machine>();
	public Parser p;
	
	@Override
	public String identifier() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void createFromString(String s) {
		
		while(s.contains("class"))
		{
			int []i = p.extractFirstBlock(s);
			String tmp = s.substring(0, i[0]);
			if(tmp.contains(";"))
			{
				 i[0] = tmp.lastIndexOf(';')+1;
			}
			else
			{
				i[0] = 0;
			}
			
			
			Machine m = new Machine();
			m.setParser(p);
			//System.out.println("length"+s.length());
			String tmp2 = s.substring(i[0],i[1]+1);
			m.createFromString(tmp2);
			machines.add(m);
			s = s.substring(i[1]+1, s.length());
		}

	}


	@Override
	public void setParser(IParser p) {
		this.p =(Parser)p;
	}
}
