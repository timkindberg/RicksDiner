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
	public class Chipv2 extends FlxSprite
	{
		[Embed(source = "data/cwalk_images_small.png")]
		private var ChipGraphic:Class;		
		
		private var speedAcceleration:int = 1000;		
		private var turnAroundMultiplier:int = 3;	
		private var jumpAcceleration:int = 1000;
		private var doubleJump:Boolean = false;
		private var jumpstart:Boolean;
		
		public function Chipv2(X:Number = 0, Y:Number = 0) 
		{	
			super(X, Y);
			drag.x = 1500;
			maxVelocity.x = 250;
			maxVelocity.y = 500
			acceleration.y = 800;
			loadGraphic(ChipGraphic, true, true);
			addAnimation("idle", [0]);
			addAnimation("run", [1, 2, 3, 4, 5, 6, 7, 8, 9], 15);
			//addAnimation("jumpstart", [7, 8, 9, 10, 11], 24, false);
			addAnimation("jump", [3]);
			addAnimation("fall", [4]);
			addAnimation("doubleJump", [8]);
		}
		
		override public function update():void
		{	
			if (justTouched(FLOOR)) doubleJump = false;
			
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
				if (FlxG.keys.justPressed("SPACE"))
				{ 				
					play("jumpstart");
					jumpstart = true;
					//if (frame == 11) 
					//{
						velocity.y = -maxVelocity.y
						jumpstart = false;
					//}
				}
				else
				{					
					jumpstart = false;
				}
			}
			else if (!doubleJump)
			{
				if (FlxG.keys.justPressed("SPACE"))
				{ 				
					play("doublejump");
					doubleJump = true;
					velocity.y = -maxVelocity.y * .7;
					
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