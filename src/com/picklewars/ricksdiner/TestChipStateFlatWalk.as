package com.picklewars.ricksdiner 
{
	import com.timkindberg.common.Utils;
	import flash.events.MouseEvent;
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
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
		[Embed(source = "data/evilhotdog.png")]
		private var EvilHotDogGraphic:Class;	
		
		private var chip:Chip;
		private var floor:FlxTileblock;
		private var level:FlxGroup;
		private var blocks:FlxGroup;
		private var wall:FlxTileblock;
		private var block:FlxSprite;
		private var enemies:FlxGroup;
		
		public function TestChipStateFlatWalk() 
		{
			super();
		}
		
		override public function create():void
		{
			FlxG.worldBounds.width = 5010;
			FlxG.worldBounds.height = 5000;
			
			level = new FlxGroup();
			blocks = new FlxGroup();
			
			FlxG.bgColor = 0xffaaaaaa;	
			
			chip = new Chip(300, 600 - 59 - 50 - 100);
			add(chip);
			
			var text:FlxText = new FlxText(10, 5, 500, "FUCK YEAH");
			text.size = 36;
			add(text);
						
			// FLOOR
			floor = new FlxTileblock(0, 4950, 5000, 50);
			floor.makeGraphic(5000, 50, 0xFF000000);
			level.add(floor);				
			
			// WALLS
			wall = new FlxTileblock(0, 0, 5, 5000);
			wall.makeGraphic(5, 5000, 0xFF000000);
			level.add(wall);	
			
			wall = new FlxTileblock(4995, 0, 5, 5000);
			wall.makeGraphic(5, 5000, 0xFF000000);
			level.add(wall);			
					
			add(level);
						
			for (var i:int = 0; i < 250; i++)
			{						
				var bx:uint = Utils.roundToNearest(500, FlxG.random() * FlxG.worldBounds.width);
				var by:uint = Utils.roundToNearest(200, FlxG.random() * FlxG.worldBounds.height);
				block = new FlxSprite(bx, by);
				block.makeGraphic(FlxG.random()*250+150, 10, 0xFF000000);
				//enemy.acceleration.y = 800;
				block.immovable = true;
				block.allowCollisions = FlxObject.UP;
				blocks.add(block);
			}
			
			level.add(blocks);
			
			
			FlxG.camera.follow(chip, FlxCamera.STYLE_PLATFORMER);
			FlxG.camera.setBounds(0, 0, 5000, 5000);	
			
			var e:MouseEvent = new MouseEvent(MouseEvent.MOUSE_UP);
			FlxG.mouse.handleMouseUp(e);
			
			enemies = new FlxGroup();
			add(enemies);
			for (i = 0; i < 250; i++)
			{						
				bx = FlxG.random() * FlxG.worldBounds.width;
				by = FlxG.random() * FlxG.worldBounds.height;
				var enemy:FlxSprite = new FlxSprite(bx, by);
				enemy.loadGraphic(EvilHotDogGraphic, false, true);
				enemy.health = 3;
				enemy.acceleration.y = 800;
				enemy.facing = FlxObject.RIGHT;
				enemies.add(enemy);
			}
			
		}
		
		override public function update():void
		{
			
			FlxG.collide(chip, level)		
			FlxG.collide(enemies, level)		
			FlxG.overlap(chip, enemies, chipEnemyOverlap)		
			
			
			if (FlxG.mouse.justPressed()) 
			{
				//chip.x = FlxG.mouse.x;
				//chip.y = FlxG.mouse.y;
				
				for each(var block:FlxSprite in blocks.members)
				{
					var bx:uint = Utils.roundToNearest(100, FlxG.random() * FlxG.worldBounds.width);
					var by:uint = Utils.roundToNearest(100, FlxG.random() * FlxG.worldBounds.height);
					block.x = bx;
					block.y = by;
				}
			}
			
			super.update();
		}		
		
		public function chipEnemyOverlap(chip:Chip, enemy:FlxSprite):void 
		{
			if (chip.attackClimax) enemy.hurt(1);
		}
				
	}

}