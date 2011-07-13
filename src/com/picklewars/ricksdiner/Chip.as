package com.picklewars.ricksdiner 
{
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import org.flixel.FlxU;
	import org.flixel.system.FlxAnim;
	
	/**
	 * ...
	 * @author Tim Kindberg
	 */
	public class Chip extends FlxSprite
	{
		[Embed(source = "data/cimages.png")]
		private var ChipSprites:Class;	
		
		private var speedAcceleration:int = 1000;		
		private var turnAroundMultiplier:int = 3;	
		private var jumpAcceleration:int = 1000;
		private var doubleJump:Boolean = false;
		private var jumpstart:Boolean;
		private var landing:Boolean;
		
		public function Chip(X:Number = 0, Y:Number = 0) 
		{	
			super(X, Y);
			drag.x = 1500;
			maxVelocity.x = 250;
			maxVelocity.y = 800;
			acceleration.y = 500;
			loadGraphic(ChipSprites, true, true, 64, 64);
			addAnimation("idle", [0]);
			addAnimation("run", [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 20);
			addAnimation("jumpstart", [11, 12, 13], 15, false);
			addAnimation("jump", [14]);
			addAnimation("fall", [15]);
			addAnimation("land", [16, 17], 8, false);		
			
		}
		
		override public function update():void
		{	
			
			if (justTouched(FLOOR)) 
			{
				play("land");
				landing = true;
			}
			
			//MOVEMENT
			acceleration.x = 0;
			if(FlxG.keys.LEFT)
			{
				facing = LEFT;
				acceleration.x -= drag.x;
			}
			else if(FlxG.keys.RIGHT) 
			{ 
				facing = RIGHT;
				acceleration.x += drag.x;
			}
			if (isTouching(FLOOR) )
			{
				if (FlxG.keys.SPACE)
				{ 				
					play("jumpstart");
					jumpstart = true;					
				}
				else
				{					
					jumpstart = false;
				}
			}
			
			
			if (jumpstart && frame == 13)
			{
				velocity.y = -maxVelocity.y
				jumpstart = false;				
			} 
			
			if (!jumpstart && !landing)
			{
				if (velocity.y < 0) 
				{ 
					maxVelocity.y = 500;
					play("jump");
				}
				else if (velocity.y > 0)
				{
					maxVelocity.y = 800;
					play("fall");
				}
				else if (velocity.x != 0)
				{
					play("run");
				}
				else
				{
					play("idle");
				}
			}
			
			if (landing && frame == 17) 
			{
				landing = false;
			}
			
			super.update();
		}
		
	}

}