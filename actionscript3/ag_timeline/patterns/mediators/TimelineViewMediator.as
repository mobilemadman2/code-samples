
package net.believecollective.ag2010.patterns.mediators {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.ag2010.patterns.proxy.AGStageProxy;
	import net.believecollective.ag2010.patterns.proxy.HistoryProxy;
	import net.believecollective.ag2010.view.timeline.TimelineView;
	import net.believecollective.ag2010.view.timeline.components.AGTimelineEra;
	import net.believecollective.ag2010.view.timeline.components.TimelineViewGFX;
	import net.believecollective.ag2010.view.timeline.components.timelineelements.AGTimeLineElementsBase;
	import net.believecollective.ag2010.view.timeline.components.timelineelements.AGTimelineEventGraphic;
	import net.believecollective.ag2010.view.timeline.components.timelineelements.AGTimelineEventLabel;
	import net.believecollective.event.ButtonEvent;
	import net.believecollective.frameworks.pureMVC2.patterns.proxy.StageProxy;

	import com.greensock.TweenMax;

	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;

	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * @author Dan Mackie (dan@believecollective.net)
	 */
	public class TimelineViewMediator extends AGBaseMediator implements IMediator {

		public static const NAME : String = "TimelineViewMediator";
		
		private var _nXStartDrag : Number;
		private var _nYearStartDrag : Number;
		private var _nTimer : Number;
		
		
		public function TimelineViewMediator(viewComponent : Object = null) {
			super(NAME, viewComponent);
			ButtonEvent.makeButton(viewComponent.gfx); // imp for release outside 
			(viewComponent.gfx).addEventListener(ButtonEvent.RELEASE_OUTSIDE, fViewEvent);
//			gfx.gfx.addEventListener(IOErrorEvent.IO_ERROR, fImageLoadError); // if a thumbnail fails to load, this will halt the timeline gfx loading
			_nTimer = 0;			gfx.addEventListener(Event.ENTER_FRAME, fCheckLoadStatus);
		}	

		private function fCheckLoadStatus(event : Event) : void {
			_nTimer ++;
			if (_nTimer / ApplicationFacade.FRAME_RATE == 120){
				// after 1 minute, check that the loading hasn't frozen
				if (gfx.gfx.isLoading) {
					// kickstart the load sequence
					(gfx.gfx as TimelineViewGFX).fLoadNextAsset();
					_nTimer = 0;
				}
				else gfx.removeEventListener(Event.ENTER_FRAME, fCheckLoadStatus);
			}
		}
		
		override protected function fViewEvent(event : Event) : void {
			//Listens to mouse events (listeners instantiated in super.super.super)
			super.fViewEvent(event);
			switch (event.type) {				case MouseEvent.CLICK:
					sendNotification(ApplicationFacade.NOTE_TOGGLE_HELP, false);
					if (event.target is TimelineViewGFX) return; 
					else if (event.target is AGTimelineEventGraphic || event.target is AGTimelineEventLabel){
						if (ApplicationFacade.EVENT_IS_ACTIVE && ApplicationFacade.ACTIVE_ITEM_ID == (event.target as AGTimeLineElementsBase).eventID) sendNotification(ApplicationFacade.NOTE_CLOSE_PANEL);
						ApplicationFacade.ACTIVE_ITEM_ID = (event.target as AGTimeLineElementsBase).eventID;
						_oTimeline.fSetGlobalVars(ApplicationFacade.NOTE_TIMELINE_EVENT_ACTIVE); // sends notification to call webservice for this event ID
					}
					else if (ApplicationFacade.EVENT_IS_ACTIVE)sendNotification(ApplicationFacade.NOTE_CLOSE_PANEL);
					break;
				case MouseEvent.MOUSE_DOWN:
					fMouseDown(event);
					break;
				case MouseEvent.MOUSE_UP:
				case ButtonEvent.RELEASE_OUTSIDE:
					fMouseUp(event);
					break;
				case MouseEvent.MOUSE_OVER:
					if (event.target is AGTimelineEventGraphic || event.target is AGTimelineEventLabel){
						gfx.fUpdate(event.target.eventID, "mouse_over");
					} 
					break;
				case MouseEvent.MOUSE_OUT:
					if (event.target is AGTimelineEventGraphic || event.target is AGTimelineEventLabel){
						gfx.fUpdate(event.target.eventID, "mouse_out");
					}
					break;
			}
		}


		private function fFollowMouse(event : Event) : void {
			// move timeline according to mouse position...
			if (viewComponent.gfx.mouseY > 260 || ApplicationFacade.IS_DRAGGING || ApplicationFacade.EVENT_IS_ACTIVE) return; // while user is interacting with NavigationView or actively dragging the timeline, don't auto scroll
			// else drift around focus point
			var t_nDriftX : Number = (viewComponent.gfx.mouseX - ApplicationFacade.HORIZONTAL_FOCUS_POINT) / -50;
			var t_nDriftY : Number = viewComponent.gfx.mouseY  / -10;
			for each (var oEra : AGTimelineEra in (viewComponent.gfx as TimelineViewGFX).eraDisplayObjects) {
				TweenMax.to(oEra.theDrifters, ApplicationFacade.TWEEN_DURATION, {x: t_nDriftX, y:t_nDriftY});				TweenMax.to(oEra.theLabels, ApplicationFacade.TWEEN_DURATION, {x: t_nDriftX, y:t_nDriftY});			}
		}

		private function fMouseDown(event : Event) : void {
			(facade.retrieveProxy(StageProxy.NAME) as AGStageProxy).fDrag();
			ApplicationFacade.IS_DRAGGING = true;
			_nXStartDrag = gfx.mouseX;
			_nYearStartDrag = ApplicationFacade.CURRENT_X_IN_FOCUS;
			viewComponent.gfx.addEventListener(Event.ENTER_FRAME, fMouseDrag);
		}

		private function fMouseUp(event : Event = null) : void {
			viewComponent.gfx.removeEventListener(Event.ENTER_FRAME, fMouseDrag);
			ApplicationFacade.IS_DRAGGING = false;
		}

		private function fMouseDrag(event : Event) : void {
//			if (viewComponent.gfx.mouseX < -1 || viewComponent.gfx.mouseX > ApplicationFacade.APP_WIDTH -1 || viewComponent.gfx.mouseY < -1 || viewComponent.gfx.mouseY > ApplicationFacade.APP_HEIGHT) fMouseUp(event); // catch the mouse before it escapes the radar
			var t_nDisplacement : Number = 2*(viewComponent.gfx.mouseX - _nXStartDrag); 
			ApplicationFacade.CURRENT_X_IN_FOCUS = _nYearStartDrag - t_nDisplacement;
			_oConfig.sendNotification(ApplicationFacade.NOTE_TIMELINE_MOVE);
		}

		override public function listNotificationInterests() : Array {
			var t_a : Array = super.listNotificationInterests();
			var t_a2 : Array = t_a.concat	(
												ApplicationFacade.NOTE_INIT_VIEWS,
												ApplicationFacade.NOTE_CLOSE_PANEL,
												ApplicationFacade.NOTE_NEW_DATA_LOADED, 
												ApplicationFacade.NOTE_TIMELINE_MOVE,
												ApplicationFacade.NOTE_MOUSE_LEAVE, 
												ApplicationFacade.NOTE_TIMELINE_BOUNCE,
												ApplicationFacade.NOTE_TIMELINE_EVENT_ACTIVE,
												ApplicationFacade.NOTE_ENTERING_NEW_ERA,
												ApplicationFacade.NOTE_GFX_LOAD_ERROR);
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
				case ApplicationFacade.NOTE_GFX_LOAD_ERROR:
					(gfx.gfx as TimelineViewGFX).fLoadNextAsset();
					break;
				case ApplicationFacade.NOTE_NEW_DATA_LOADED:
					viewComponent.fUpdate(_oLandscape.landscape, ApplicationFacade.NOTE_NEW_DATA_LOADED);
					gfx.addEventListener(Event.ENTER_FRAME, fFollowMouse);
					break;
				case ApplicationFacade.NOTE_TIMELINE_MOVE:
					if (_oTimeline.fCheckBounds()) viewComponent.fUpdate(null, ApplicationFacade.NOTE_TIMELINE_MOVE);
					break;
				case ApplicationFacade.NOTE_MOUSE_LEAVE:
					fMouseUp();
					break;
				case ApplicationFacade.NOTE_TIMELINE_EVENT_ACTIVE:
					viewComponent.fUpdate( null, note.getName());
					viewComponent.gfx.mcGradient.fToggle(true);
					break;
				case ApplicationFacade.NOTE_CLOSE_PANEL:
					viewComponent.gfx.mcGradient.fToggle(false);
					break;
				case ApplicationFacade.NOTE_INIT_VIEWS:
					var t_oProxy : HistoryProxy = facade.retrieveProxy(HistoryProxy.NAME) as HistoryProxy;
					viewComponent.fUpdate(t_oProxy, note.getName());
					break;
				case ApplicationFacade.NOTE_TIMELINE_BOUNCE:
					viewComponent.fUpdate(note.getBody(), note.getName());
					break;
				case ApplicationFacade.NOTE_ENTERING_NEW_ERA:
					viewComponent.fUpdate(null, note.getName());
					break;
			}
		}

		public function get gfx() : TimelineView {	
			return viewComponent as TimelineView;	
		}
		
	}
}
