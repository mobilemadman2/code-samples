package net.believecollective.ag2010.view.loader.components {
	import net.believecollective.ag2010.view.generics.loader.AGLoader;

	/**
	 * @author Marianne
	 */
	public class AGMainLoaderBar extends AGLoader {
		public function AGMainLoaderBar() {
			stop();
			super();
		}
		
		override public function fUpdate(arg_nPercentage: Number) : void {
			if (_mcMask.width < _mcBar.width * arg_nPercentage) _mcMask.width = _mcBar.width * arg_nPercentage;
		}
		
	}
}
