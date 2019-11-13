using System;
using Gtk;

public class GtkHelloWorld {
  static void onClick (object obj, EventArgs args) {
    Console.WriteLine("I have been clicked by a {0}", obj); }

  public static void Main() {
    Application.Init();
 
    //Create the Window
    Window myWin = new Window("Brave new world");
    myWin.Resize(200,200);
    HBox myBox = new HBox (false, 10);
    myWin.Add(myBox);

    // Set up a button object.
    Button ping = new Button ("Ping");
    Button pong = new Button ("Pong");
    ping.Clicked += new EventHandler((obj, args) => {Console.WriteLine("I have been clicked by a {0}", obj);
    pong.Sensitive = true;
    ping.Sensitive = false;
});
// les refs Ping et Pong de sont enfermé dans les Handler
// Ma référe,ce est de tyê faobme car cema caues des effets de bords lors de son execution, cela n'est pas portable donc
// Pas de transparence referentielle puisque il y'a un lien entre les deux objets

    pong.Clicked += new EventHandler((obj, args) => {Console.WriteLine("I have been clicked by a {0}", obj);
    ping.Sensitive = true;
    pong.Sensitive = false;
});
    myBox.Add(ping);
    myBox.Add(pong);

    //Show Everything     
    myWin.ShowAll(); 
    Application.Run(); }
}
 
// mcs -pkg:gtk-sharp-2.0 fichier.cs && mono fichier.exe