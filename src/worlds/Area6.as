package worlds 
{
	/**
	 * ...
	 * @author noogberserk
	 */
	public class Area6 extends Area 
	{
		[Embed(source="../../assets/levels/level_6.oel", mimeType="application/octet-stream")]
		public static const DATA:Class;
		
		public function Area6() 
		{
			super(DATA);
		}
		
	}

}