package Analysis;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.util.Vector;

import DataStructure.javaDNA.DNA;
import DataStructure.javaDNA.Machine;
import DataStructure.javaDNA.Statement;

public class NeedlemanWunsch {
    public static final int inclusion = -5;
    public static final int unequal = -10;
    public static final int sametype = 8;  
  

	public static void PrintMatrix(Vector<Statement> a, Vector<Statement> b) {
		int[][] ar = calculateMatrix(a, b);
		
		for (int y = 0; y < ar.length; y++)
		{
		    System.out.println("");
		    for (int x = 0; x < ar[y].length; x++)
		        System.out.print(ar[y][x] +"\t ");
		}
	}
    
//    public static void getAlignments(Vector<Statement> sA, Vector<Statement> sB)
//    {
//    	int[][]ar = calculateMatrix(sA, sB);
//        String alA = "";
//        String alB = "";        
//        int i = sA.length();
//        int j = sB.length();
//        while (i > 0 && j > 0)
//        {
//            int score = ar[i][j];
//            int scorediag = ar[i-1][j-1];
//            int scoreup = ar[i][j-1];
//            int scoreleft = ar[i-1][j];
//            if (score == scorediag + simular(sA.charAt(i-1), sB.charAt(j-1)))
//              {
//                alA = sA.charAt(i-1) + alA;
//                alB = sB.charAt(j-1) + alB;
//                i--;j--;                
//              }
//            else if (score == scoreleft + inclusion)
//            {
//                alA = sA.charAt(i-1) + alA;
//                alB = "-" + alB;
//                i--;
//            }
//            else if(score == scoreup + inclusion)
//            {
//                alA = "-" + alA;
//                alB = sB.charAt(j-1) + alB;
//                j--;
//            }
//        }
//        while(i > 0)
//        {
//            alA = sA.charAt(i - 1) + alA;
//            alB = "-" + alB;
//            i--;            
//        }
//        while(j > 0)
//        {
//            alA = "-" + alA;
//            alB = sB.charAt(j - 1) + alB;
//            j--;            
//        }
//        System.out.println(alA+"\n");
//        System.out.println(alB+"\n");
//    }
    
    public static int similarityValue(Vector<Statement> source, Vector<Statement> dest)
    {
    	int [][] iii = calculateMatrix(source,dest);
    	int k = iii.length-1;
    	int y =  iii[0].length-1;
    	return iii[k][y];
    }
    
    public static int[][] calculateMatrix(Vector<Statement> source, Vector<Statement> dest)
    {
    	
        int[][] res = new int[source.size()+1][dest.size()+1];
        for (int y = 0; y < source.size(); y++)
            res[y][0] = inclusion * y;
        
        
        for (int x = 0; x < dest.size(); x++)
            res[0][x] = inclusion * x;
        
        for (int y = 1; y < source.size() + 1; y++)
            for (int x = 1; x < dest.size() +1; x++)
                {                    
                    int k = res[y-1][x-1] + similarity(source.get(y-1) , dest.get(x-1));
                    int l = res[y-1][x] + inclusion;
                    int m = res[y][x-1] + inclusion;
                    k = Math.max(k,l);
                    res[y][x] = Math.max(k,m);
                }
        return res;
    }

    
    public static int similarity(Statement a,Statement b)
    {
    	return a.similarity(b);
    }
    
    public static void generateSimilarityMatrixOfMachines(DNA dna, PrintStream out)
    {
    	out.print(" ;");
    	for(Machine m2: dna.machines)
    	{
    		out.print(m2.name+";");
    	}
    	out.println();
    	for(Machine m1: dna.machines)
    	{
    		out.print(m1.name+";");
    		for(Machine m2: dna.machines)
    		{

    			int f =  m1.similarity(m2);
    			out.print(f+";");
    		}
    		out.println();
    	}
  
    }
    
    public static void makeClusters(DNA dna, double a)
    {
    	Vector<Machine> allmach = new Vector<Machine>();
    	for(Machine m : dna.machines)
    	{
    		if(!m.isabstract)
    		{
    			allmach.add(m);
    		}
    	}
    	int numC = 0;
    	while(allmach.size()!=0)
    	{
    		Machine m =  allmach.remove(0);
    		System.out.println("cluster:"+numC);
    		System.out.println("   -"+m.name);
    		
    		int max =  m.similarity(m);
    		findAllClose(m, allmach, max,a);
    		numC++;
    	}
    }
    
    private static void findAllClose(Machine m,Vector<Machine> allmach,int max, double a) 
    {
    	
    	Vector<Machine> machs = new Vector<Machine>();
    	for(int i = 0;i<allmach.size();i++)
		{
    		Machine m2 =allmach.get(i);
    		double sim = m.similarity(m2);
    		if((1.0/max*sim)>a)
    		{
    			machs.add(allmach.get(i));
    			allmach.remove(i);
    			i =0;
    			System.out.println("   -"+m2.name);
    		}
		}
    	for(Machine m1 :machs)
    	{
    		int maxs =  m1.similarity(m1);
    		findAllClose(m1,allmach,maxs,a);
    	}
    	
    }
    
    
}