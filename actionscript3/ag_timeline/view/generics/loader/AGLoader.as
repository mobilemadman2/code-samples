package net.believecollective.ag2010.view.generics.loader {
	import flash.display.MovieClip;
	import flash.display.Sprite;

	/**
	 * @author Marianne
	 */
	public class AGLoader extends MovieClip{
		
		public var _mcBG: Sprite;		public var _mcBar: Sprite;		public var _mcMask: Sprite;
		
		public function AGLoader() {
			_mcBar.mask = _mcMask;
			fUpdate(0);
		}
		
		public function fUpdate(arg_nPercentage: Number) : void {
			_mcMask.width = _mcBar.width * arg_nPercentage;
		}
	}
}
