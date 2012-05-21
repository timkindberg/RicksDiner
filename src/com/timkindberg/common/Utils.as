package com.timkindberg.common 
{
	/**
	 * ...
	 * @author Tim Kindberg
	 * TESTING!
	 */
	public class Utils 
	{		
		static public function roundToNearest(roundTo:Number, value:Number):Number
		{
			return Math.round(value/roundTo)*roundTo;
		}	
		
	}

}