
package net.believecollective.ag2010.patterns.mediators {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.ag2010.model.vo.AGTooltipVO;
	import net.believecollective.ag2010.patterns.proxy.AGStageProxy;
	import net.believecollective.ag2010.patterns.proxy.TimelineProxy;
	import net.believecollective.ag2010.view.navigator.NavigatorView;
	import net.believecollective.ag2010.view.navigator.components.AGTimelineNavButton;
	import net.believecollective.ag2010.view.navigator.components.AGTimelineNavButtonFB;
	import net.believecollective.ag2010.view.navigator.components.AGTimelineNavViewer;
	import net.believecollective.ag2010.view.navigator.components.AGTimelineNavigatorBG;
	import net.believecollective.ag2010.view.navigator.components.NavigatorViewGFX;
	import net.believecollective.event.ButtonEvent;
	import net.believecollective.frameworks.pureMVC2.app.ApplicationFacadeBase;
	import net.believecollective.frameworks.pureMVC2.patterns.proxy.StageProxy;

	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;

	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	/**
	 * @author Dan Mackie (dan@believecollective.net)
	 */
	public class NavigatorViewMediator extends AGBaseMediator implements IMediator {

		public static const NAME : String = "NavigatorViewMediator";
		
		private var _oGFX : NavigatorViewGFX;
		private var _nXStartDrag : Number;	// used for dragging 		private var _nXStartHover : Number;	// used for date toolitip hover		private var _bShowDate : Boolean; 	// used for date toolitip hover
		
		public function NavigatorViewMediator(viewComponent : Object = null) {
			super(NAME, viewComponent);
		}	
		
		override protected function fViewEvent(event : Event) : void {
			//Listens to mouse events (listeners instantiated in super.super.super)
			super.fViewEvent(event);
			switch (event.type) {
				case MouseEvent.CLICK:
					sendNotification(ApplicationFacade.NOTE_TOGGLE_HELP, false);
					if (ApplicationFacade.EVENT_IS_ACTIVE) sendNotification(ApplicationFacade.NOTE_CLOSE_PANEL);
					if (event.target is AGTimelineNavViewer) return;
					else if (event.target is AGTimelineNavButton){
						ApplicationFacade.CURRENT_ERA_IN_VIEW = (event.target as AGTimelineNavButton).chronologicalPosition;
						ApplicationFacade.CURRENT_X_IN_FOCUS = (facade.retrieveProxy(TimelineProxy.NAME) as TimelineProxy).fGetEraStartX() + ApplicationFacade.HORIZONTAL_FOCUS_POINT; // positions the timeline with the relevant era diivider at the far left of the ap area
						(facade.retrieveProxy(TimelineProxy.NAME) as TimelineProxy).sendNotification(ApplicationFacade.NOTE_ENTERING_NEW_ERA);
					}
					else if (event.target is AGTimelineNavigatorBG) fNavBarClick(event);
					break;
				case MouseEvent.MOUSE_DOWN :
					if (event.target is AGTimelineNavViewer) fViewerMouseDown(event);					break;
				case MouseEvent.MOUSE_UP :
					if (event.target is AGTimelineNavViewer) fViewerMouseUp(event);					break;
				case ButtonEvent.RELEASE_OUTSIDE :
					if (event.target is AGTimelineNavViewer) fViewerMouseUp(event);
					break;
				case MouseEvent.MOUSE_OVER :
					if (event.target is AGTimelineNavigatorBG || event.target is AGTimelineNavViewer) {
						_nXStartHover = -1;
						_bShowDate = true;
						_oGFX.addEventListener(Event.ENTER_FRAME, fShowDate);
					}
					else if (event.target is AGTimelineNavButtonFB)
					{
						// notify tooltip
						var t_nX : Number = gfx.x + event.target.parent.x + event.target.x + (event.target.width/2) - ApplicationFacade.APP_WIDTH_DEFAULT + ApplicationFacade.APP_WIDTH;
						var t_nY : Number = event.target.parent.y + event.target.y;
						var t_sDirection : String = (event.target.x < ApplicationFacade.APP_WIDTH/2) ? "right" : "left"; 
						var t_oTTVO : AGTooltipVO = new AGTooltipVO("AGNavButton", (event.target as AGTimelineNavButtonFB).theDate, "top", new Point(t_nX, t_nY),t_sDirection) as AGTooltipVO;
						sendNotification(ApplicationFacadeBase.TOOLTIP_TOGGLE_EVENT, t_oTTVO);
					}
					break;
				case MouseEvent.MOUSE_OUT :
					if (event.target is AGTimelineNavigatorBG || event.target is AGTimelineNavViewer) _bShowDate = false;
					else if (event.target is AGTimelineNavButtonFB) sendNotification(ApplicationFacadeBase.TOOLTIP_TOGGLE_EVENT, null);
					break;
				break;
			}
		}

		private function fShowDate(event : Event) : void {
			if (!_bShowDate) {
				sendNotification(ApplicationFacadeBase.TOOLTIP_TOGGLE_EVENT);
				_oGFX.removeEventListener(Event.ENTER_FRAME, fShowDate);
				return;
			}
			//
			else if (_nXStartHover == _oGFX.mcScene.mouseX ) return; // mouse hasn't moved, no need to change tooltip
			_nXStartHover = _oGFX.mcScene.mouseX;
			var t_nPercentage : Number =  _oGFX.mcScene.mouseX  /  _oGFX.mcScene.visibleWidth;
			// account for rounding errors
			if (t_nPercentage < 0) t_nPercentage = 0;
			if (t_nPercentage > 1) t_nPercentage = 1;
			var t_s : String = String(_oTimeline.fCalculateYear(t_nPercentage));
			if ( ApplicationFacade.CURRENT_ERA_IN_VIEW == 0) {
				//mythic beginnings era uses BCE and CE nototation
				 t_s = (t_s.charAt(0) == "-") ? t_s.substring(1)+ " BCE" : t_s + " CE";
			}
			sendNotification(ApplicationFacadeBase.TOOLTIP_TOGGLE_EVENT, new AGTooltipVO("", t_s, "top",new Point(_oGFX.x + _oGFX.mcScene.mouseX + _oGFX.mcScene.x, _oGFX.y +_oGFX.mcScene.y)));
		}

		
		private function fViewerMouseDown(event : Event = null) : void {
			ApplicationFacade.IS_DRAGGING = true;
			_nXStartDrag = _oGFX.mouseX;
			viewComponent.addEventListener(Event.ENTER_FRAME, fViewerMouseDrag);
			(facade.retrieveProxy(StageProxy.NAME) as AGStageProxy).fDrag();
		}

		private function fViewerMouseUp(event : Event = null) : void {
			viewComponent.removeEventListener(Event.ENTER_FRAME, fViewerMouseDrag);
			ApplicationFacade.IS_DRAGGING = false;
		}

		private function fNavBarClick(event : Event) : void {
			var t_nPercentage : Number = (_oGFX.mcScene.mouseX - (0.5 *_oGFX.mcViewer.width))  / _oGFX.scrollWidth ;
			// account for rounding errors
			if (t_nPercentage < 0) t_nPercentage = 0;
			if (t_nPercentage > 1) t_nPercentage = 1;
			// set new focus point and send notification
			ApplicationFacade.CURRENT_X_IN_FOCUS = ApplicationFacade.HORIZONTAL_FOCUS_POINT + _oGFX.eraStart + (t_nPercentage * _oGFX.eraWidth);
			_oConfig.sendNotification(ApplicationFacade.NOTE_TIMELINE_MOVE);
		}

		private function fViewerMouseDrag(event : Event = null) : void {
			if (_oGFX.mouseX == _nXStartDrag)return;
			var t_nPercentage : Number =_oGFX.viewerPos +  ((_oGFX.mouseX - _nXStartDrag) / _oGFX.scrollWidth) ;
			if (t_nPercentage < 0) t_nPercentage = 0;
			if (t_nPercentage > 1) t_nPercentage = 1;
			ApplicationFacade.CURRENT_X_IN_FOCUS = ApplicationFacade.HORIZONTAL_FOCUS_POINT + _oGFX.eraStart + (t_nPercentage * _oGFX.eraWidth);
			_oConfig.sendNotification(ApplicationFacade.NOTE_TIMELINE_MOVE);
			_nXStartDrag = _oGFX.mouseX;
		}
		
		public function get gfx() : NavigatorView {	
			return viewComponent as NavigatorView;	
		}

		override public function listNotificationInterests() : Array {
			var t_a : Array = super.listNotificationInterests();
			var t_a2 : Array = t_a.concat	(
												ApplicationFacade.NOTE_FINISH_LOADING_SEQUENCE,
												ApplicationFacade.NOTE_MOUSE_LEAVE, 
												ApplicationFacade.NOTE_TIMELINE_MOVE,
												ApplicationFacade.NOTE_ENTERING_NEW_ERA,												ApplicationFacade.NOTE_TIMELINE_EVENT_ACTIVE
												);
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
				case ApplicationFacade.NOTE_FINISH_LOADING_SEQUENCE:
					viewComponent.fUpdate(_oTimeline.timeline.eras[ApplicationFacade.CURRENT_ERA_IN_VIEW], ApplicationFacade.NOTE_FINISH_LOADING_SEQUENCE);
					_oGFX = viewComponent.gfx as NavigatorViewGFX;
					_oGFX.mcViewer.addEventListener(ButtonEvent.RELEASE_OUTSIDE, fViewEvent);
					break;
				case ApplicationFacade.NOTE_MOUSE_LEAVE:
					fViewerMouseUp();
					break;
				case ApplicationFacade.NOTE_TIMELINE_MOVE:
					viewComponent.fUpdate(_oTimeline.timeline.eras[ApplicationFacade.CURRENT_ERA_IN_VIEW], ApplicationFacade.NOTE_TIMELINE_MOVE);
					break;
				case ApplicationFacade.NOTE_TIMELINE_EVENT_ACTIVE:
					viewComponent.fUpdate(_oTimeline.timeline.eras[ApplicationFacade.CURRENT_ERA_IN_VIEW], ApplicationFacade.NOTE_TIMELINE_EVENT_ACTIVE);
					break;
				case ApplicationFacade.NOTE_ENTERING_NEW_ERA:
					viewComponent.fUpdate(_oTimeline.timeline.eras[ApplicationFacade.CURRENT_ERA_IN_VIEW], ApplicationFacade.NOTE_ENTERING_NEW_ERA);
					break;
				
			}
		}


	}
}
