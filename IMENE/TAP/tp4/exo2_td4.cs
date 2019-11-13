 
using System;
using System.Collections.Generic;
using System.Linq;

class Program {
  private static List<string> people = new List<string>() 
  { 
    "Robert", "Roger", "Raymond", "Remi", 
    "Radicowl", "Ross", "Rififi", "Rossinante" 
  };

  public static void Main() 
  {
    IEnumerable<string> query = from p in people select p;
    Console.WriteLine("------");
    foreach (string person in query) 
        Console.WriteLine(person);

    /* 2.1 */
    query = from p in people where (p.Length>5) orderby p descending select p ;
    Console.WriteLine("---length > 5 ---");
    foreach (string person in query) 
        Console.WriteLine(person);
  
    /* 2.2 */
    IEnumerable<string> queryM  = people.Where( p => p.Length>5).OrderByDescending(p => p.Length);
    Console.WriteLine("---Q2 ---");
    foreach (string person in queryM) 
        Console.WriteLine(person);
/*aggregate == reduce
    Select ==  map */
/* 2.3 : "from p in ..." on est restreint. on les plus <<flexible>> avec le langage (not the full answer).
les deux sont des syntaxes. la première: pas de lambdas. la deuxieme: a l'interieur du langage, on peut mettre n'importe quel lambda exp
*/
/* 2.5 : ne pas faire le ienumerator */
    
    string foldres = Fold (...);
/* 2.4 */
/*fold renvoie un B. */
 }
  public static B Fold<A,B>(B init, Func<B,A,B> f, IEnumerable<A> l){
    B res = init;
    foreach(A a in l)
      res = f(res,a); /*res est un param de A */

    return res;
  }
}