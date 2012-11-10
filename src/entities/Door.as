package entities 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author noogberserk
	 */
	public class Door extends Entity 
	{
		private var sprite:Spritemap;
		
		public function Door(x:Number, y:Number) 
		{
			sprite = new Spritemap(GC.DOOR, GC.TILE_SIZE, GC.TILE_SIZE, callback);
			setHitbox(GC.TILE_SIZE, GC.TILE_SIZE);
			type = GC.TYPE_DOOR;
			
			sprite.add("opening", [0, 1, 2, 4, 5], 10, false);
			//sprite.add("closing", [5, 4, 3, 2, 1, 0], 10, false);
			sprite.frame = 5;
			super(x, y, sprite);
			
		}
		
		public function open():void {
			trace("playing from door at x:" + x + " y: " + y);
			sprite.play("opening");
		}
		
		public function close():void
		{
			
		}
		
		private function callback():void
		{
			FP.world.remove(this);
		}
		
	}

}