package entities 
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import worlds.Area;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author noogberserk
	 */
	public class Trigger extends Entity 
	{
		private var index:int
		private var door:Door;
		
		public function Trigger(x:Number, y:Number, index:int) 
		{
			super(x, y, new Image(new BitmapData(GC.TILE_SIZE, GC.TILE_SIZE, false, 0xFF2802)));
			setHitbox(GC.TILE_SIZE, GC.TILE_SIZE);
			this.index = index;
			type = GC.TYPE_TRIGGER;
			
		}
		public function activate():void
		{
			door = Area.activable_list[index];
			door.open();
			Terrain.id.activateTile(x / GC.TILE_SIZE, y / GC.TILE_SIZE);
			FP.world.remove(this);
		}
	}

}