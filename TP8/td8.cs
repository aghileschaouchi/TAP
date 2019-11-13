using System;
using System.Linq;
using System.Collections.Generic;

/*
static IEnumerable<int> GetPrimes() {
  var index = 2;
  while (true) {
    if (IsPrime(index))
      yield return index;
    index++;
  }}
*/

class Program {

    public class Thread {
        public int Workload {get; set;}
        public int Pid      {get; private set;}
        private IEnumerator<int> Worker;  // An enumerator of the tasks
                                          // of the thread (represented by ints)
        static Random rng = new Random(); // Number generator in the class

	
        public IEnumerable<int> CreateWorker() {
            while(true) {
                Console.WriteLine("{0}", Pid);
                yield return (rng.Next()%10);
            }
        }
        public Thread() {
            Workload = 0;
            Pid      = rng.Next() % 100 + 100;  // Random pid number
            Worker   = this.CreateWorker().GetEnumerator();
        }
        public int Work() {
            int load = Worker.Current;
            Workload += load;
            Worker.MoveNext();
            return load;
        }
    }


    public static void Main() {
        List<Thread> lthread = new List<Thread>();
	    
	    for (int i = 0; i < 10; i++) {
		    lthread.Add(new Thread());
	    }
        Thread currWorker;        
        while (true) {
            // Recuperer le thread avec un Workload minimale utilisant un Aggregate
            // C'est possible d'utiliser l'instruction LINQ suivante: currWorker = lthread.Min(t => t.Workload);
            currWorker = lthread.Aggregate((current, next) => {
                if (next.Workload < current.Workload)
                    return next;
                else
                    return current;
            });
            currWorker.Work();
                    
            /* Dans cette méthode on utilise un foreach pour trouver
            le thread avec un Workload minimale

            min = lthread[0].Workload;
            currentWorker = lthread[0];
            
            foreach (Thread thread in lthread) {
            if (thread.Workload < min){
                min = thread.Workload;
                currentWorker = thread;
            }
            }
    Finir le code pour ordonnoncer les 10 threads
            */
        }
	
	    Console.WriteLine("Yield !"); }
}
 
