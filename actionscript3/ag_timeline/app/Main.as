
package net.believecollective.ag2010.app {
	import net.believecollective.utils.system.DirectoryParser;

	import flash.display.MovieClip;
	import flash.events.Event;

	public class Main extends MovieClip {
		
		public var mcCircularLoader: MovieClip;
//		private var _mcCursor : AGCursor;
		
		public function Main() {
			stop();
			// if there is a preloader, we will be added
			// to the stage once loading is completed
			ApplicationFacade.IS_FACEBOOK = loaderInfo.parameters.fbmode;
			if (loaderInfo.url.substr(0,4) == "file") ApplicationFacade.IS_USING_LOCAL = true;			
			if (ApplicationFacade.IS_FACEBOOK == true) {
				ApplicationFacade.APP_WIDTH = ApplicationFacade.APP_WIDTH_FB;
				ApplicationFacade.NAV_X_BUFFER = ApplicationFacade.NAV_X_BUFFER_FB;
				ApplicationFacade.NAV_BUTTON_SEPARATION = ApplicationFacade.NAV_BUTTON_SEPARATION_FB;				ApplicationFacade.HORIZONTAL_FOCUS_POINT = ApplicationFacade.HORIZONTAL_FOCUS_POINT_FB;				ApplicationFacade.DETAIL_PANEL_X = ApplicationFacade.DETAIL_PANEL_X_FB + ApplicationFacade.APP_WIDTH_DEFAULT - ApplicationFacade.APP_WIDTH_FB;
			}
			else ApplicationFacade.IS_FACEBOOK = false;
			
			if (!ApplicationFacade.IS_USING_LOCAL)  {
				ApplicationFacade.ACTIVE_ITEM_ID = loaderInfo.parameters.id;
				var t_sTimeLineWebserviceURL:String = loaderInfo.parameters.service;
				ApplicationFacade.LANGUAGE = t_sTimeLineWebserviceURL.substr(t_sTimeLineWebserviceURL.length-2, 2);
				ApplicationFacade.BASEPATH = DirectoryParser.fGetBaseURL(t_sTimeLineWebserviceURL);			
			}
			addEventListener(Event.ADDED_TO_STAGE, fLoadInit);
		}
		
		private function fLoadInit(event : Event) : void {
			fStart();
			fMask();
		}

//		public function fAddCursor() : void {
//			_mcCursor = addChildAt(new AGCursor(), numChildren) as AGCursor;
//			_mcCursor.fSetCursor(ApplicationFacade.CURSOR_MODE_OPEN);
//			_mcCursor.x = mouseX;//			_mcCursor.y = mouseY;
//			_mcCursor.startDrag(false);
//		}

		private function fMask() : void {
			var t_mcMask:MainMask = this.addChild(new MainMask()) as MainMask;
			this.mask = t_mcMask;
		}

		private function fStart(event : Event = null) : void {
			gotoAndStop('start');
			ApplicationFacade.getInstance().startup(this);
		}
		
//		public function get mcCursor() : AGCursor {
//			return _mcCursor;
//		}
	}
}
