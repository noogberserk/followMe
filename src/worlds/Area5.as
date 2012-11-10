package worlds 
{
	/**
	 * ...
	 * @author noogberserk
	 */
	public class Area5 extends Area 
	{
		[Embed(source="../../assets/levels/level_5.oel", mimeType="application/octet-stream")]
		public static const DATA:Class;
		
		public function Area5() 
		{
			super(DATA);
		}
		
	}

}