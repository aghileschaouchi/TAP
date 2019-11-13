using System;
using System.Collections.Generic;

class Program {
  /* Exercice 4: Programmation générique en C# */
      /* 4.1 */
    public delegate TOut MapFunc<T,TOut>(T element);
    /* fonction Map  */
    public static List<TOut> Map<T, TOut> (List<T> collection, MapFunc<T,TOut> mapFunc) {
  
        List<TOut> tmpList = new List<TOut>();
      
        foreach (T i in collection){
          tmpList.Add(mapFunc(i));
        }

        return tmpList;
    }
    /* 4.2 : dictionnaire */
    public static Dictionary<T,List<U>> ToDictionary<T,U> (List<KeyValuePair<T,U>> list) {
     Dictionary<T,List<U>> tmpDic = new Dictionary<T,List<U>>();

      /* Parcourir tous les elements de list */
      foreach (KeyValuePair<T,U> keyval in list){
        List<U> values;
          /* si le dictionnaire contient déjà la clé */
          if(tmpDic.ContainsKey(keyval.Key)){
             tmpDic.TryGetValue(keyval.Key, out values);  /* récupérer la liste des valeurs déjà existante du dictionnaire */         
             values.Add(keyval.Value); /* y ajouter la nouvelle valeur */
             tmpDic[keyval.Key] = values; /* mettre a jour la liste des valeurs */
          }
          else {
            values = new List<U>(); /* créer une nouvelle liste des valeurs */
            values.Add(keyval.Value); /* y ajouter la valeur */         
            tmpDic.Add(keyval.Key,values); /* ajouter au dictionnaire */
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
    Dictionary<int, List<string>> dico = ToDictionary(list);

    foreach (KeyValuePair<int, List<string>> i in dico){
       Console.Write("{0} :", i.Key);  
       foreach(string s in i.Value)
            Console.Write("{0} ", s);  
        Console.WriteLine(""); /* retour a la ligne */
    }
  }
}
 
