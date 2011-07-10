package com.picklewars.ricksdiner
{
	import org.flixel.FlxGame;
	
	[SWF(backgroundColor="#FFFFFF")]
	/**
	 * ...
	 * @author Tim Kindberg
	 */
	public class Main extends FlxGame 
	{
		
		public function Main():void 
		{
			super(600, 600, TestChipStateFlatWalk, 1, 60, 30, true);
		}
		
	}
	
}