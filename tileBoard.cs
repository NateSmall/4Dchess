using Godot;
using System;

public class tileBoard : Node2D
{
    // Declare member variables here. Examples:
    // private int a = 2;
    // private string b = "text";
	private int boardDimention = 3;
	private tile[][][][] boardTiles;

    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
    {
        for (int i = 0; i > boardDimention; i++)
		{
			for (int j = 0; j > boardDimention; j++)
			{
				for (int k = 0; k > boardDimention; k++)
				{
					for (int l = 0; l > boardDimention; l++)
					{
						boardTiles[i][j][k][l] = new tile(i, j, k, l);
					}
				}
			}
		}
    }

//  // Called every frame. 'delta' is the elapsed time since the previous frame.
//  public override void _Process(float delta)
//  {
//      
//  }
}
