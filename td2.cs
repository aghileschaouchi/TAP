using System;
class Program {
  
    // Type declaration
    public delegate int OneInt (int value);
    // Anonymous function
    public static OneInt square = new OneInt(i => i*i);
    // One-time declaration using predefined type
    public static Func<int, int> cube = i => i*i*i;
    // Delegate using multiple arguments
    public delegate void Concat (string s1, string s2);
    public static Concat c = (a,b) => Console.WriteLine(a+b);

    public delegate int ToInt (int x, int y);
    public static ToInt mul = (x,y) => x*y;
    public static ToInt add = (x,y) => x+y;
    
    public delegate int Apply (int x, int y, ToInt f);
    public static Apply a = (x,y,f) => f(x,y);
    
    public static void Main() {
	Console.WriteLine("Caramba !");
	//c("TEST", "TEST");
	Console.WriteLine(a (1, 2, add));
    }
} 

