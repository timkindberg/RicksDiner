package com.picklewars.ricksdiner 
{
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxTileblock;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxU;
	import org.flixel.plugin.photonstorm.FlxCollision;
	
	/**
	 * ...
	 * @author Tim Kindberg
	 */
	public class TestChipStateFlatWalk extends FlxState
	{	
		[Embed(source = "data/cwalkright.png")]
		private var LevelGraphics:Class;		
		
		private var chip:Chipv2;
		private var floor:FlxTileblock;
		private var level:FlxGroup;
		private var wall:FlxTileblock;
		private var enemy:FlxSprite;
		
		public function TestChipStateFlatWalk() 
		{
			super();
		}
		
		override public function create():void
		{
			level = new FlxGroup();
			
			FlxG.bgColor = 0xffaaaaaa;
			
			/*var back:FlxSprite = new FlxSprite(0, 0);
			back.makeGraphic(5000, 600);
			add(back);*/			
			
			chip = new Chipv2(300, 600 - 59 - 50 - 100);
			add(chip);
			
			// FLOOR
			floor = new FlxTileblock(0, 550, 5000, 50);
			floor.makeGraphic(5000, 50, 0xFF000000);
			level.add(floor);				
			
			// WALLS
			/*wall = new FlxTileblock(0, 0, 5, 600);
			wall.makeGraphic(5, 600, 0xFF000000);
			level.add(wall);	
			
			wall = new FlxTileblock(4995, 0, 5, 600);
			wall.makeGraphic(5, 600, 0xFF000000);
			level.add(wall);*/
					
			add(level);
			
			enemy = new FlxSprite(100, 400);
			enemy.makeGraphic(64, 64, 0xFFFF0000);
			//enemy.acceleration.y = 800;
			enemy.drag.x = 2000;
			enemy.immovable = true;
			add(enemy);
			
			//FlxG.camera.follow(chip, FlxCamera.STYLE_PLATFORMER);
			//FlxG.camera.setBounds(0, 0, 5000, 600);
			FlxG.bgColor = 0xffaaaaaa;
			
		}
		
		override public function update():void
		{
			FlxG.collide(chip, level)		
			FlxG.collide(enemy, chip)			
			FlxG.collide(enemy, level)						
			super.update();
		}
		
		private function enemyCollide(chip:Chipv2, enemy:FlxSprite):void 
		{
			
		}
		
		
	}

}