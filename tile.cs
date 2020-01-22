using Godot;
using System;

public class tile : Sprite
{
    // Declare member variables here. Examples:
    // private int a = 2;
    // private string b = "text";
	private int xPos;
	private int yPos;
	private int zPos;
	private int wPos;
	private bool filled;
	
	public tile(int xPos, int yPos, int zPos, int wPos)	{
		int this.xPos = xPos;
		int this.yPos = yPos;
		int this.zPos = zPos;
		int this.wPos = wPos;
		bool this.filled = false;
	}
	
	public isFilled()	{
		return filled;
	}

    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
    {
		Vector2 screenPosition = Vector2(this.xPos * 2 + this.wPos * 10, this.zPos * 10 + this.yPos * 2);
        set_offset(screenPosition);
    }

//  // Called every frame. 'delta' is the elapsed time since the previous frame.
//    public override void _Process(float delta)
//    {      
		
//    }
}
