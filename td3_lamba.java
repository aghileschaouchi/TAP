import java.util.Arrays;
import java.util.List;

//Consumer<T> <=> T -> unit <=>  Func(T,void)
//Supplier<T> <=> unit -> T <=> Func<T>
//Predicate<T> <=> T -> bool <=> Func<T,bool>
//<? super E> : wildcard, forme de polymorphisme

/*
(y) -> y+y;
@FunctionInterface
interface OneInt{
    int f(int x, object o, String s)
}
*/

//Dans java8 on peut specifier des fonctions dans une interface

class Functional {

    public static void main(String[] args) {
	List<Integer> lis   = Arrays.asList(7,4,666,9,41,5);
	// default void    forEach(Consumer<? super T> action)

    liS.forEach((e) -> {System.out.println(e);});
    }
}