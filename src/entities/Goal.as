package entities 
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import worlds.Area;
	
	/**
	 * ...
	 * @author noogberserk
	 */
	public class Goal extends Entity 
	{
		private var g:Image;
		private var nextLevel:uint;
		
		public function Goal(x:Number, y:Number, nextLevel:int) 
		{
			super(x, y, new Image(new BitmapData(16, 16, false, 0x123fad)));
			setHitbox(16, 16);
			this.nextLevel = nextLevel;
		}
		override public function update():void 
		{
			super.update();
			if (collide(GC.TYPE_PLAYER, x, y)) {
				Area.load(nextLevel);
			}
		}
	}

}