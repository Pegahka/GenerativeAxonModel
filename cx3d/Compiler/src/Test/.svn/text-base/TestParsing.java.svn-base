package Test;

import java.io.FileNotFoundException;
import java.io.PrintStream;

import DataStructure.javaDNA.Parser;
import DataStructure.printer.HirarchicalDraw;

public class TestParsing {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		
		Parser p = new Parser();
		p.ParseDir("MouseLaminationFiles");

		try {
			p.visit(new HirarchicalDraw(new PrintStream("AST")));
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
