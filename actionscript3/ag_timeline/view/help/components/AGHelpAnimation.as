package net.believecollective.ag2010.view.help.components {
	import net.believecollective.ag2010.view.eventsdetail.components.loaders.AGHelpLoader;
	import net.believecollective.ag2010.view.generics.externalgraphics.AGExternalGraphic;
	import net.believecollective.ag2010.view.generics.externalgraphics.vo.AGExternalGraphicVO;
	import net.believecollective.ag2010.view.generics.loader.AGLoader;
	import net.believecollective.frameworks.pureMVC2.view.loader.CallbackLoader;

	import flash.events.Event;

	/**
	 * @author Marianne
	 */
	
	public class AGHelpAnimation extends AGExternalGraphic {
		
		private var _nTotal: Number;
		private var _nLoaded: Number;
		private var _mcLoader : AGLoader;
		
		public function AGHelpAnimation(arg_AGExternalGraphicVO : AGExternalGraphicVO) {
			_mcLoader = addChild(new AGHelpLoader()) as AGHelpLoader;
			_mcLoader.x = 250;
			_mcLoader.y = 30;
			super(arg_AGExternalGraphicVO);
			_oGraphic.visible = false;
			addEventListener(Event.ENTER_FRAME, fGetBytes);
		}

		private function fGetBytes(e : Event) : void {
			if (_oGraphic.contentLoaderInfo.bytesTotal == 0) return;
			else if (_nLoaded / _nTotal == 1) removeEventListener(Event.ENTER_FRAME, fGetBytes);
			else {
				_nTotal = _oGraphic.contentLoaderInfo.bytesTotal;
				_nLoaded = _oGraphic.contentLoaderInfo.bytesLoaded;
				_mcLoader.fUpdate(_nLoaded / _nTotal);
			}
		}
		
		public function get theImage() : CallbackLoader {
			return _oGraphic;
		}
		
		public function get mcLoader() : AGLoader {
			return _mcLoader;
		}
	}
}
