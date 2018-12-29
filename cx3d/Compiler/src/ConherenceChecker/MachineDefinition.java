package ConherenceChecker;

import java.io.File;
import java.io.IOException;
import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.net.URL;
import java.net.URLClassLoader;
import java.util.Vector;

import javax.tools.JavaCompiler;
import javax.tools.ToolProvider;

public class MachineDefinition {

	public Vector<String> machineTypes = new Vector<String>();
	public Vector<String> types = new Vector<String>();
	Vector<String> primitivenames =  new Vector<String>();
	Vector<String> logicFilters = new Vector<String>();
	Vector<String> mathFilters = new Vector<String>();
	Vector<String> readers = new Vector<String>();
	Vector<String> writers = new Vector<String>();
	
	public void readMachineDefiniton(String filename)
	{
		try {
			String classname = compileClass(new File(filename));
			readAllFunctions(classname);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public void readGCodeType(String filename)
	{
		try {
			String s = compileClass(new File(filename));
			readType(s);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	Vector<String> sources = new Vector<String>();
	private void readAllFunctions(String classname) throws ClassNotFoundException
	{
		
			Class<?> c = Class.forName(classname, true, classLoader);
			machineTypes.add(c.getName());
            Method m[] = c.getDeclaredMethods();
            
            for (int i = 0; i < m.length; i++)
            {
            	boolean containsnotgcode=false;
            	String name = m[i].getName();
            	Annotation[] l = m[i].getAnnotations();
            	for (Annotation an:  l) {
            		if(an.annotationType().getName().contains("notgcode"))
            			containsnotgcode = true;   
				} 
            	if(containsnotgcode) continue;
            
            	
            	
            	if(name.toLowerCase().startsWith("run")) continue;
            	else if(name.toLowerCase().startsWith("val")) continue;
            	else if(name.toLowerCase().startsWith("write"))
            	{
            		if(writers.contains(name)) continue;
            		writers.add(name);
            	}
            	else if(name.toLowerCase().startsWith("read"))
            	{
            		if(readers.contains(name)) continue;
            		readers.add(name);
            	}
            	else if(name.startsWith("M"))
            	{
            		if(mathFilters.contains(name)) continue;
            		mathFilters.add(name);
            	}
            	else if(name.startsWith("L"))
            	{
            		if(logicFilters.contains(name)) continue;
            		logicFilters.add(name);
            	}
            	else
            	{
            		if(primitivenames.contains(name)) continue;
            		primitivenames.add(name);
            	}
            }
	}
	
	private void readType(String classname) throws ClassNotFoundException
	{
		
			Class<?> c = Class.forName(classname, true, classLoader);
			types.add(c.getName());
	}
	
	URLClassLoader classLoader;
	private String compileClass(File sourceFile) throws IOException, ClassNotFoundException, InstantiationException, IllegalAccessException
	{
//		File root = new File(sourceFile.getPath()); // On Windows running on C:\, this is C:\java.
//		File sourceFile = new File(root, "test/Test.java");
//		sourceFile.getParentFile().mkdirs();
//		new FileWriter(sourceFile).append(source).close();

		
		sources.add(sourceFile.getPath());
		
		
		String [] array = (String[])sources.toArray(new String[0]);
		
		if(!sourceFile.exists())
		{
			System.out.println("can not be found!");
			
		}
		JavaCompiler compiler = ToolProvider.getSystemJavaCompiler();
		compiler.run(null, null, null, array);

		Class<?> cls;
		classLoader = URLClassLoader.newInstance(new URL[] { sourceFile.getParentFile().getParentFile().toURI().toURL() });
		String classname = sourceFile.getParentFile().getName()+"."+sourceFile.getName().replace(".java", "");
	
		//cls = Class.forName(  , true, classLoader); 
		cls = Class.forName(classname, true, classLoader);
		
		return classname;

//		Object instance = cls.newInstance(); 
//		System.out.println(instance); 
//		return instance;
//		return cls.getCanonicalName();
	}
	
	
	public void printAll()
	{
		System.out.println("\nmachineTypes:");
		for(String s: this.machineTypes)
			System.out.println(s);
		System.out.println("\nlogicFiltgers:");
		for(String s: this.logicFilters)
			System.out.println(s);
		System.out.println("\nmathfilteres:");
		for(String s: this.mathFilters)
			System.out.println(s);
		System.out.println("\nprimitives:");
		for(String s: this.primitivenames)
			System.out.println(s);
		System.out.println("\nreaders:");
		for(String s: this.readers)
			System.out.println(s);
		System.out.println("\nwriters:");
		for(String s: this.writers)
			System.out.println(s);
	}

	public void addManualType(String string) {
		if(!types.contains(string))types.add(string);
	}
	
	
	public String getPrimitiveType(String functionname)
	{
		if(this.machineTypes.contains(functionname))
		{
			return "constructor";
		}
		if(this.logicFilters.contains(functionname))
		{
//			return "logic";
			return "math";
		}
		else if(this.mathFilters.contains(functionname))
		{
			return "math";
		}
		else if(this.primitivenames.contains(functionname))
		{
			if(functionname.contains("fork"))
			{
				return "replication";
			}
			else if(functionname.contains("replicate"))
			{
				return "replication";
			}
			else if(functionname.contains("move"))
			{
				return "movement";
			}
			else if(functionname.contains("kill"))
			{
				return "termination";
			}
			else if(functionname.contains("die"))
			{
				return "eradication";
			}
			else if(functionname.contains("instantiate"))
			{
				return "instantiation";
			}
			else{
				return "primitive";
			}
		}
		else if(this.readers.contains(functionname))
		{
			return "read";
		}
		else if(this.writers.contains(functionname))
		{
			return "write";
		}
		else if("val".contains(functionname))
		{
			return "valcreater";
		}
		else if("vec".contains(functionname))
		{
			return "valcreater";
		}
		else if("Bool".contains(functionname))
		{
			return "valcreater";
		}
		else if("bool".contains(functionname))
		{
			return "valcreater";
		}
		return "OTHER";
	}

	public void addAdditionalMachineTypes(String name) {
		machineTypes.add(name);
	}
	
	public boolean hasResonableBaseType(String basetype)
	{
		return machineTypes.contains(basetype);
	}
	
	
}
