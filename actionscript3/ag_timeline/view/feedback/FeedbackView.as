
package net.believecollective.ag2010.view.feedback {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.ag2010.view.feedback.components.FeedbackViewGFX;
	import net.believecollective.frameworks.pureMVC2.view.dialogue.DialogueView;
	import net.believecollective.model.vo.DialogVO;
	import net.believecollective.model.vo.InterfaceLanguageVO;
	import net.believecollective.model.vo.ViewTextVO;

	import com.greensock.TweenMax;

	/**
	 * @author Dan M - dan@believecollective.net
	 */
	public class FeedbackView extends DialogueView {
		
		private const TITLE : String = "Title";		private const MESSAGE : String = "Message";		private const CONFIRM : String = "ConfirmBtn";		private const CANCEL : String = "CancelBtn";		private const DONT_SHOW : String = "DontShowText";

		public static const NAME : String = "FeedbackView";
		
		public function FeedbackView() {
			super();
		}
		
		override public function fInit() : void {;
			mcGFX = fCreateGFX();
		}

		private function fCreateGFX() : FeedbackViewGFX {
			var t_o : FeedbackViewGFX = new FeedbackViewGFX();
			addChild(t_o);
			TweenMax.to(t_o, 0, {autoAlpha: 0});
			return t_o;
		}
		
		override public function fUpdate(arg_o : Object = null, arg_sEvent : String = "") : void {
			switch (arg_sEvent){
				case ApplicationFacade.NOTE_SHOW_FEEDBACK:
					var t_o : DialogVO = arg_o as DialogVO;
					var t_sTitle : String = "";
					var t_sMessage : String = "";
					var t_sConfirm : String = "";
					var t_sCancel : String = "";
					for each (var oVO : ViewTextVO in _oInterfaceText.theInterfaceText) {
					switch(oVO.theID){
							case t_o.type + TITLE:
								t_sTitle = oVO.theText;
							break;
							case t_o.type + MESSAGE:
								t_sMessage = oVO.theText;
							break;
							case t_o.type + CONFIRM:
								t_sConfirm = oVO.theText;
							break;
							case t_o.type + CANCEL:
								t_sCancel = oVO.theText;
							break;
						}
					}
					(gfx as FeedbackViewGFX).fInit(t_sTitle, t_sMessage, t_sCancel, t_sConfirm, t_o.type);
				break;
			}
		}
		
		override public function set interfaceText(arg_oILVO : InterfaceLanguageVO) : void {
			_oInterfaceText = arg_oILVO;
			for each (var oVO : ViewTextVO in _oInterfaceText.theInterfaceText) {
				if (oVO.theID == DONT_SHOW) (gfx as FeedbackViewGFX).mcRadio.theText = oVO.theText;
			}
			
		}
	}
}
