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
    Button hello = new Button ("Hello");
    hello.Clicked += (obj, args) => Console.WriteLine("I have been clicked by a {0}", obj);
    myBox.Add(hello);

    //Show Everything     
    myWin.ShowAll(); 
    Application.Run(); }
}
 
// mcs -pkg:gtk-sharp-2.0 fichier.cs && mono fichier.exe
