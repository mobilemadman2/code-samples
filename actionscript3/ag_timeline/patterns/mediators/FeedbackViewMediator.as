
package net.believecollective.ag2010.patterns.mediators {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.ag2010.patterns.proxy.ConfigProxy;
	import net.believecollective.ag2010.patterns.proxy.HistoryProxy;
	import net.believecollective.ag2010.view.feedback.FeedbackView;
	import net.believecollective.ag2010.view.feedback.components.FeedbackViewGFX;
	import net.believecollective.frameworks.pureMVC2.patterns.mediators.DialogueViewMediatorBase;
	import net.believecollective.frameworks.pureMVC2.view.ViewBase;
	import net.believecollective.model.vo.DialogVO;

	import org.puremvc.as3.interfaces.INotification;

	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * @author DM
	 */
	public class FeedbackViewMediator extends DialogueViewMediatorBase {
		
		public static const NAME : String = "FeedbackViewMediator";
				
		public function FeedbackViewMediator(viewComponent : Object = null, arg_sName : String = NAME) {
			super(viewComponent, arg_sName);
			gfx.interfaceText = (facade.retrieveProxy(ConfigProxy.NAME) as ConfigProxy).fGetInterfaceTextVO(FeedbackView.NAME);	
		}
		
		override public function get gfx() : ViewBase {
			return viewComponent as FeedbackView;
		}
		
		override protected function fViewEvent(event : Event) : void {
			var t_o : FeedbackViewGFX = (gfx.gfx as FeedbackViewGFX);
			switch (event.type) {
				case MouseEvent.CLICK:
					switch (event.target.name) {
						case "mcConfirmButton":
							fCallFunctionOnHide = oCBFunctionConfirm;
							if (fCallFunctionOnHide) fCallFunctionOnHide.call();
							t_o.fToggle(false);
							(facade.retrieveProxy(HistoryProxy.NAME) as HistoryProxy).historyObject.data.showFeedback = !t_o.mcRadio.isChecked;
							break;
						case "mcCancelButton":
							fCallFunctionOnHide = oCBFunctionCancel;
							if (fCallFunctionOnHide) fCallFunctionOnHide.call();
							t_o.fToggle(false);
							(facade.retrieveProxy(HistoryProxy.NAME) as HistoryProxy).historyObject.data.showFeedback = !t_o.mcRadio.isChecked;
							break;		
					}
				default:
					break;
			}
		}
		
		override public function listNotificationInterests() : Array {
			var t_a : Array = super.listNotificationInterests();
			var t_a2 : Array = t_a.concat	(
												ApplicationFacade.NOTE_SHOW_FEEDBACK
											);
			return 	t_a2;
		}
		
		override public function handleNotification( note : INotification ) : void {
			super.handleNotification(note);	
			switch ( note.getName() ) {
				case ApplicationFacade.NOTE_SHOW_FEEDBACK:
					var t_oCB : DialogVO = note.getBody() as DialogVO;
					oCBFunctionCancel = t_oCB.callbackFunctionCancel;
					oCBFunctionConfirm = t_oCB.callbackFunctionConfirm;	
					gfx.fUpdate(t_oCB, note.getName());
					break;
			}
		}
	}
}
