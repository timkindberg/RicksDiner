package com.picklewars.ricksdiner 
{
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	import org.flixel.system.FlxAnim;
	
	/**
	 * ...
	 * @author Tim Kindberg
	 */
	public class Chip extends FlxSprite
	{
		[Embed(source = "data/chip1.png")]
		private var ChipGraphic:Class;	
		
		[Embed(source = "data/cwalkright.png")]
		private var ChipWalkRight:Class;	
		
		[Embed(source = "data/chipframes_small.png")]
		private var ChipAnimationGraphics:Class;	
		
		
		private var speedAcceleration:int = 1000;		
		private var turnAroundMultiplier:int = 3;	
		private var jumpAcceleration:int = 1000;
		private var doubleJump:Boolean = false;
		private var jumpstart:Boolean;
		
		public function Chip(X:Number = 0, Y:Number = 0) 
		{	
			super(X, Y);
			drag.x = 1500;
			maxVelocity.x = 250;
			maxVelocity.y = 500
			acceleration.y = 800;
			loadGraphic(ChipAnimationGraphics, true, true);
			addAnimation("idle", [0]);
			addAnimation("run", [1, 2, 3, 4, 5, 6, 5, 4, 3, 2, 1], 12);
			addAnimation("jumpstart", [7, 8, 9, 10, 11], 24, false);
			addAnimation("jump", [12]);
			addAnimation("fall", [13]);
		}
		
		override public function update():void
		{	
			
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
			if (isTouching(FlxObject.FLOOR) )
			{
				if (FlxG.keys.pressed("SPACE"))
				{ 				
					play("jumpstart");
					jumpstart = true;
					if (frame == 11) 
					{
						velocity.y = -maxVelocity.y
						jumpstart = false;
					}
				}
				else
				{					
					jumpstart = false;
				}
			}
			
			
			if (!jumpstart)
			{
				if (velocity.y < 0) 
				{ 
					play("jump");
				}
				else if (velocity.y > 0)
				{
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
			
			
			
			super.update();
		}
		
	}

}