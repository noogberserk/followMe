package entities 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Draw;
	
	/**
	 * ...
	 * @author noogberserk
	 */
	public class FollowerTest extends Actor 
	{
		private var g:Image;
		private var toPoint:Point = new Point;
		private var spawnPoint:Point;
		private var path:Array;
		private var huntingPath:Array;
		private var currentPath:Array
		
		private var going:Boolean;
		private var visionRange:uint = 100;
		private var playerRadius:uint = 10;
		private var speed:uint = 50;
		private var v:Point = new Point();
		
		private var drawing:Boolean = true;
		
		
		public function FollowerTest(x:Number, y:Number, toPoint:Point) 
		{
			g = new Image(GC.ENEMY_CIRCLE);
			super(x, y, g);
			type = GC.TYPE_ENEMY;
			this.toPoint = toPoint;
			spawnPoint = new Point(x, y);
			going = true
			path = PathFinder.findPath(spawnPoint, toPoint);
			currentPath = path;
			//trace("PATH:");
			//ArrayUtilities.traceArray(path);
		}
		
		override public function update():void 
		{
			super.update();
			trace(currentPath);
			trace("GOING: ", going);
			
			if (!Player.id.hidden && circleCircleCollision(new Point(Player.id.x, Player.id.y), playerRadius, new Point(x, y), visionRange)) {
				if (!huntingPath) {
					huntingPath = PathFinder.findPath(getTilePositionFromXY(x, y), getTilePositionFromXY(Player.id.x, Player.id.y));
				}
				else if (currentPath !== huntingPath) huntingPath = PathFinder.findPath(getTilePositionFromXY(x, y), getTilePositionFromXY(Player.id.x, Player.id.y));
				currentPath = huntingPath;
				visionRange = 150;
				speed = 65;
			}
			else {
				if (currentPath !== path) {
					if (going) {
						path = PathFinder.findPath(getTilePositionFromXY(x,y), toPoint);
					}
					else {
						path = PathFinder.findPath(getTilePositionFromXY(x,y), spawnPoint);
					}
				}
				currentPath = path;
				visionRange = 100;
				speed = 50;
			}
			
			
			if (circleCircleCollision(new Point(x, y), 2, currentPath[0], 2)) {
				currentPath.shift();
			}
			
			if (currentPath.length <= 1) {
				if (currentPath === path) {
					//trace("currentPath = path");
					if (going) {
						path = PathFinder.findPath(getTilePositionFromXY(x,y), spawnPoint);
						going = false;
					}
					else {
						path = PathFinder.findPath(getTilePositionFromXY(x,y), toPoint);
						going = true;
					}
					currentPath = path;
				}
				else if (currentPath === huntingPath) {
					//trace("currentPath = huntingPath");
					huntingPath = PathFinder.findPath(getTilePositionFromXY(x, y), getTilePositionFromXY(Player.id.x, Player.id.y));
				}
			}
			
			movement(speed, currentPath[0]);
		}
		
		private function getTilePositionFromXY(xPos:Number, yPos:Number):Point
		{
			xPos = Math.floor(xPos / GC.TILE_SIZE) * GC.TILE_SIZE;
			yPos = Math.floor(yPos / GC.TILE_SIZE) * GC.TILE_SIZE;
			return new Point(xPos, yPos);
		}
		
		override public function movement(speed:Number, goal:Point):void 
		{
			v.x = FP.sign(goal.x - x);
			v.y = FP.sign(goal.y - y);
			x += speed * v.x * FP.elapsed;
			
			if (collideTypes([GC.TYPE_TERRAIN, GC.TYPE_DOOR], x, y)) {
				trace("collision on X");
				if (v.x > 0) {
					// To the right
					v.x = 0;
					x = Math.floor(x / GC.TILE_SIZE) * GC.TILE_SIZE;
				}
				else {
					//to the left
					v.x = 0;
					x = Math.floor(x / GC.TILE_SIZE) * GC.TILE_SIZE + GC.TILE_SIZE;
				}
			}
			//else trace("not colliding");
			
			
			y += speed * v.y * FP.elapsed;
			if (collideTypes([GC.TYPE_TERRAIN, GC.TYPE_DOOR], x, y)) {
				trace("collision on Y");
				if (v.y > 0) {
					// To the right
					v.y = 0;
					y = Math.floor(y / GC.TILE_SIZE) * GC.TILE_SIZE;
				}
				else {
					//to the left
					v.y = 0;
					y = Math.floor(y / GC.TILE_SIZE) * GC.TILE_SIZE + GC.TILE_SIZE;
				}
			}
			//else trace("not colliding");
			
			v.x = 0
			v.y = 0
			
		}
		
		override public function render():void 
		{
			super.render();
			if (currentPath.length > 0 && drawing) {
				Draw.circle(spawnPoint.x, spawnPoint.y, 1, 0);
				Draw.circle(currentPath[0].x, currentPath[0].y, 1, 0);
				Draw.circle(x, y, visionRange, 0);
				Draw.circle(Player.id.x, Player.id.y, playerRadius, 0);
				Draw.circle(currentPath[currentPath.length - 1].x, currentPath[currentPath.length - 1].y, 10, 0);
			}
		}
		
		private function circleCircleCollision(Center1:Point, R1:Number, Center2:Point, R2:Number):Boolean {
			var distX:Number = Center1.x - Center2.x;
			var distY:Number = Center1.y - Center2.y;
			var dist:Number = Math.sqrt((distX * distX) + (distY * distY));
			return dist <= (R1 + R2);
		}
	}

}