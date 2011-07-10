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
			super(5000, 300, TestChipStateFlatWalk, 2);
		}
		
	}
	
}