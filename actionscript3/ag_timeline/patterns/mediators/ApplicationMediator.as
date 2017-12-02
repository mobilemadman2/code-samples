package net.believecollective.ag2010.patterns.mediators {	import net.believecollective.ag2010.app.ApplicationFacade;	import net.believecollective.ag2010.app.Main;	import net.believecollective.ag2010.patterns.proxy.AGStageProxy;	import net.believecollective.ag2010.patterns.proxy.ConfigProxy;	import net.believecollective.ag2010.patterns.proxy.HistoryProxy;	import net.believecollective.ag2010.patterns.proxy.TimelineProxy;	import net.believecollective.event.ExternalCallerEvent;	import net.believecollective.frameworks.pureMVC2.app.ApplicationFacadeBase;	import net.believecollective.frameworks.pureMVC2.patterns.mediators.BaseMediator;	import net.believecollective.frameworks.pureMVC2.patterns.proxy.StageProxy;	import net.believecollective.model.vo.DialogVO;	import net.believecollective.model.vo.ExternalCallerVO;	import net.believecollective.utils.Tracer;	import net.believecollective.utils.external_communication.ExternalCaller;	import org.puremvc.as3.interfaces.IMediator;	import org.puremvc.as3.interfaces.INotification;	import flash.display.StageDisplayState;	import flash.events.FullScreenEvent;	import flash.net.URLRequest;	import flash.net.navigateToURL;	/**	 * A Mediator for interacting with the top level Application		 * @author Dan Mackie (dan@believecollective.net)	 */	public class ApplicationMediator extends BaseMediator implements IMediator {		private var _bFullScreen : Boolean;		public static const NAME : String = "ApplicationMediator";		private var _oCP : ConfigProxy;		private var _iOpenArticleID : int ; // the id of the article which is currently open (should not be navigated to)						/**		 * Constructor		 *  		 * @param object the viewComponent (root display object in this case)		 */		public function ApplicationMediator( viewComponent : Main ) {			super(NAME, viewComponent);			_oCP = facade.retrieveProxy(ConfigProxy.NAME) as ConfigProxy;			fGetMinorPlatform();			viewComponent.stage.addEventListener(FullScreenEvent.FULL_SCREEN, fFullScreen);		}
		private function fFullScreen(event : FullScreenEvent) : void {			sendNotification(ApplicationFacadeBase.TOOLTIP_TOGGLE_EVENT); //turn off any tooltip			_bFullScreen = event.fullScreen;
		}
		public function fOpenURL(arg_s : String) : void {			var t_oExCaller:ExternalCaller = new ExternalCaller();			t_oExCaller.addEventListener(ExternalCallerEvent.EXTERNALRETURN, fExternalReturned);			t_oExCaller.addEventListener(ExternalCallerEvent.TIMEOUTFAIL, fExternalTimeoutFail);			t_oExCaller.fCall("fOpenURL",[arg_s]);		}		public function fExportSWF(arg_s : String) : void {			var t_oExCaller:ExternalCaller = new ExternalCaller();			t_oExCaller.addEventListener(ExternalCallerEvent.EXTERNALRETURN, fExternalReturned);			t_oExCaller.addEventListener(ExternalCallerEvent.TIMEOUTFAIL, fExternalTimeoutFail);			t_oExCaller.fCall("fExportAttachment",[arg_s]);		}		private function fExternalTimeoutFail(event : ExternalCallerEvent) : void {//			Tracer.TRACE("!!!DM : ApplicationMediator.fExternalTimeoutFail : ");		}		private function fExternalReturned(event : ExternalCallerEvent) : void {			if (!event.data) return;			var t_oData:ExternalCallerVO = event.data;//			Tracer.TRACE("!!!DM : ApplicationMediator.fExternalReturned : "+t_oData.callerFunction);//			Tracer.TRACE("!!!DM : ApplicationMediator.fExternalReturned : "+t_oData.returnObject);			switch (t_oData.callerFunction){				case "fGetPlatform":					if (!t_oData.returnObject) return;					Tracer.TRACE("!!!Dan M - dan@believecollective.net : ApplicationMediator.fExternalReturned : ");					Tracer.TRACE(t_oData.returnObject[0]);					Tracer.TRACE(t_oData.returnObject[1]);					Tracer.TRACE(t_oData.returnObject[2]);//					t_oData.returnObject[0] as String,//					t_oData.returnObject[1] as Number,//					t_oData.returnObject[2] as String					break;				case "addScript":					if (!t_oData.returnObject) return;//					Tracer.TRACE("!!!DM : ApplicationMediator.fExternalReturned : "+t_oData.returnObject);					break;				case "eval":					if (!t_oData.returnObject) return;//					Tracer.TRACE("The following platform information is used to determine potential issues with flash content");//					Tracer.TRACE("Acrobat version: "+t_oData.returnObject);					break;			}		}			public function fGetMinorPlatform() : void {			var t_oExCaller:ExternalCaller = new ExternalCaller();			t_oExCaller.addEventListener(ExternalCallerEvent.EXTERNALRETURN, fExternalReturned);			t_oExCaller.addEventListener(ExternalCallerEvent.TIMEOUTFAIL, fExternalTimeoutFail);			t_oExCaller.fCall("eval",["app.viewerVariation"]);		}				public function fGetPlatform() : void {			var t_oExCaller:ExternalCaller = new ExternalCaller();			t_oExCaller.addEventListener(ExternalCallerEvent.EXTERNALRETURN, fExternalReturned);			t_oExCaller.addEventListener(ExternalCallerEvent.TIMEOUTFAIL, fExternalTimeoutFail);			t_oExCaller.fCall("fGetPlatform");		}					override public function listNotificationInterests() : Array {			var t_a : Array = super.listNotificationInterests();			var t_a2 : Array = t_a.concat				(				ApplicationFacade.NOTE_INIT_VIEWS,				ApplicationFacade.NOTE_OPEN_EVENT_URL,				ApplicationFacade.NOTE_TIMELINE_EVENT_ACTIVE,				ApplicationFacade.NOTE_TOGGLE_FULL_SCREEN,				ApplicationFacade.NOTE_LAUNCH_TIMELINE,				"mouse_move"				);			return 	t_a2;		}		/**		 * Handle all notifications this Mediator is interested in.		 * 		 * @param INotification a notification 		 */		override public function handleNotification( note : INotification ) : void {			super.handleNotification(note);			switch ( note.getName() ) {				case ApplicationFacade.NOTE_INIT_VIEWS :					_iOpenArticleID = ApplicationFacade.ACTIVE_ITEM_ID;					break;					/////				case ApplicationFacade.NOTE_TOGGLE_FULL_SCREEN:					_bFullScreen = note.getBody() as Boolean;					var t_s : String = (_bFullScreen) ? StageDisplayState.FULL_SCREEN : StageDisplayState.NORMAL;					(facade.retrieveProxy(StageProxy.NAME) as AGStageProxy).stage.displayState = t_s;					break;					/////				case ApplicationFacade.NOTE_TIMELINE_EVENT_ACTIVE:					ApplicationFacade.EVENT_IS_ACTIVE = true;					(facade.retrieveProxy(HistoryProxy.NAME) as HistoryProxy).historyObject.data.eventIDs.push(ApplicationFacade.ACTIVE_ITEM_ID);					break;					/////				case ApplicationFacade.NOTE_OPEN_EVENT_URL:					if (_bFullScreen && (facade.retrieveProxy(HistoryProxy.NAME) as HistoryProxy).historyObject.data.showFeedback == true) sendNotification(ApplicationFacade.NOTE_SHOW_FEEDBACK, new DialogVO(null, fReadMore, "", "", "", "", "ReadMore" ));					else fReadMore();					break;				case ApplicationFacade.NOTE_LAUNCH_TIMELINE:					navigateToURL(new URLRequest(ApplicationFacade.TIMELINE_PATH), "_blank");					break;			}		}				private function fReadMore() : void {			var t_s : String = (facade.retrieveProxy(TimelineProxy.NAME) as TimelineProxy).fGetEventURL();			var t_sTarget : String = (ApplicationFacade.IS_FACEBOOK) ? "_blank" : "_self";			if (t_s != null) navigateToURL(new URLRequest(t_s), t_sTarget);		}				public function get fullScreen() : Boolean {			return _bFullScreen;		}	}}