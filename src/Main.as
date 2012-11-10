package 
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import worlds.Area;
	import net.flashpunk.utils.*;
	import worlds.Menu;
	import worlds.TestArea;
	
	/**
	 * ...
	 * @author noogberserk
	 */
	public class Main extends Engine 
	{
		private var level:uint = 0;
		
		
		public function Main():void 
		{
			super(320, 320, 60, false);
			FP.screen.scale = 2;
			
			
			FP.screen.color = 0xabcdab;
			FP.console.enable();
			
			FP.world = new Menu();
			
			/*var myArray:Array = [[0,1,2,3,4,5],[6,7,8,9,10,11]];
			
			ArrayUtilities.traceArray(myArray)
			
			myArray.push(['some', 'values']);
			myArray.push(12);
			myArray.push([]);
			
			ArrayUtilities.traceArray(myArray)
			//myArray[0] = "SOME 0";
			//myArray[3] = "WELL, TWO SPACES BEHIND"
			/*for each (var entry:Object in myArray) trace(entry)*/
		}
		/*override public function update():void 
		{
			super.update();
			if (Input.pressed(Key.NUMPAD_ADD)) {
				level++;
				Area.load(level);
			}
			if (Input.pressed(Key.NUMPAD_SUBTRACT)) {
				level--;
				Area.load(level);
			}
			
		}*/
	}
	
}