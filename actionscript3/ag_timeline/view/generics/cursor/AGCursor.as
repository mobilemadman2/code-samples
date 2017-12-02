package net.believecollective.ag2010.view.generics.cursor {
	import net.believecollective.ag2010.app.ApplicationFacade;

	import flash.display.MovieClip;
	import flash.events.Event;

	/**
	 * @author Marianne
	 */
	public class AGCursor extends MovieClip {
		
		public var _mcOpen : MovieClip;		public var _mcClosed : MovieClip;		public var _mcPoint : MovieClip;
				
		public function AGCursor() {
//			_mcOpen = addChild(new AGExternalGraphic(new AGExternalGraphicVO("cursor/open.gif", fInitImage))) as AGExternalGraphic;//			_mcClosed = addChild(new AGExternalGraphic(new AGExternalGraphicVO("cursor/closed.gif", fInitImage))) as AGExternalGraphic;//			_mcPoint = addChild(new AGExternalGraphic(new AGExternalGraphicVO("cursor/pointing.gif", fInitImage))) as AGExternalGraphic;		}
		
		private function fInitImage(event : Event): void {}
		
		public function fSetCursor(arg_sMode : String) : void {
			switch( arg_sMode) {
				case ApplicationFacade.CURSOR_MODE_MOUSE:
//					Mouse.show();
//					_mcOpen.visible = false;//					_mcClosed.visible = false;//					_mcPoint.visible = false;
					break;
				case ApplicationFacade.CURSOR_MODE_OPEN:
//					Mouse.hide();
//					_mcOpen.visible = true;
//					_mcClosed.visible = false;
//					_mcPoint.visible = false;
					break;
				case ApplicationFacade.CURSOR_MODE_CLOSED:
//					Mouse.hide();
//					_mcOpen.visible = false;
//					_mcClosed.visible = true;
//					_mcPoint.visible = false;
					break;
				case ApplicationFacade.CURSOR_MODE_POINT:
//					Mouse.hide();
//					_mcOpen.visible = false;
//					_mcClosed.visible = false;
//					_mcPoint.visible = true;
					break;
			}
		}
		
	}
}
