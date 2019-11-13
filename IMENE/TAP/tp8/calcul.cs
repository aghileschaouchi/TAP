using System;
using System.Linq;
using System.Collections.Generic;


/*static IEnumerable<int> GetPrimes() {
  var index = 2;
  while (true) {
    //if (IsPrime(index))
     if(index%2 == 0) 
      yield return index; // renvoie des entiers dans une boucle infinie. Elle peut être évaluée a un autre moment
    index++;
  }}*/

/* ordonnanceur: a chaque tour */

class Program {
    public class Thread {
        public int Workload {get; set;}
        public int Pid      {get; private set;}
        private IEnumerator<int> Worker;  // An enumerator of the tasks
                                          // of the thread (represented by ints)
        static Random rng = new Random(); // Number generator in the class
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

        public IEnumerable<int> CreateWorker() {
        	while (true){
        		Console.WriteLine("I'm a new thread with Pid={0}",Pid);
        		yield return rng.Next() % 100 + 100;
        	}
        }
    }

    public static void Main() { 
    	List<Thread> list_of_threads;
    	
    	

		list_of_threads = new List<Thread>();

		/* Creation de 10 threads */
    	for(int i=0;i<10;i++){
    		list_of_threads.Add(new Thread());
    	}

	    while(true){
	    	/* Trouver le thread avec le workload le plus petit*/
	    	Thread lowest_work_thread=list_of_threads[0];
			/*Methode 1 : boucle */
			 foreach(Thread th in list_of_threads){
			 	if(th.Workload < lowest_work_thread.Workload)
			 		lowest_work_thread = th;
			 	}
			 /*Methode 2 : requete */
			 /*IEnumerable<Thread> l = from t in list_of_threads
			 OrderBy Workload select t;*/
			 /* Faire travailler le thread avec le workload min */
			 lowest_work_thread.Work();
			}

    }
}
 
