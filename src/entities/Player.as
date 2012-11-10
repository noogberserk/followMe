package entities
{
	import entities.Terrain;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.*;
	import net.flashpunk.FP
	/**
	 * ...
	 * @author noogberserk
	 */
	public class Player extends Actor 
	{
		public static var id:Player;
		public var hidden:Boolean;
		private var sprite:Spritemap;
		private var v:Point;
		private var speed:Number;
		private var terrain:Terrain;
		private var trigger:Trigger;
		private var door:Door;
		
		private var collisionY:Boolean;
		private var collisionX:Boolean;
		private var borders:Array;
		private var xBorder:Number;
		private var yBorder:Number;
		
		public function Player(x:Number, y:Number) 
		{
			id = this;
			sprite = new Spritemap(GC.CAR_IMAGE, GC.TILE_SIZE, GC.TILE_SIZE,onComplete);
			type = GC.TYPE_PLAYER
			
			sprite.add("blend", [0, 1, 2, 3, 4, 5], 10, false);
			sprite.add("unblend", [5, 4, 3, 2, 1, 0], 10, false);
			sprite.frame = 0;
			
			v = new Point();
			speed = 60;
			hidden = false;
			
			super(x, y, sprite);
			sprite.centerOrigin();
			setHitbox(sprite.width, sprite.height, sprite.width/2, sprite.height/2);
			
			borders = ["left-top", "right-top", "right-bottom", "left-bottom"];
		}
		
		override public function update():void 
		{
			if (Input.pressed(Key.X)) {
				borders.push(borders.shift())
			}
			
			switch (borders[0]){
				case "left-top": xBorder = -1; yBorder = -1; sprite.angle = 0; break;
				case "right-top": xBorder = 1; yBorder = -1; sprite.angle = 270;  break;
				case "left-bottom": xBorder = -1; yBorder = 1; sprite.angle = 90; break;
				case "right-bottom": xBorder = 1; yBorder = 1; sprite.angle = 180; break;
			}
			
			if (Input.check(Key.UP)) 	v.y = -1;
			if (Input.check(Key.DOWN))	v.y = 1;
			if (Input.check(Key.LEFT)) 	v.x = -1;
			if (Input.check(Key.RIGHT))	v.x = 1;
			
			movement(speed, v);
			
			trigger = collide(GC.TYPE_TRIGGER, x, y) as Trigger;
			if (trigger) trigger.activate();
			
			if (collideTypes([GC.TYPE_DOOR, GC.TYPE_TERRAIN], x + xBorder, y)) {
				collisionX = true;
			}
			else {
				collisionX = false;
			}
			
			if (collideTypes([GC.TYPE_DOOR, GC.TYPE_TERRAIN], x, y + yBorder)) {
				collisionY = true;
			}
			else {
				collisionY = false;
			}
		}
		
		public function onComplete():void
		{
			switch (sprite.currentAnim) {
				case "blend": hidden = true; type = GC.TYPE_PLAYER_HIDDEN; break;
				case "unblend": hidden = false; type = GC.TYPE_PLAYER; break;
			}
		}
		
		override public function movement(speed:Number, v:Point):void
		{	
			if (collisionX && collisionY) sprite.play("blend");
			else sprite.play("unblend");
			
			
			x += speed * v.x * FP.elapsed;
			
			if (collideTypes([GC.TYPE_TERRAIN, GC.TYPE_DOOR], x, y)) {
				if (v.x > 0) {
					// To the right
					v.x = 0;
					x = Math.floor(x / GC.TILE_SIZE) * GC.TILE_SIZE + GC.TILE_SIZE / 2;
				}
				else {
					//to the left
					v.x = 0;
					x = Math.floor(x / GC.TILE_SIZE) * GC.TILE_SIZE + GC.TILE_SIZE / 2;
					//collisionX = true;
				}
			}
			
			
			y += speed * v.y * FP.elapsed;
			
			if (collideTypes([GC.TYPE_TERRAIN, GC.TYPE_DOOR], x, y)) {
				if (v.y > 0) {
					// Downwards
					v.y = 0;
					y = Math.floor(y / GC.TILE_SIZE) * GC.TILE_SIZE + GC.TILE_SIZE / 2;
				}
				else {
					//Upwards
					v.y = 0;
					y = Math.floor(y / GC.TILE_SIZE) * GC.TILE_SIZE + GC.TILE_SIZE / 2;
					//collisionY = true;
				}
			}
			
			v.x = 0
			v.y = 0
		}
	}

}