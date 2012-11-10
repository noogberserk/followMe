package worlds 
{
	import flash.geom.Point;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import entities.*;
	import net.flashpunk.utils.*;
	/**
	 * ...
	 * @author noogberserk
	 */
	public class Area extends World 
	{
		public static const LIST:Array = [];
		public static var activable_list:Array = [];
		
		public var width:uint;
		public var height:uint;
		public var current_level:uint;
		public static var current:Area;
		
		public static function init():void 
		{
			LIST.push(Area1);
			LIST.push(Area2);
			/*LIST.push(Area3);
			LIST.push(Area4);
			LIST.push(Area5);
			LIST.push(Area6);*/
		}
		
		public static function load(index:uint):void
		{
			if (!LIST[index]) {
				throw new Error("Not an area in index  " + index);
			}
			FP.world = current = new LIST[index];
		}
		
		public function Area(data:Class) 
		{
			var xml:XML = FP.getXML(data);
			
			width = xml.@width;
			height = xml.@height;
			current_level = 0;
			activable_list = [];
			
			add(new Terrain(width, height));
			Terrain.id.loadFromXML(xml);
			
			loadObjects(xml);
		}
		
		private function loadObjects(data:XML):void
		{
			current_level = data.Objects.Goal.@nextLevel - 1;
			add(new Player(data.Objects.Player.@x, data.Objects.Player.@y));
			add(new Goal(data.Objects.Goal.@x, data.Objects.Goal.@y, data.Objects.Goal.@nextLevel));
			for each (var o:Object in data.Objects.Follower) add(new Follower(o.@x, o.@y, new Point(o.@moveX, o.@moveY)));
			for each (o in data.Activables.Door) {
				activable_list.push(new Door(o.@x, o.@y));
				add(activable_list[activable_list.length - 1]);
			}
			for each(o in data.Triggers.Trigger) add(new Trigger(o.@x, o.@y, o.@id));
		}
		
		override public function update():void 
		{
			super.update();
			FP.camera.x = 96 - FP.screen.width / 2;
			FP.camera.y = 2032 - FP.screen.height / 2;
			FP.camera.x = Player.id.x - FP.screen.width / 2;
			FP.camera.y = Player.id.y - FP.screen.height / 2;
		}
	}

}