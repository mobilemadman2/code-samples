
package net.believecollective.ag2010.patterns.mediators {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.ag2010.view.testpanel.TestPanelView;

	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;

	import flash.events.Event;
	import flash.events.MouseEvent;

	
	/**
	 * @author Dan Mackie (dan@believecollective.net)
	 */
	public class TestPanelViewMediator extends AGBaseMediator implements IMediator {

		public static const NAME : String = "TestPanelViewMediator";

		
		public function TestPanelViewMediator(viewComponent : Object = null) {
			super(NAME, viewComponent);
		}
		
		override protected function fViewEvent(event : Event) : void {
			//Listens to mouse events (listeners instantiated in super.super.super)
			super.fViewEvent(event);
			switch (event.type) {
				case MouseEvent.CLICK:
					var t_s:String = event.target.name as String;
					switch (t_s){
					}
			}
		}

		public function get gfx() : TestPanelView {
			return viewComponent as TestPanelView;
		}

		override public function listNotificationInterests() : Array {
			var t_a : Array = super.listNotificationInterests();
			var t_a2 : Array = t_a.concat	(
												ApplicationFacade.TESTNOTE_TOGGLE_TEST_PANEL
											);
//			Tracer.TRACE("!!!DM : TestPanelViewMediator.listNotificationInterests : "+t_a2);
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
				case ApplicationFacade.TESTNOTE_TOGGLE_TEST_PANEL:
					if (viewComponent.visible){
						fHideView();
					}else{
						fShowView();
					}
					break;
			}
		}

	}
}
