
package net.believecollective.ag2010.patterns.mediators {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.ag2010.model.vo.AGTooltipVO;
	import net.believecollective.ag2010.model.vo.timeline.events.AGEventDetailVO;
	import net.believecollective.ag2010.model.vo.timeline.events.AGEventVO;
	import net.believecollective.ag2010.patterns.proxy.ConfigProxy;
	import net.believecollective.ag2010.patterns.proxy.HistoryProxy;
	import net.believecollective.ag2010.patterns.proxy.TimelineProxy;
	import net.believecollective.ag2010.view.eventsdetail.EventsDetailView;
	import net.believecollective.ag2010.view.eventsdetail.components.EventsDetailViewGFX;
	import net.believecollective.frameworks.pureMVC2.app.ApplicationFacadeBase;
	import net.believecollective.frameworks.pureMVC2.patterns.mediators.DialogueViewMediatorBase;
	import net.believecollective.utils.webservices.WebServiceLoadRequestVO;

	import org.puremvc.as3.interfaces.INotification;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	/**
	 * @author Dan Mackie (dan@believecollective.net)
	 */
	public class EventsDetailViewMediator extends DialogueViewMediatorBase {

		public static const NAME : String = "EventsDetailViewMediator";
		
		private var _oNextEvent: AGEventVO;
		private var _oPrevEvent: AGEventVO;
		
		private var _iOpenArticleID : int ; // the id of the article which is currently open (should not be navigated to)	
		
		public function EventsDetailViewMediator(viewComponent : Object = null) {
			super(viewComponent, NAME);
			gfx.gfx.addEventListener(IOErrorEvent.IO_ERROR, fImageLoadError); // if a thumbnail fails to load, it will halt the timeline gfx loading, this kickstarts it
			gfx.interfaceText = (facade.retrieveProxy(ConfigProxy.NAME) as ConfigProxy).fGetInterfaceTextVO(EventsDetailView.NAME);			
		}	
		
		private function fImageLoadError(e : IOErrorEvent) : void {
			sendNotification(ApplicationFacade.NOTE_GFX_LOAD_ERROR);
		}

		override protected function fViewEvent(event : Event) : void {
			var t_o : EventsDetailViewGFX = (gfx.gfx as EventsDetailViewGFX);
			var t_oTTVO : AGTooltipVO;
			var t_nX : Number;
			var t_nY : Number;
			///
			switch (event.type) {
				////
				case MouseEvent.MOUSE_OVER :
				switch (event.target.name) {
						case "_mcNext":
							// notify tooltip
							t_nX = gfx.x + event.target.x + (event.target.width/2) - ApplicationFacade.APP_WIDTH_DEFAULT + ApplicationFacade.APP_WIDTH;
							t_nY = event.target.parent.y + event.target.y;
							t_oTTVO = new AGTooltipVO("AGArrowBtn", _oNextEvent.eventName, "top", new Point(t_nX, t_nY),"left") as AGTooltipVO;
							sendNotification(ApplicationFacadeBase.TOOLTIP_TOGGLE_EVENT, t_oTTVO);
							break;
						case "_mcPrev":
							// notify tooltip
							t_nX = gfx.x + event.target.x + (event.target.width/-2) - ApplicationFacade.APP_WIDTH_DEFAULT + ApplicationFacade.APP_WIDTH;
							t_nY = event.target.parent.y + event.target.y;
							t_oTTVO = new AGTooltipVO("AGArrowBtn", _oPrevEvent.eventName, "top", new Point(t_nX, t_nY),"left") as AGTooltipVO;
							sendNotification(ApplicationFacadeBase.TOOLTIP_TOGGLE_EVENT, t_oTTVO);
							break;
					}	
					break;
					/////
				case MouseEvent.MOUSE_OUT :	
					switch (event.target.name) {
						case "_mcNext":
							// notify tooltip
							sendNotification(ApplicationFacadeBase.TOOLTIP_TOGGLE_EVENT, null);
							break;
						case "_mcPrev":
							// notify tooltip
							sendNotification(ApplicationFacadeBase.TOOLTIP_TOGGLE_EVENT, null);
							break;
					}
					break;
					/////
				case MouseEvent.CLICK:
					switch (event.target.name) {
						case 'readmore':
						case 'readmore2':
							(facade.retrieveProxy(ConfigProxy.NAME) as ConfigProxy).sendNotification(ApplicationFacade.NOTE_OPEN_EVENT_URL);
							t_o.fToggle(false);
						break;
						case "mcCancelButton":
							fCallFunctionOnHide = oCBFunctionCancel;
							sendNotification(ApplicationFacade.NOTE_CLOSE_PANEL);
							sendNotification(ApplicationFacadeBase.TOOLTIP_TOGGLE_EVENT, null);
							ApplicationFacade.EVENT_IS_ACTIVE = false;
							break;
						case "_mcNext":
							// notify new event
							ApplicationFacade.ACTIVE_ITEM_ID = _oNextEvent.eventID;
							(facade.retrieveProxy(TimelineProxy.NAME) as TimelineProxy).fSetGlobalVars(ApplicationFacade.NOTE_TIMELINE_EVENT_ACTIVE);
							sendNotification(ApplicationFacadeBase.TOOLTIP_TOGGLE_EVENT, null);
							break;
						case "_mcPrev":
							// notify new event
							ApplicationFacade.ACTIVE_ITEM_ID = _oPrevEvent.eventID;
							(facade.retrieveProxy(TimelineProxy.NAME) as TimelineProxy).fSetGlobalVars(ApplicationFacade.NOTE_TIMELINE_EVENT_ACTIVE);
							sendNotification(ApplicationFacadeBase.TOOLTIP_TOGGLE_EVENT, null);
							break;	
					}
				break;
				////
			}
		}

		override public function listNotificationInterests() : Array {
			var t_a : Array = super.listNotificationInterests();
			var t_a2 : Array = t_a.concat	(
												ApplicationFacade.NOTE_TIMELINE_EVENT_ACTIVE, 
												ApplicationFacade.NOTE_DATA_UPDATE,
												ApplicationFacade.NOTE_ENTERING_NEW_ERA,
												ApplicationFacade.NOTE_INIT_VIEWS,
												ApplicationFacade.NOTE_CLOSE_PANEL);
			return 	t_a2;
		}

		/**
		 * Handle all notifications this Mediator is interested in.
		 * 
		 * @param INotification a notification 
		 */
		override public function handleNotification( note : INotification ) : void {
			super.handleNotification(note);
			switch ( note.getName() ) {
				case ApplicationFacade.NOTE_INIT_VIEWS : //SETUP
				gfx.x = ApplicationFacade.DETAIL_PANEL_X; // position correctly
				_iOpenArticleID = ApplicationFacade.ACTIVE_ITEM_ID; // disables readmore link for tis item
				break;
				////
				case ApplicationFacade.NOTE_TIMELINE_EVENT_ACTIVE: // TOGGLES VIEWGFX ON & LOOKS FOR DATA NEEDED
					fEventActive();					
					break;
				/////
				case ApplicationFacade.NOTE_DATA_UPDATE: // NEW DATA IS RECEIVED FROM WEBSERVICE & PARSED INTO VO:
					if (note.getBody() is AGEventDetailVO){
						var t_oProxy : TimelineProxy = facade.retrieveProxy(TimelineProxy.NAME) as TimelineProxy;
						var t_oDetailVO : AGEventDetailVO = note.getBody() as AGEventDetailVO;
						// activate the panel
						gfx.fUpdate(t_oDetailVO, ApplicationFacade.NOTE_DATA_UPDATE);
						// store the VO
//						(facade.retrieveProxy(HistoryProxy.NAME) as HistoryProxy).historyObject.data.detailVOs[ApplicationFacade.ACTIVE_ITEM_ID] = note.getBody();
					}
					break;
				////
				case ApplicationFacade.NOTE_ENTERING_NEW_ERA :
				case ApplicationFacade.NOTE_CLOSE_PANEL:
					(gfx.gfx as EventsDetailViewGFX).fToggle(false);
					ApplicationFacade.EVENT_IS_ACTIVE = false;
					break;
			}
		}

//////// SETTINGS AND DATA FOR POPULATING PANEL:
		private function fEventActive() : void {
			//// RESET FIRST
			(gfx.gfx as EventsDetailViewGFX).fReset();
			//// GET SETTINGS
			var t_oProxy : TimelineProxy = facade.retrieveProxy(TimelineProxy.NAME) as TimelineProxy;
			_oNextEvent = t_oProxy.fGetNextEvent(); // next event VO ?
			_oPrevEvent = t_oProxy.fGetPrevEvent(); // prev event VO 	
			var t_bFactoid : Boolean = t_oProxy.fEventIsFactoid(); // factoid ?
			var t_sTimeline : String = t_oProxy.fGetEventTimeline(); // timeline section
			// APPLY SETTINGS
			var t_a : Array = 	[
								t_oProxy.fEventThumbName(), // heading
								t_bFactoid, // determines if readmore is enabled
								(_oPrevEvent != null), // determines if prev btn is enabled 
								(_oNextEvent != null), // determines if nxt btn is enabled 
								t_sTimeline, // timeline emblem & title 										
								(_iOpenArticleID == ApplicationFacade.ACTIVE_ITEM_ID && ApplicationFacade.IS_FACEBOOK != true) // flag to dissable/ display alt text read more
								];
			gfx.fUpdate(t_a, ApplicationFacade.NOTE_TIMELINE_EVENT_ACTIVE);
			//  EVENTS DETAIL VO
			if ((facade.retrieveProxy(HistoryProxy.NAME) as HistoryProxy).historyObject.data.detailVOs[ApplicationFacade.ACTIVE_ITEM_ID] is AGEventDetailVO){
				// if the VO is already available, activate the panel
				gfx.fUpdate((facade.retrieveProxy(HistoryProxy.NAME) as HistoryProxy).historyObject.data.detailVOs[ApplicationFacade.ACTIVE_ITEM_ID], ApplicationFacade.NOTE_DATA_UPDATE);
			}
			// else call web service
			else {
				var t_bBustCache : Boolean = !(facade.retrieveProxy(HistoryProxy.NAME) as HistoryProxy).returningUser;
				t_oProxy.sendNotification(ApplicationFacade.CMD_CALL_WEBSERVICE, new WebServiceLoadRequestVO(fConcatWebService(), ApplicationFacade.CMD_DETAIL_XML_PARSE, t_bBustCache));
			}
		}
		
//////// GET WEBSERVICE URL:
		private function fConcatWebService(): String {
			// Call webservice constucted from paths to get XML return
			var t_sURL : String;
			if (ApplicationFacade.IS_USING_LOCAL) t_sURL = ApplicationFacade.BASEPATH + ApplicationFacade.ARTICLE_SERVICE_LOCAL_FILENAME ;
			else {
				var t_s: String = ApplicationFacadeBase.ROOT.loaderInfo.parameters.articleservice;
				t_sURL = t_s.substring(0,t_s.length-7);
			}
			var t_sDetailWebserviceURL:String = 		
														t_sURL
														+ 	ApplicationFacade.URL_PAGEID_VAR
														+	ApplicationFacade.URL_PAIR_CHAR
														+	ApplicationFacade.ACTIVE_ITEM_ID 
														+ 	ApplicationFacade.URL_CONCAT_CHAR 
														+	ApplicationFacade.URL_LANG_VAR
														+	ApplicationFacade.URL_PAIR_CHAR
														+	ApplicationFacade.LANGUAGE;	
			return t_sDetailWebserviceURL;
		}
		
		
	}
}
