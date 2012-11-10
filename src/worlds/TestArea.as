package worlds 
{
	import entities.Player;
	import entities.Terrain;
	import net.flashpunk.FP;
	import entities.*;
	import flash.geom.Point;
	import net.flashpunk.World;
	import net.flashpunk.utils.*;
	
	/**
	 * ...
	 * @author noogberserk
	 */
	public class TestArea extends World 
	{
		private var follower:FollowerTest;
		private var path:Array;
		public var width:uint;
		public var height:uint;
		[Embed(source = "../../assets/levels/test_level.oel", mimeType = "application/octet-stream")]
		public const level:Class;
		
		public function TestArea() 
		{
			
			var xml:XML = FP.getXML(level);
			width = xml.@width;
			height = xml.@height;
			
			add(new Terrain(width, height));
			Terrain.id.loadFromXML(xml);
			
			path = [];
			add(new FollowerTest(32, 32, new Point(272, 32)));
			//add(new FollowerTest(160, 208, new Point(272, 32)));
			add(new Player(144, 96));
			/*add(new FollowerTest(32, 16, new Point(96, 192)));
			add(new FollowerTest(272, 16, new Point(112, 160)));
			add(new FollowerTest(272, 16, new Point(288, 208)));*/
			//THIS GIVES ERROR :(
			follower = new FollowerTest(272, 16, new Point(16, 192));
			add(follower);
		}
		
		private function loadObjects(data:XML):void
		{
			//current_level = data.Objects.Goal.@nextLevel - 1;
			add(new Player(data.Objects.Player.@x, data.Objects.Player.@y));
			add(new Goal(data.Objects.Goal.@x, data.Objects.Goal.@y, data.Objects.Goal.@nextLevel));
			for each (var o:Object in data.Objects.Follower) add(new FollowerTest(o.@x, o.@y, new Point(o.@moveX, o.@moveY)));
			for each (o in data.Activables.Door) {
				//activable_list.push(new Door(o.@x, o.@y));
				//add(activable_list[activable_list.length - 1]);
			}
			for each(o in data.Triggers.Trigger) add(new Trigger(o.@x, o.@y, o.@id));
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Input.mousePressed) {
				trace(mouseX, mouseY);
				Terrain.id.activateTile(mouseX / GC.TILE_SIZE, mouseY / GC.TILE_SIZE);
			}
			if (Input.pressed(Key.CONTROL)) {
				Terrain.id.removeTile(mouseX / GC.TILE_SIZE, mouseY / GC.TILE_SIZE);
			}
		}
		
	}

}