
 
using System;
using System.Collections.Generic;
using System.Linq;

class Program {
  private static List<string> people = new List<string>() 
  { 
    "Robert", "Roger", "Raymond", "Remi", 
    "Radicowl", "Ross", "Rififi", "Rossinante" 
  };

    public static B Fold<A,B> (B init, Func<B,A,B> f, IEnumerable<A> l) {
	B res = init;
	
	foreach (A a in l) {
	    res = f(res, a);
	}
	return res;
    }
    
  public static void Main() 
  {
    IEnumerable<string> query = from p in people select p;
    
    Console.WriteLine("------");
    foreach (string person in query) 
        Console.WriteLine(person);
    //2.2
    // fun p ->
    // fun p -> p.legnth > 5
    query = from p in people where p.Length > 5 orderby p.Length descending select p;
    //2.3
    //En Ocaml Select : ('a list)->('a->int->'b)->('b list)
    IEnumerable<string> queryM =
	people.Where(p => p.Length > 5).OrderByDescending(p => p.Length);
    
    Console.WriteLine("------");
    foreach (string person in queryM) 
        Console.WriteLine(person);
    //2.3 Un style ou on fait de la composition, Un list au quel on compose un Where, au quel on compose un OrderBy etc..., les avantages : plus fléxible, plus proche du langage, dans le premier cas on est limité a la syntaxe, dans le deuxieme cas on est au niveau du langage, on peut mettre n'importe quelle lambda expression, plus compréhensible  
    //2.4

  }
}
