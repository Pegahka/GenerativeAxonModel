import java.util.ArrayList;

public class NeedlemanWunsch {
    public static final int A=0, G=1, C=2, T=3;
    public static final int d = -5;
                                   // A    G   C   T   
    public static void main(String[] arg)
    {
//        int[] ar = NeedlemanWunsch.convertStringToArr("TCGAAGCT");        
//        System.out.println(ar);
    		String a = "HA komischi gehts";
    		String b = "ua komischis";
    		
            //int[][] ar = PrintMatrix(a, b);
            
            System.out.println("");
            getAlignments(a,b);
    }

	private static void PrintMatrix(String a, String b) {
		int[][] ar = NeedlemanWunsch.calculateMatrix(a, b);
		
		for (int y = 0; y < ar.length; y++)
		{
		    System.out.println("");
		    for (int x = 0; x < ar[y].length; x++)
		        System.out.print(ar[y][x] +"\t ");
		}
	}
    
    public static void getAlignments(String sA, String sB)
    {
    	int[][]ar = NeedlemanWunsch.calculateMatrix(sA, sB);
        String alA = "";
        String alB = "";        
        int i = sA.length();
        int j = sB.length();
        while (i > 0 && j > 0)
        {
            int score = ar[i][j];
            int scorediag = ar[i-1][j-1];
            int scoreup = ar[i][j-1];
            int scoreleft = ar[i-1][j];
            if (score == scorediag + simular(sA.charAt(i-1), sB.charAt(j-1)))
              {
                alA = sA.charAt(i-1) + alA;
                alB = sB.charAt(j-1) + alB;
                i--;j--;                
              }
            else if (score == scoreleft + d)
            {
                alA = sA.charAt(i-1) + alA;
                alB = "-" + alB;
                i--;
            }
            else if(score == scoreup + d)
            {
                alA = "-" + alA;
                alB = sB.charAt(j-1) + alB;
                j--;
            }
        }
        while(i > 0)
        {
            alA = sA.charAt(i - 1) + alA;
            alB = "-" + alB;
            i--;            
        }
        while(j > 0)
        {
            alA = "-" + alA;
            alB = sB.charAt(j - 1) + alB;
            j--;            
        }
        System.out.println(alA+"\n");
        System.out.println(alB+"\n");
    }
    
    public static int[][] calculateMatrix(String source, String dest)
    {
        int[][] res = new int[source.length()+1][dest.length()+1];
        for (int y = 0; y < source.length(); y++)
            res[y][0] = d * y;
        
        
        for (int x = 0; x < dest.length(); x++)
            res[0][x] = d * x;
        
        for (int y = 1; y < source.length() + 1; y++)
            for (int x = 1; x < dest.length() +1; x++)
                {                    
                    int k = res[y-1][x-1] + simular(source.charAt(y-1) , dest.charAt(x-1));
                    int l = res[y-1][x] + d;
                    int m = res[y][x-1] + d;
                    k = Math.max(k,l);
                    res[y][x] = Math.max(k,m);
                }
        return res;
    }

    
    public static int simular(char a, char b)
    {
        if(a==b) return -10;
        return 3;
    }
    
    
}