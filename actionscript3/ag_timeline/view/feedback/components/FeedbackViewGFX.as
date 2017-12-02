
package net.believecollective.ag2010.view.feedback.components {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.ag2010.view.generics.buttons.AGRadioBtn;
	import net.believecollective.ag2010.view.generics.buttons.AGTextBtn;
	import net.believecollective.frameworks.pureMVC2.view.dialogue.components.DialogueViewGFX;
	import net.believecollective.frameworks.pureMVC2.view.textelements.TextElementBase;
	import net.believecollective.utils.textfields.HtmlTextField;
	import net.believecollective.utils.textfields.TextUtils;

	import com.greensock.TweenMax;

	import flash.text.StyleSheet;

	/**
	 * @author Dan M - dan@believecollective.net
	 */
	public class FeedbackViewGFX extends DialogueViewGFX {

		private var _mcContentText : HtmlTextField;		private var _mcTitleText : HtmlTextField;
		private var _mcRadio : AGRadioBtn;

		public function FeedbackViewGFX() {
			mcConfirmButton = new AGTextBtn() as AGTextBtn;
			mcCancelButton = new AGTextBtn() as AGTextBtn;			_mcRadio = new AGRadioBtn() as AGRadioBtn;
			super();
			TweenMax.to(mcPanel, 0, {dropShadowFilter:ApplicationFacade.BUTTON_DROP_OBJECT});
			mcPanel.mcBG.alpha = 0.8;
			mcBlocker.width = ApplicationFacade.APP_WIDTH;
			mcBlocker.height = ApplicationFacade.APP_HEIGHT;
			mcPanel.mcBG.mcBG.width = 420;
//			mcPanel.x = ApplicationFacade.DETAIL_PANEL_X;
			mcPanel.addChild(mcConfirmButton);
			mcPanel.addChild(mcCancelButton);
			_mcRadio = mcPanel.addChild(new AGRadioBtn()) as AGRadioBtn;
			mcCancelButton.x = 10;
			mcCancelButton.name = 'mcCancelButton';
			mcConfirmButton.name = 'mcConfirmButton';			_mcRadio.name = 'mcRadio';
			_mcRadio.x = 30;
		}    
		
		override public function fInit	(
									arg_sTitle : String = "", 
									arg_sMessage : String = "", 
									arg_sCancelBtnLabel : String = "", 
									arg_sConfirmBtnLabel : String = "",
									arg_sType:String = ""
								) : void {
			_mcRadio.fToggle(false);
			mcPanel.mcBG.mcBG.height = 0;
			mcConfirmButton.theText = arg_sConfirmBtnLabel;									mcCancelButton.theText = arg_sCancelBtnLabel;						
			mcConfirmButton.x = mcPanel.mcBG.width - mcConfirmButton.width - 10;
			if (_mcContentText) mcPanel.removeChild(_mcContentText);			if (_mcTitleText) mcPanel.removeChild(_mcTitleText);
			_mcContentText = fAddMsgTextField(arg_sMessage);			_mcTitleText = fAddTitleText(arg_sTitle);
			_mcRadio.y = _mcContentText.y + _mcContentText.height + 30;
			mcCancelButton.y = mcConfirmButton.y = _mcContentText.y + _mcContentText.height + 55;
			mcPanel.mcBG.mcBG.height = mcPanel.height +10;
			mcPanel.x = (ApplicationFacade.APP_WIDTH  - mcPanel.width)/2;			mcPanel.y = -30 + (ApplicationFacade.APP_HEIGHT - mcPanel.height)/2;
			fToggle(true);
		}

		private function fAddMsgTextField(arg_sText : String) : HtmlTextField {
			var t_sFont : String = (ApplicationFacade.LANGUAGE == "ne") ? ApplicationFacade.FONT_GURUMAA : ApplicationFacade.FONT_CORBEL_REGULAR;
			var t_oCSS : StyleSheet = new StyleSheet();
			t_oCSS.setStyle("p", {leading : '2'});
			return mcPanel.addChild(TextUtils.ADDTEXTFIELD(400, [10, 37], 14, t_sFont, 0xFFFFFF, "<p>"+arg_sText+"</p>", true, "left", t_oCSS)) as HtmlTextField;
		}
		
		private function fAddTitleText(arg_s: String) : HtmlTextField {
			var t_sFont : String = (ApplicationFacade.LANGUAGE == "ne") ? ApplicationFacade.FONT_GURUMAA : ApplicationFacade.FONT_AUDIMAT_BOLD;
			return mcPanel.addChild(TextUtils.ADDTEXTFIELD(10,[10,10], 17, t_sFont, 0xF26522, arg_s)) as HtmlTextField;
		}
		
		override protected function fAddMessageTextField() : TextElementBase {
			return null;
		} 
		
		override public function fToggle(arg_b:Boolean) : void {
			if (this.visible == arg_b) return;
			if (arg_b){
				this.alpha = 0;
				this.visible = true;
			}else{
				this.alpha = 1;
				this.visible = true;
			}
			var t_nA : Number = (arg_b) ? 1 : 0 ;
			TweenMax.to(this, 0.3, {autoAlpha:t_nA});
		}
		
		public function get mcRadio() : AGRadioBtn {
			return _mcRadio;
		}
	}
}
