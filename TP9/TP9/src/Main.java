import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Main {

	public static void main(String[] args) {
		/*
		 *** Variance**** toto(C <?extends T> D <?super T>)
		 * 
		 * 
		 */

		
		
		List<Number> num_list  = Arrays.asList(1,2,3);
		List<Integer> int_list = num_list;   //NOT OK : type mismatch
		
		int_list  = Arrays.asList(1,2,3);
		List<? extends Number> n_list = int_list;  // OK
		n_list.add(new Float(3.14));               // NOT OK
		
		/* avec les arrays */
		Integer [] i_array = {4,5,6};
		Number [] n_array = i_array;
		n_array[0] = new Float(3.14);       //NOT OK : exception (java.lang.ArrayStoreException: java.lang.Float)		
		
		System.out.println(n_array[0]);
		
		int_list = new ArrayList<Integer>();       // OK
		
		/* */
		
	}

	
	public class Fruit {

	}

	public class Orange extends Fruit{

	}
}
