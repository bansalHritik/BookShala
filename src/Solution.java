// Java Program to find n'th fibonacci
// Number with O(Log n) arithmetic operations
import java.util.Scanner;;

class Solution {
	static void fib(long f[]) 
    { 
        f[0] = 0; 
        f[1] = 1;  
        for (int i = 2; i <= 59; i++) 
            f[i] = (f[i - 1] + f[i - 2]) % 10; 
    } 
 
    static long findLastDigit(long n) 
    { 
        long f[] = new long[60]; 
  
        // Precomputing units digit of  
        // first 60 Fibonacci numbers 
        fib(f); 
      
        long index = (n % 60L);  
  
        return f[(int)index]; 
    } 
	public static long log(long x, int b)
	{
	    return (long) (Math.log(x) / Math.log(b));
	}
	public static void main(String[] args)
	{
    Scanner sc = new Scanner(System.in);
    int tc;
    tc = sc.nextInt();
    while(tc-- >0)
    {
        long num;
        num = sc.nextLong();
        long index = log(num,2);
        index = (long) Math.pow(2, index);
        long sol = findLastDigit(index-1);
		System.out.println(sol);
	}
    sc.close();
}
}

