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
		private var doubleJump:Boolean;
		private var jumpstart:Boolean;
		private var landing:Boolean;
		private var punch:int = 1;
		private var punching:Boolean;
		private var punchWindow:int = 0;
		private var jumping:Boolean;
		
		
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
			addAnimation("punch1", [18, 19, 19, ], 15, false);		
			addAnimation("punch2", [20, 21, 21], 15, false);		
			addAnimation("kick", [22, 23], 15, false);	
		}
		
		override public function update():void
		{					
			handleMovement();
			
			handleJump();
			
			handleLanding();
			
			handleGroundAttack();						
			
			super.update();
		}
		
		private function handleGroundAttack():void 
		{
			trace("punchWindow:", punchWindow);
			punchWindow--;
			if (punchWindow < 0) punchWindow = 0;
			
			if (punching && finished) 
			{
				punching = false;				
				trace("!!!!punchWindow:", punchWindow);
			}
			
			if (!punching && velocity.y == 0 && FlxG.keys.justPressed("X")) 
			{				
				if (punchWindow == 0)
				{
					play("punch1");
					punching = true;
					punch = 2;
					punchWindow = 30;					
				}
				else if (punchWindow > 0)
				{
					if (punch == 2) 
					{
						play("punch2");
						punching = true;
						punch = 3;
						punchWindow = 30;
					}
					else if (punch == 3) 
					{
						play("kick");
						punching = true;
						punch = 1;
						punchWindow = 15;
					}	
				}								
			}		
		}
		
		
		private function handleLanding():void 
		{
			if (justTouched(FLOOR)) 
			{
				play("land");
				landing = true;
			}
			
			if (landing && finished) 
			{
				landing = false;
			}
		}		
		
		private function handleJump():void 
		{
			if (isTouching(FLOOR))
			{
				if (!jumpstart && FlxG.keys.justPressed("UP"))
				{ 				
					play("jumpstart");
					landing = false;
					jumpstart = true;					
				}
			}
			
			if (jumpstart && !FlxG.keys.pressed("UP"))
			{
				jumpstart = false;
			}
			
			if (jumpstart && finished)
			{
				trace("velocity.y:", jumpstart, frame, landing);
				jumpstart = false;
				jumping = true;
				maxVelocity.y = 500;
				velocity.y = -maxVelocity.y				
			} 
		}
		
				
		private function handleMovement():void 
		{
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
			
			if (!jumpstart && !landing && !punching)
			{
				if (velocity.y < 0) 
				{ 
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
		}
		
	}

}