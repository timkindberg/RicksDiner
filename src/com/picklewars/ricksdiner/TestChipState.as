package com.picklewars.ricksdiner 
{
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxTileblock;
	import org.flixel.FlxU;
	
	/**
	 * ...
	 * @author Tim Kindberg
	 */
	public class TestChipState extends FlxState
	{		
		private var chip:Chip;
		private var floor:FlxTileblock;
		private var level:FlxGroup;
		private var wall:FlxTileblock;
		
		public function TestChipState() 
		{
			super();
		}
		
		override public function create():void
		{
			level = new FlxGroup();
			
			var back:FlxSprite = new FlxSprite(0, 0);
			back.makeGraphic(600, 1800);
			add(back);			
			
			chip = new Chip(300, 600 - 59 - 50 - 100);
			add(chip);
			
			// FLOOR
			floor = new FlxTileblock(0, 550, 100, 50);
			floor.makeGraphic(100, 50, 0xFF000000);
			level.add(floor);					
			
			floor = new FlxTileblock(100, 530, 100, 50);
			floor.makeGraphic(100, 50, 0xFF000000);
			level.add(floor);						
			
			floor = new FlxTileblock(200, 510, 100, 50);
			floor.makeGraphic(100, 50, 0xFF000000);
			level.add(floor);					
			
			floor = new FlxTileblock(300, 510, 100, 50);
			floor.makeGraphic(100, 50, 0xFF000000);
			level.add(floor);					
			
			floor = new FlxTileblock(400, 530, 100, 50);
			floor.makeGraphic(100, 50, 0xFF000000);
			level.add(floor);					
			
			floor = new FlxTileblock(500, 550, 100, 50);
			floor.makeGraphic(100, 50, 0xFF000000);
			level.add(floor);
			
			// WALLS
			wall = new FlxTileblock(0, 0, 5, 1800);
			wall.makeGraphic(5, 600, 0xFF000000);
			level.add(wall);	
			
			wall = new FlxTileblock(595, 0, 5, 1800);
			wall.makeGraphic(5, 600, 0xFF000000);
			level.add(wall);
			
			// PLATFORMS LVL 1			
			floor = new FlxTileblock(0, 400, 30, 50);
			floor.makeGraphic(150, 10, 0xFF000000);
			level.add(floor);					
			
			floor = new FlxTileblock(450, 400, 30, 50);
			floor.makeGraphic(150, 10, 0xFF000000);
			level.add(floor);	
			
			
			// PLATFORMS LVL 2			
			floor = new FlxTileblock(250, 280, 30, 50);
			floor.makeGraphic(100, 10, 0xFF000000);
			level.add(floor);	
			
			add(level);
			
			FlxG.camera.follow(chip);
			FlxG.camera.setBounds(0, -500, 600, 1100);
		}
		
		override public function update():void
		{
			FlxG.collide(chip, level)			
			super.update();
		}
		
		
	}

}