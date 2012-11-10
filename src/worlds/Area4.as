package worlds 
{
	/**
	 * ...
	 * @author noogberserk
	 */
	public class Area4 extends Area 
	{
		[Embed(source="../../assets/levels/level_4.oel", mimeType="application/octet-stream")]
		public static const DATA:Class;
		
		public function Area4() 
		{
			super(DATA);
		}
		
	}

}