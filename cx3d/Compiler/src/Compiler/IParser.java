package Compiler;

public interface IParser {
	
	public  void readMachineDefinition(String filename);
	public  void ParseDir(String dirname);
	public  void visit(Visiter format);
	
}
