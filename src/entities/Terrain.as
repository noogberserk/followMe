package entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	import flash.display.BitmapData;
	import net.flashpunk.utils.*
	/**
	 * ...
	 * @author noogberserk
	 */
	public class Terrain extends Entity 
	{
		public static var id:Terrain;
		private var _map:Tilemap;
		private var _grid:Grid;
		
		public function Terrain(width:uint, height:uint) 
		{
			id = this;
			type = GC.TYPE_TERRAIN;
			setHitbox(width, height);
			_map = new Tilemap(GC.TILESET, width , height, 16, 16);
			addGraphic(_map);
			
			mask = _grid = new Grid(width, height, 16, 16);
			super();
		}
		
		public function get grid():Grid {
			return _grid;
		}
		
		public function loadFromXML(data:XML):void
		{
			for each (var o:Object in data.Terrain.tile) {
				_map.setTile(o.@x, o.@y);
				_grid.setTile(o.@x, o.@y, true);
			}
		}
		public function removeTile(x:int, y:int):void
		{
			_map.clearTile(x, y);
			_grid.clearTile(x, y);
		}
		public function activateTile(x:int, y:int):void
		{
			_map.setTile(x, y);
			_grid.setTile(x, y, true);
		}
		
	}

}