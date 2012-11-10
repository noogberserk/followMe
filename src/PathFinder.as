package  
{
	import flash.geom.Point;
	import entities.Terrain;
	import flash.utils.Dictionary;
	import ArrayUtilities;
	
	/**
	 * ...
	 * @author noogberserk
	 */
	public class PathFinder 
	{
		private var _open:Array;
		private var _closed:Array;
		private var _map:Array;
		private var _mapStatus:Dictionary
		
		public function PathFinder() 
		{

		}
		
		public static function findPath(location:Point, target:Point):Array
		{
			var mapH:uint = Terrain.id.grid.rows;
			var mapW:uint = Terrain.id.grid.columns;
			
			var _open:Array = [[location.x / GC.TILE_SIZE, location.y / GC.TILE_SIZE]];
			var _closed:Array = [];
			var _map:Array = [];
			var _path:Array = []
			
			var targetX:Number = target.x / GC.TILE_SIZE;
			var targetY:Number = target.y / GC.TILE_SIZE;
			
			//First element from which to begin the search.
			var currentX:uint = _open[0][0];
			var currentY:uint = _open[0][1];
			
			//trace("LOOKING FOR: ", targetX, targetY);
			//trace("FROM: ", currentX, currentY);
			
			
			//2 dimensional LIST with costs and parents.
			var _mapStatus:Array = new Array();
			for (var i:uint = 0; i < mapH; i++) {
				_mapStatus[i] = new Array(mapW);
			}
			
			var columns:Array = [];
			//Goes through the array finding if the tile at position (x, y) is solid or not.
			//Then storing this info into _map:Array;
			for (var gridY:uint = 0; gridY < mapH; gridY++) {
				for (var gridX:uint = 0; gridX < mapW; gridX++) {
					//getTile returns true or false for solid at position x,y;
					if (Terrain.id.grid.getTile(gridX, gridY)) {
						columns.push(1);
					}
					else columns.push(0);					
					//trace("x", x, "y", y, Terrain.id.grid.getTile(x,y))
				}
 				_map.push(columns);
				columns = [];
			}
			
			//DIBUJO DEL MAPA EN CEROS Y UNOS.
			/*for (var X:String in _map) {
				trace(_map[X]);
			}
			trace()*/
			
			
			
			//DIBUJO DEL STATUS DEL MAPA
			//for each (var value:Object in _mapStatus) trace(value)
			//---------------------------------
			//FOR TESTING PURPOSES;
			//----------------------------------
			//_mapStatus[4][10] = { position: [4, 10], parent: [4, 11], f: 200, g: 100, h: 100};
			
			
			
			var finished:Boolean = false;
			var lowest:uint;
			while (!finished) {
				lowest = 10000;
				for each (var columna:Object in _mapStatus) {
					for each (var entry:Object	in columna) {
						if (entry) {
							if (lowest >= entry.f && ArrayUtilities.findMatchIndex(_open, entry.position) != -1) {
								lowest = entry.f;
								currentX = entry.position[0];
								currentY = entry.position[1];
							}
							
						}
					}
				}
				
				//trace("LOWEST: ", currentX, currentY);
				
				
				if (targetX == currentX && targetY == currentY) {
					trace("FOUND!");
					_path.push([targetX, targetY]);
					path(_path, _mapStatus, targetX, targetY, location.x / GC.TILE_SIZE, location.y / GC.TILE_SIZE);
					//trace(arrayToPoint(_path));
					return arrayToPoint(_path);
				}
				
				
				var count:uint = 0;
				var index:uint = 0;
				for each (var toRemove:Object in _open) {
					if (toRemove[0] == currentX && toRemove[1] == currentY) {
						index = count;
					}
					count++
				}
				
				//trace("WHATS GOING INTO CLOSED? ", _open[index])
				_closed.push(_open.splice(index, 1)[0]);
				
				
				var g_value:Number;
				var h_value:Number;
				
				//trace("-----------------\nNEXT LOOP \nCurrent", currentX,currentY);
				for (var adjacentX:int = currentX -1; adjacentX < currentX +2; adjacentX++) {
					for (var adjacentY:int = currentY - 1; adjacentY < currentY + 2; adjacentY++) {
						if ((adjacentX >= 0 && adjacentY >= 0) && (adjacentY < _map.length && adjacentX < _map[0].length)) {
							if (_map[adjacentY][adjacentX] != 1 && ArrayUtilities.findMatchIndex(_closed, [adjacentX, adjacentY]) == -1) {
								/*trace("match at index: ", ArrayUtilities.findMatchIndex(_closed, [adjacentX, adjacentY]));
								trace(_map[adjacentY][adjacentX])
								trace("-----------------------------");
								ArrayUtilities.traceArray(_open);
								
								
								trace("=============================");
								trace("parent X Y:", currentX, currentY)
								trace("target X Y: ", targetX, targetY);
								trace("adj X Y: ", adjacentX, adjacentY);
								trace(targetX == currentX);
								trace(targetY == currentY);
								trace("=============================");
								
								if (adjacentX == currentX && adjacentY == currentY) {
									trace("------------------------ \n AGAIN \n--------------------------------");
									trace(ArrayUtilities.findMatchIndex(_closed, [adjacentX, adjacentY]))
									ArrayUtilities.traceArray(_closed);
									trace("------------------------ \n AGAIN \n--------------------------------");
								}
								*/
								if (ArrayUtilities.findMatchIndex(_open, [adjacentX, adjacentY]) == -1) {
									//trace(adjacentX, adjacentY)
									_open.push([adjacentX, adjacentY]);
									//cost_list[(x,y)] = {"parent": (parentX, parentY), "f": g_value + h_value, "g": g_value, "h": h_value};
									g_value = get_G(_mapStatus, adjacentX, adjacentY, currentX, currentY);
									h_value = get_H(adjacentX, adjacentY, targetX, targetY);
									_mapStatus[adjacentY][adjacentX] = { position: [adjacentX, adjacentY], parent: [currentX, currentY], f: g_value + h_value, g: g_value, h: h_value };
								}
								else {
									//trace(adjacentX, adjacentY, "Already in open");
									g_value = get_G(_mapStatus, adjacentX, adjacentY, currentX, currentY);
									if (_mapStatus[adjacentY][adjacentX].g >= g_value) {
										h_value = get_H(adjacentX, adjacentY, targetX, targetY);
										_mapStatus[adjacentY][adjacentX] = { position: [adjacentX, adjacentY], parent: [currentX, currentY], f: g_value + h_value, g: g_value, h: h_value };
									}
									
								}
							}
							//trace("closed content: ", _closed); 
						}
					}
				}
				
				/*for each (var columna:Object in _mapStatus) {
					for each (var entry:Object	in columna) {
						if (entry) {
							if (entry.parent[0] == entry.position[0] && entry.parent[1] == entry.position[1]) {
								trace("LA GRAN SIETE");
								trace("<<<<<<<<<<<<<<<<<<|||||||||||||||||||||||>>>>>>>>>>>>>>>>>>>>>");
							}
							trace("parent", entry.parent[0], entry.parent[1]);
							trace("position", entry.position[0], entry.position[1]);
							trace("F:", entry.f);
							trace("G", entry.g);
							trace("H", entry.h);
							trace();
							if (entry.parent[0] == entry.position[0] && entry.parent[1] == entry.position[1]) {
								trace("<<<<<<<<<<<<<<<<<<|||||||||||||||||||||||>>>>>>>>>>>>>>>>>>>>>");
							}
						}
					}
				}*/
				
				if (_open.length < 1) {
					finished = true;
				}
			}
			
			
			return []
		}
		
		private static function get_G(_mapStatus:Array, x:Number, y:Number, parentX:Number, parentY:Number):Number
		{
			var result:uint = 0
			//TODAVIA FALTA RECALCULAR LA SUMA EN CASO DE QUE LA POSICION TENGA UN PARENT. AHI HABRIA QUE SUMARLE EL VALOR DE G DEL PARENT.
			if (Math.abs(x - parentX) == 1 && Math.abs(y - parentY) == 1) {
				result = 14;
			}
			else result = 10;
			
			//trace(_mapStatus[parentY][parentX]);
			if (_mapStatus[parentY][parentX]) {
				result += _mapStatus[parentY][parentX].g;
			}
			//trace("RESULT: ", result);
			return result;
		}
		
		private static function get_H(x:Number, y:Number, targetX:Number, targetY:Number):Number
		{
			return 10 * Math.max((Math.abs(x - targetX) + Math.abs(y - targetY)));
		}
		
		private static function path(_path:Array, _mapStatus:Array, targetX:Number, targetY:Number, startX:Number, startY:Number):void
		{
			var nextStep:Array = _mapStatus[targetY][targetX].parent;
			
			if (_mapStatus[nextStep[1]][nextStep[0]]) {
				/*trace("____");
				trace("position:", _mapStatus[nextStep[1]][nextStep[0]].position);
				trace("parent: ", _mapStatus[nextStep[1]][nextStep[0]].parent);
				trace("-----");*/
				_path.push(_mapStatus[nextStep[1]][nextStep[0]].position);
				path(_path, _mapStatus, nextStep[0], nextStep[1], startX, startY)
				return;
			}
			else _path.push([startX, startY]);
			for each (var columna:Object in _mapStatus) {
					for each (var entry:Object	in columna) {
						if (entry) {
							/*trace("parent", entry.parent);
							trace("position", entry.position);
							trace("F:", entry.f);
							trace("G", entry.g);
							trace("H", entry.h);
							trace();*/
						}
					}
				}
			return;
		}
		
		private static function arrayToPoint(aArrayPath:Array):Array
		{
			var _path:Array = [];
			for each (var entry:Array in aArrayPath) {
				_path.push(new Point(entry[0] * GC.TILE_SIZE, entry[1] * GC.TILE_SIZE));
			}
			_path.reverse();
			return _path
		}
	}

}