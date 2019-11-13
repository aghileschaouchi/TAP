using System;
using Gtk;

public class GtkHelloWorld {
    public delegate void Handler (object obj,EventArgs argsj);
    public static Handler cd = (object obj,EventArgs argsj) => Console.WriteLine("Bonjour je suis le délégué {0}.", obj);
    static void onClick (object obj, EventArgs args) {
       	Console.WriteLine("I have been clicked by a {0}", obj);
	//	cd(obj);
    }

    public static void Main() {
	Application.Init();
 
	//Create the Window
	Window myWin = new Window("Brave new world");
	myWin.Resize(200,200);
	HBox myBox = new HBox (false, 10);
	myWin.Add(myBox);

	// Set up a button object.
	Button hello = new Button ("Hello");
	Button ping = new Button ("Ping");
	Button pong = new Button ("Pong");
	hello.Clicked += new EventHandler((obj,args) =>{
		Console.WriteLine("I have been clicked by a {0}", obj);
	    });
	ping.Clicked += new EventHandler((obj,args) =>{
		ping.Sensitive = false;
		pong.Sensitive = true;
	    });
	pong.Clicked += new EventHandler((obj,args) =>{
		ping.Sensitive = true;
		pong.Sensitive = false;
	    });
	//myBox.Add(hello);
	myBox.Add(ping);
	myBox.Add(pong);
	//Show Everything     
	myWin.ShowAll(); 
	Application.Run(); }
}
