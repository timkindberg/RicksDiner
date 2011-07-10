package com.picklewars.ricksdiner 
{
	import flash.events.MouseEvent;
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxTileblock;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxU;
	import org.flixel.plugin.photonstorm.FlxCollision;
	import org.flixel.plugin.photonstorm.FlxColor;
	
	/**
	 * ...
	 * @author Tim Kindberg
	 */
	public class TestChipStateFlatWalk extends FlxState
	{	
		[Embed(source = "data/cwalkright.png")]
		private var LevelGraphics:Class;		
		
		private var chip:Chip;
		private var floor:FlxTileblock;
		private var level:FlxGroup;
		private var blocks:FlxGroup;
		private var wall:FlxTileblock;
		private var block:FlxSprite;
		
		public function TestChipStateFlatWalk() 
		{
			super();
		}
		
		override public function create():void
		{
			FlxG.worldBounds.width = 5010;
			FlxG.worldBounds.height = 600;
			
			level = new FlxGroup();
			blocks = new FlxGroup();
			
			FlxG.bgColor = 0xffaaaaaa;	
			
			chip = new Chip(300, 600 - 59 - 50 - 100);
			add(chip);
			
			var text:FlxText = new FlxText(10, 5, 500, "FUCK YEAH");
			text.size = 36;
			add(text);
			
			// FLOOR
			floor = new FlxTileblock(0, 550, 5000, 50);
			floor.makeGraphic(5000, 50, 0xFF000000);
			level.add(floor);				
			
			// WALLS
			wall = new FlxTileblock(0, 0, 5, 600);
			wall.makeGraphic(5, 600, 0xFF000000);
			level.add(wall);	
			
			wall = new FlxTileblock(4995, 0, 5, 600);
			wall.makeGraphic(5, 600, 0xFF000000);
			level.add(wall);			
					
			add(level);
			
			for (var i:int = 0; i < 100; i++)
			{				
				block = new FlxSprite(FlxG.random()*FlxG.worldBounds.width, FlxG.random()*FlxG.worldBounds.height);
				block.makeGraphic(FlxG.random()*80+20, FlxG.random()*20+5, FlxColor.getRandomColor());
				//enemy.acceleration.y = 800;
				block.immovable = true;
				blocks.add(block);
			}
			
			level.add(blocks);
			
			
			FlxG.camera.follow(chip, FlxCamera.STYLE_PLATFORMER);
			FlxG.camera.setBounds(0, 0, 5000, 600);	
			
			var e:MouseEvent = new MouseEvent(MouseEvent.MOUSE_UP);
			FlxG.mouse.handleMouseUp(e);
			
		}
		
		override public function update():void
		{
			FlxG.collide(chip, level)		
			
			
			if (FlxG.mouse.justPressed()) 
			{
				//chip.x = FlxG.mouse.x;
				//chip.y = FlxG.mouse.y;
				
				for each(var block:FlxSprite in blocks.members)
				{
					block.x = FlxG.random() * FlxG.worldBounds.width;
					block.y = FlxG.random() * FlxG.worldBounds.height;
				}
			}
			
			super.update();
		}
		
		private function enemyCollide(chip:Chip, enemy:FlxSprite):void 
		{
			
		}
		
		
	}

}