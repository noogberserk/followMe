package entities 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author noogberserk
	 */
	public class Actor extends Entity 
	{	
		
		public function Actor(x:Number, y:Number, g:Image) 
		{
			super(x, y, g);
			//g.centerOrigin();
			setHitbox(g.width, g.height)//, g.width/2, g.height/2);
		}
		
		public function movement(speed:Number, v:Point):void
		{			
			x += speed * v.x * FP.elapsed;
			
			if (collideTypes([GC.TYPE_TERRAIN, GC.TYPE_DOOR], x, y)) {
				trace("collision on X");
				if (v.x > 0) {
					// To the right
					v.x = 0;
					x = Math.floor(x / GC.TILE_SIZE) * GC.TILE_SIZE// + GC.TILE_SIZE / 2;
				}
				else {
					//to the left
					v.x = 0;
					x = Math.floor(x / GC.TILE_SIZE) * GC.TILE_SIZE + GC.TILE_SIZE// / 2;
				}
			}
			//else trace("not colliding");
			
			
			y += speed * v.y * FP.elapsed;
			if (collideTypes([GC.TYPE_TERRAIN, GC.TYPE_DOOR], x, y)) {
				trace("collision on Y");
				if (v.y > 0) {
					// To the right
					v.y = 0;
					y = Math.floor(y / GC.TILE_SIZE) * GC.TILE_SIZE// + GC.TILE_SIZE / 2;
				}
				else {
					//to the left
					v.y = 0;
					y = Math.floor(y / GC.TILE_SIZE) * GC.TILE_SIZE + GC.TILE_SIZE // 2;
				}
			}
			//else trace("not colliding");
			
			v.x = 0
			v.y = 0
			
		}
	}

}