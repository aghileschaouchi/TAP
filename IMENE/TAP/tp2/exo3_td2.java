import java.util.Arrays;
import java.util.List;

class Functional {

    public void sortList(List<Integer> lis){
		lis.forEach(item -> {
			
			//System.out.println(item);
	    });
    }
    public static void main(String[] args) {
	List<Integer> lis   = Arrays.asList(7,4,666,9,41,5);
	// default void    forEach(Consumer<? super T> action)
	/*lis.forEach(item -> {
		System.out.println(item);
		});*/
    };
}
