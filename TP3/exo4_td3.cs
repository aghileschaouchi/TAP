using System;
using System.Collections.Generic;

class Program {
  /* Exercice 4: Programmation générique en C# */
      /* 4.1 */
    /* Nous déclarons un délégué qui renvoie un objet de type 'TOut' et ceci en utilisant la généricité de C#. 
       MapFunc contient une variable de type 'TOut' (qui, dans notre cas, est évalué à 'int') ainsi qu'une variableT (qui, dans notre cas, est un KeyValuePair).
       Après appel dans le main à Map(list, i => i.Key) le délégué que nous avons déclaré pointe sur la lambda expression 'i => i.Key' avec i de type T et i.Key de type TOut.
       A chaque tour de boucle, on ajoute l'élément T de la liste dans la liste de sortie.
     */
    public delegate TOut MapFunc<T,TOut>(T element);
    /* fonction Map  */
    public static List<TOut> Map<T, TOut> (List<T> list, MapFunc<T,TOut> mapFunc) {
  
        List<TOut> tmpList = new List<TOut>();
      
        foreach (T i in list){
          tmpList.Add(mapFunc(i));
        }

        return tmpList;
    }
    /* 4.2 : dictionnaire */
    public delegate TOut DicFunc<V,T>(T element);
    public static Dictionary<T,List<U>> ToDictionary<T,U> (List<V> list, MapFunc<V,T> mapFunc1,MapFunc<V,T> mapFunc2) {
     Dictionary<T,List<U>> tmpDic = new Dictionary<T,List<U>>();

      /* Parcourir tous les elements de list */
      foreach (V keyval in list){
        List<U> values;
          /* si le dictionnaire contient déjà la clé */
	if(tmpDic.ContainsKey(mapFunc1(keyval))){
             tmpDic.TryGetValue(mapFunc1(keyval), out values);  /* récupérer la liste des valeurs déjà existantes du dictionnaire */         
             values.Add(mapFunc2(keyval)); /* y ajouter la nouvelle valeur */
             tmpDic[mapFunc1(keyval)] = values; /* mettre a jour la liste des valeurs */
          }
          else {
            values = new List<U>(); /* créer une nouvelle liste des valeurs */
            values.Add(mapFunc2(keyval)); /* y ajouter la valeur */         
            tmpDic.Add(mapFunc1(keyval),values); /* ajouter au dictionnaire */
          }
      }

      return tmpDic;
    }
    
  public static void Main() {
    // Create an association list
    List<KeyValuePair <int,string>> list = new List<KeyValuePair <int,string>>();

    // Fill it with interesting values
    list.Add(new KeyValuePair<int, string>(1,"un"));
    list.Add(new KeyValuePair<int, string>(7,"sept"));
    list.Add(new KeyValuePair<int, string>(1,"uno"));

    
    // Get a collection of the keys (names). 
    List<int> keys = Map(list, i => i.Key);

    // Print the values
    foreach (int k in keys)
      Console.WriteLine("{0} : {1}", k, list.Find( i => (i.Key == k)).Value);  
    Console.WriteLine("---- Transformation de la liste en dictionnaire ----");  

    Dictionary<int, List<string>> dico = ToDictionary(list, i => i.Key, i => i.Value );

    foreach (KeyValuePair<int, List<string>> i in dico){
       Console.Write("{0} :", i.Key);  
       foreach(string s in i.Value)
       Console.Write("{0} ", s);  
       Console.WriteLine(""); /* retour a la ligne */
    }
  }
}
 
