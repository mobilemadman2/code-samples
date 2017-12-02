package net.believecollective.ag2010.view.generics.externalgraphics {
	import net.believecollective.ag2010.view.eventsdetail.components.loaders.AGThumbnailLoader;
	import net.believecollective.ag2010.view.generics.externalgraphics.vo.AGExternalGraphicVO;
	import net.believecollective.ag2010.view.generics.loader.AGLoader;
	import net.believecollective.frameworks.pureMVC2.view.loader.CallbackLoader;

	import flash.events.Event;

	/**
	 * @author Marianne
	 */
	
	public class AGThumbnail extends AGExternalGraphic {
		
		private var _nTotal: Number;		private var _nLoaded: Number;
		private var _mcLoader : AGLoader;
		
		public function AGThumbnail(arg_AGExternalGraphicVO : AGExternalGraphicVO) {
			_mcLoader = addChild(new AGThumbnailLoader()) as AGThumbnailLoader;
			_mcLoader.x = 60;
			_mcLoader.y = 80;
			super(arg_AGExternalGraphicVO);
			_oGraphic.visible = false;
			addEventListener(Event.ENTER_FRAME, fGetBytes);
		}

		private function fGetBytes(e : Event) : void {
			if (_oGraphic.contentLoaderInfo.bytesTotal == 0) return;
			else if (_nLoaded / _nTotal == 1) removeEventListener(Event.ENTER_FRAME, fGetBytes);
			else {
				_nTotal = _oGraphic.contentLoaderInfo.bytesTotal;				_nLoaded = _oGraphic.contentLoaderInfo.bytesLoaded;
				_mcLoader.fUpdate(_nLoaded / _nTotal);
			}
		}
		
		public function fError() : void {
			removeEventListener(Event.ENTER_FRAME, fGetBytes);
		}
		
		public function get theImage() : CallbackLoader {
			return _oGraphic;
		}
		
		public function get mcLoader() : AGLoader {
			return _mcLoader;
		}
	}
}
