package DataStructure.javaDNA;

import Compiler.Visiter;
import Compiler.IParser;
import Compiler.Visitable;

public abstract class Statement implements Visitable {

	protected Parser p;
	@Override
	public void setParser(IParser p) {
		this.p = (Parser)p;

	}
	
	public abstract Statement getCopy();
	
	public abstract int similarity(Statement o);
}
