
package net.believecollective.ag2010.view.eventsdetail {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.ag2010.model.vo.timeline.events.AGEventDetailVO;
	import net.believecollective.ag2010.view.eventsdetail.components.EventsDetailViewGFX;
	import net.believecollective.ag2010.view.generics.buttons.AGTextBtn;
	import net.believecollective.ag2010.view.generics.buttons.AGTextLink;
	import net.believecollective.frameworks.pureMVC2.view.dialogue.DialogueView;
	import net.believecollective.model.vo.InterfaceLanguageVO;
	import net.believecollective.model.vo.ViewTextVO;

	import com.greensock.TweenMax;

	/**
	 * @author Dan Mackie (dan@believecollective.net)
	 */
	public class EventsDetailView extends DialogueView {
		
		public static const NAME : String = "EventsDetailView";
		
		public function EventsDetailView() {
			super();
			if (ApplicationFacade.IS_FACEBOOK) this.x = ApplicationFacade.APP_WIDTH_DEFAULT - ApplicationFacade.APP_WIDTH_FB;
		}

		override public function fInit() : void {
			mcGFX = fCreateGFX();
		}

		private function fCreateGFX() : EventsDetailViewGFX {
			var t_o : EventsDetailViewGFX = new EventsDetailViewGFX();
			TweenMax.to(t_o, 0, {autoAlpha: 0});
			addChild(t_o);
			return t_o;
		}

		override public function fUpdate(arg_o : Object = null, arg_sEvent : String = "") : void {
			switch(arg_sEvent){
				case ApplicationFacade.NOTE_TIMELINE_EVENT_ACTIVE:
					var t_sTinelineTitle : String;					// set timeline title string (comes from language xml)
					for each (var o : ViewTextVO in _oInterfaceText.theInterfaceText) {
						if (o.theID == arg_o[4] as String){
							t_sTinelineTitle = o.theText;
						break;
						}
					}
					(mcGFX as EventsDetailViewGFX).fActivate(arg_o[0], arg_o[1], arg_o[2], arg_o[3], t_sTinelineTitle, arg_o[4], arg_o[5]);
					break;
				case ApplicationFacade.NOTE_DATA_UPDATE: 
					// the detail xml is loaded
					var t_o : AGEventDetailVO = arg_o as AGEventDetailVO;
					(mcGFX as EventsDetailViewGFX).fInit(t_o.title, t_o.content, t_o.credits);
					break;
			}
		}
		
		override public function set interfaceText(arg_o : InterfaceLanguageVO) : void {
			super.interfaceText = arg_o;
			for each (var oVO : ViewTextVO in _oInterfaceText.theInterfaceText) {
				switch (oVO.theID){
					case "ReadMoreButton" :
						(mcGFX.mcConfirmButton2 as AGTextBtn).theText = oVO.theText;
					break;
					case "ReadMoreLink" :
						(mcGFX.mcConfirmButton as AGTextLink).theText = oVO.theText;
						break;
					case "ReadMoreLinkAlt" :
						(mcGFX.mcConfirmButton as AGTextLink).altText = oVO.theText;
					break;
				}
			}	
		}
	}
}
	