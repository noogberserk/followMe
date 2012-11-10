package  
{
	/**
	 * ...
	 * @author noogberserk
	 */
	public class GC 
	{
		[Embed(source = "../assets/graphics/PLAYER_SQUARE.png")] 
		public static const CAR_IMAGE:Class;
		
		[Embed(source = "../assets/graphics/ENEMY_CIRCLE.png")]
		public static const ENEMY_CIRCLE:Class;
		
		[Embed(source = "../assets/graphics/tileset.png")]
		public static const TILESET:Class;
		
		[Embed(source = "../assets/graphics/DOOR.png")]
		public static const DOOR:Class;
		
		public static const TILE_SIZE:int = 16;
		
		//TYPES
		public static const TYPE_DOOR:String = "door";
		public static const TYPE_PLAYER:String = "player";
		public static const TYPE_PLAYER_HIDDEN:String = "player_hidden";
		public static const TYPE_ENEMY:String = "enemy";
		public static const TYPE_TERRAIN:String = "terrain";
		public static const TYPE_TRIGGER:String = "trigger";
		//public static const TYPE_:String = 
	}

}