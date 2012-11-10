package worlds 
{
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	import net.flashpunk.utils.*;
	import net.flashpunk.FP
	/**
	 * ...
	 * @author noogberserk
	 */
	public class Menu extends World
	{
		private var textInfo:Text;
		
		public function Menu() 
		{
			textInfo = new Text("Press 1 to launch the prototype. \nPress 2 to launch the test area.", 20, 20);
			addGraphic(textInfo);
		}
		override public function update():void 
		{
			super.update();
			if (Input.pressed(Key.NUMPAD_1) || Input.pressed(Key.DIGIT_1)) {
				Area.init();
				Area.load(0);
			}
			
			if (Input.pressed(Key.NUMPAD_2) || Input.pressed(Key.DIGIT_2)) {
				FP.world = new TestArea();
			}
		}
	}

}