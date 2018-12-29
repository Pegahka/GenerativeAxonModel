package DataStructure.javaDNA;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Vector;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import Compiler.Visiter;
import Compiler.IParser;

public class Parser implements IParser{

	public DNA dna = new DNA();

	public void readMachineDefinition(String filename)
	{

	}

	public void ParseDir(String dirname)
	{
		//File f = new File("MouseLaminationFiles/RandomBranchingModule.java");
//		File f = new File("MouseLaminationFiles/PrePlate.java");
//		String s = readFileAsString(f.getAbsolutePath());
//		s = filterComments(s);
//		dna.setParser(this);
//		dna.createFromString(s);
		try {
			for(File f: getFileListing(new File(dirname)))
			{
				String s = readFileAsString(f.getAbsolutePath());
				s = filterComments(s);
				dna.setParser(this);
				dna.createFromString(s);
			}
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}



	private String filterComments(String s) {
		while(s.contains("//++Java"))
		{
			s = s.replace("//++Java", "JAVACODESTART");
		}
		while(s.contains("//--Java"))
		{
			s = s.replace("//--Java", "JAVACODESTOP");
		}
		while(s.contains("@Override"))
		{
			s = s.substring(0,s.indexOf("@Override"))+ s.substring(s.indexOf('\n', s.indexOf("@Override")),s.length());
		}
		while(s.contains("//"))
		{
			s = s.substring(0,s.indexOf("//"))+ s.substring(s.indexOf('\n', s.indexOf("//")),s.length());
		}
		while(s.contains("/*"))
		{
			String a = s.substring(0,s.indexOf("/*"));
			String b = s.substring(s.indexOf("*/", s.indexOf("/*"))+2,s.length());
			s = a+b ;
		}
		return s;
		
		
	}

	private ArrayList<File> getFileListing( File aStartingDir) throws FileNotFoundException {
		ArrayList<File> result = getFileListingNoSort(aStartingDir);
		Collections.sort(result);
		return result;
	}

	private String readFileAsString(String filePath){
		try
		{
			StringBuffer fileData = new StringBuffer(1000);
			BufferedReader reader = new BufferedReader(
					new FileReader(filePath));
			char[] buf = new char[1024];
			int numRead=0;
			while((numRead=reader.read(buf)) != -1){
				String readData = String.valueOf(buf, 0, numRead);
				fileData.append(readData);
				buf = new char[1024];
			}
			reader.close();
			return fileData.toString();
		}
		catch(Exception e)
		{}
		return "";
	}

	// PRIVATE //
	private ArrayList<File> getFileListingNoSort( File aStartingDir ) throws FileNotFoundException {
		ArrayList<File> result = new ArrayList<File>();
		File[] filesAndDirs = aStartingDir.listFiles();
		for(File file : filesAndDirs) {

			if ( ! file.isFile() ) {
				ArrayList<File> deeperList = getFileListingNoSort(file);
				result.addAll(deeperList);
			}
			else
			{
				if(file.getAbsolutePath().endsWith(".java"))
				{
					result.add(file);
				}
			}
		}
		return result;
	}

	public void visit(Visiter format)
	{
		format.visit(dna);
	}

	public int [] extractFirstBlock(String s)
	{
		int[] arry = new int[2];
		arry[0] = s.indexOf('{')+1;
		String tmp = s.substring(arry[0],s.length());


		int k = 1;
		int i =0;
		while(k!=0)
		{
			if(i>tmp.length()) throw new RuntimeException("opening '{' do not match closiung '}'");
			if(tmp.charAt(i)=='}')
			{
				k--;
			}
			if(tmp.charAt(i) =='{')
			{
				k++;
			}
			i++;
		}
		arry[1] = arry[0]+i-1;
		return arry;
	}


	public int findIgnoreBlocks(String s,char c)
	{
		int k = 0;
		for(int i = 0;i<s.length();i++)
		{
			if(k == 0 && s.charAt(i)==c)
			{
				return i;
			}
			if(s.charAt(i)=='}')
			{
				k--;
			}
			if(s.charAt(i) =='{')
			{
				k++;
			}

		}
		return -1;
	}
	
	public int findIgnoreRoundBrackets(String s,char c)
	{
		int k = 0;
		for(int i = 0;i<s.length();i++)
		{
			if(k == 0 && s.charAt(i)==c)
			{
				return i;
			}
			if(s.charAt(i)==')')
			{
				k--;
			}
			if(s.charAt(i) =='(')
			{
				k++;
			}
		}
		return -1;
	}

	public int [] extractInBetweenBlocks(String s)
	{
		int[] arry = new int[2];
		arry[0] = s.indexOf('}');
		String tmp = s.substring(arry[0]+1,s.length());


		int k = 1;
		int i =0;
		while(k!=0)
		{
			if(i>tmp.length()) throw new RuntimeException("opening '}' do not match closiung '{'");
			if(tmp.charAt(i)=='{')
			{
				k--;
			}
			if(tmp.charAt(i) =='}')
			{
				k++;
			}
			i++;
		}
		arry[1] = s.indexOf('}')+i-1;
		return arry;
	}

	public Value readValueTree(String t)
	{
		Parser p = this;
		t = t.trim();
		
		if(t.startsWith("null"))
		{
			NullValue c =  new NullValue();
			c.setParser(p);
			c.createFromString(t);
			return c;
		}
	
		if(t.startsWith("new"))
		{
			NewOperator c =  new NewOperator();
			c.setParser(p);
			c.createFromString(t);
			return c;
		}
		
		
		try{
			Constant c =  new DoubleConstant();
			c.setParser(p);
			c.createFromString(t);
			return c;
		}
		catch (Exception e) {}
		
		
		int i = findIgnoreRoundBrackets(t, '.');
		if(i>0)
		{
			DotOperator c =  new DotOperator();
			c.setParser(p);
			c.createFromString(t);
			return c;
		}
		
		if(t.contains("("))
		{
			FunctionCall c =  new FunctionCall();
			c.setParser(p);
			c.createFromString(t);
			return c;
		}
		
		

		try{
			Constant c =  new IntegerConstant();
			c.setParser(p);
			c.createFromString(t);
			return c;
		}
		catch (Exception e) {}


		try{
			Constant c =  new BooleanConstant();
			c.setParser(p);
			c.createFromString(t);
			return c;

		}
		catch (Exception e) {}

		try{
			StringValue c =  new StringValue();
			c.setParser(p);
			c.createFromString(t);
			return c;

		}
		catch (Exception e) {}

		try{
			VariableAsValue c =  new VariableAsValue();
			c.setParser(p);
			c.createFromString(t);
			return c;
		}
		catch (Exception e) {}


		throw new RuntimeException("could not be found!");
	}

	public String readStatement(String block,Vector<Statement> statements) {
		Parser p = this;
		block = block.trim();
		if(block.length()==0) return "";
		
		if(block.startsWith("JAVACODESTART"))
		{
			
			String java  = block.substring(0, block.indexOf("JAVACODESTOP")+12);
			block = block.substring(block.indexOf("JAVACODESTOP")+12);
			JavaCodeStatement f = new JavaCodeStatement();
			f.setParser(p);
			f.createFromString(java);
			statements.add(f);
			return block;
		}
		if(block.startsWith("return"))
		{
			
			String java  = block.substring(0, block.indexOf(";"));
			block = block.substring(block.indexOf(";")+1);
			ReturnStatement f = new ReturnStatement();
			f.setParser(p);
			f.createFromString(java);
			statements.add(f);
			return block;
		}
		if(block.startsWith("continue"))
		{
			
			String java  = block.substring(0, block.indexOf(";"));
			block = block.substring(block.indexOf(";")+1);
			ContinueStatement f = new ContinueStatement();
			f.setParser(p);
			f.createFromString(java);
			statements.add(f);
			return block;
		}
		
		Pattern regex;
		Matcher matcher;
		regex = Pattern.compile("^for[\\s]*\\(");
		matcher = regex.matcher(block);
		if(matcher.find())
		{
			block =  blocklessIf(block);
			int i [] = p.extractFirstBlock(block);
			String ifs  = block.substring(0, i[1]+1);
			block = block.substring(i[1]+1);
			ForEachStaement f = new ForEachStaement();
			f.setParser(p);
			f.createFromString(ifs);
			statements.add(f);
			return block;
		}
		
		regex = Pattern.compile("^if[\\s]*\\(");
		matcher = regex.matcher(block);
		if(matcher.find())
		{
			block =  blocklessIf(block);
			int i [] = p.extractFirstBlock(block);
			String ifs  = block.substring(0, i[1]+1);
			block = block.substring(i[1]+1);
			IfStaement f = new IfStaement();
			f.setParser(p);
			f.createFromString(ifs);
			statements.add(f);
			return block;
		}
		regex = Pattern.compile("^else[\\s]*if[\\s]*\\(");
		matcher = regex.matcher(block);
		if(matcher.find())
		{
			block =  blocklessIf(block);
			int i [] = p.extractFirstBlock(block);
			String ifs  = block.substring(0, i[1]+1);
			block = block.substring(i[1]+1);
			ElseIfStaement f = new ElseIfStaement();
			f.setParser(p);
			f.createFromString(ifs);
			statements.add(f);
			return block;
		}
		regex = Pattern.compile("^else");
		matcher = regex.matcher(block);
		if(matcher.find())
		{
			block =  blocklessIf(block);
			int i [] = p.extractFirstBlock(block);
			String ifs  = block.substring(0, i[1]+1);
			block = block.substring(i[1]+1);
			ElseStaement f = new ElseStaement();
			f.setParser(p);
			f.createFromString(ifs);
			statements.add(f);
			return block;
		}
		
		
		
		int i = p.findIgnoreBlocks(block, ';');
		String stmt = block.substring(0, i);

		block = block.substring(i+1);
		if(p.findIgnoreBlocks(stmt, '=')!=-1)
		{
			//find assignment
			AssignOperator f = new AssignOperator();
			f.setParser(p);
			f.createFromString(stmt);
			statements.add(f);
			return block;

		}

		
		regex = Pattern.compile("^[a-zA-Z_0-9]+ [a-zA-Z_0-9]+$");
		matcher = regex.matcher(stmt);
		if(matcher.find())
		{
			Variable f = new Variable();
			f.setParser(p);
			f.createFromString(stmt);
			statements.add(f);
			return block;
		}
		
		
		statements.add(readValueTree(stmt));
		



		return block;
	}

	private String blocklessIf(String block) {
		// TODO Auto-generated method stub
		int semicolonpos = block.indexOf(';');
		int blockstartpos = block.indexOf('{');
		if(semicolonpos>-1 && semicolonpos<blockstartpos || blockstartpos ==-1)
		{
			String tmp = block.substring(0, semicolonpos+1);
			String tmp2 = tmp.substring(0,tmp.lastIndexOf(")")+1);
			String correction = tmp.replace(tmp2, tmp2+"{")+"}";
			block = block.replace(tmp, correction);
		}
		return block;
	}

}
