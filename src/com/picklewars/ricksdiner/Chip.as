package com.picklewars.ricksdiner 
{
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxU;
	import org.flixel.system.FlxAnim;
	
	/**
	 * ...
	 * @author Tim Kindberg
	 */
	public class Chip extends FlxSprite
	{
		[Embed(source = "data/cwalk_images_small.png")]
		private var ChipGraphic:Class;		
		
		private var speedAcceleration:int = 1000;		
		private var turnAroundMultiplier:int = 3;	
		private var jumpAcceleration:int = 1000;
		private var doubleJump:Boolean = false;
		private var jumpstart:Boolean;
		private var djText:FlxText;
		private var state:FlxState;
		
		public function Chip(X:Number = 0, Y:Number = 0) 
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
			
			/*djText = new FlxText( -100, -100, 200, "DOUBLE JUMP!");
			djText.drag.x = 500;
			djText.drag.y = 500;
			state.add(djText);*/
			
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
					doubleJump = true;
					velocity.y = -maxVelocity.y * .7;
					
					/*djText.x = x;
					djText.y = y;*/
				}
			}
			
			
			if (!jumpstart)
			{
				if (velocity.y < 0) 
				{ 
					if (doubleJump) play("doubleJump")
					else play("jump");
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