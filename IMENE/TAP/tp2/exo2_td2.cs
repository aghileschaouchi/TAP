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


    //délégué: Mul: multiplication de 2 entiers
    public delegate void Mul (int i1, int i2); //définition de type
    public static Mul m = (a, b) => Console.WriteLine(a*b); //définition de valeur(ici une fonction)

    public delegate void ApplyMul ( Mul m ,int i1, int i2);
    public static ApplyMul a= (m,a,b) => m(a,b);
    
    public static void Main() {
	Console.WriteLine("Caramel !");
	c ("Hello ","world");
	a(m, 5, 3);
    }
}
