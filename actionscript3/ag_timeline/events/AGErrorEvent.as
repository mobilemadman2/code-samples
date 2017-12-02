package net.believecollective.ag2010.events {
	import flash.events.Event;

	/**
	 * @author Marianne
	 */
	public class AGErrorEvent extends Event {
		
		public static const GFX_LOAD_ERROR : String = "gfx_load_error";
		
		public function AGErrorEvent(type : String) {
			super(type, true);
		}
	}
}
