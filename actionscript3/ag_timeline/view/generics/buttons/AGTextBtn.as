package net.believecollective.ag2010.view.generics.buttons {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.utils.textfields.TextUtils;

	import flash.text.TextField;

	/**
	 * @author Marianne
	 */
	public class AGTextBtn extends AGButton {
		
		protected var _mcText : TextField;
		
		protected var _sText : String;		protected var _sAltText : String;

		public function AGTextBtn() {
			fAddText();
		}

		protected function fAddText() : void {
			var t_sFont : String = (ApplicationFacade.LANGUAGE == "ne") ? ApplicationFacade.FONT_GURUMAA : ApplicationFacade.FONT_AUDIMAT_REGULAR;
			_mcText = (this.addChild(TextUtils.ADDTEXTFIELD(10, [0,0], 14, t_sFont, 0xFFFFFF, ""))) as TextField;
		}

		override public function set theText(arg_s : String) : void {
			_sText = arg_s;
			if (_mcText.htmlText == arg_s) return;
			_mcText.htmlText = arg_s;
			fResize();
		}
		
		public function fToggleText(arg_bAltText : Boolean) : void {
			var t_s : String = (arg_bAltText) ? _sAltText : _sText;
			if (_mcText.htmlText == t_s) return;
			_mcText.htmlText = t_s;
			fResize();
		}
		
		public function set altText(arg_s : String) : void {
			_sAltText = arg_s;
		}

		override public function fResize(arg_nWidth : Number = -1, arg_bRound:Boolean = true) : void {
			super.fResize(arg_nWidth, arg_bRound);
			if (mcRollover && mcBG) mcRollover.width = mcBG.width;
			_mcText.x = -1+(this.width - _mcText.width)/2;
			_mcText.y = -1+(this.height - _mcText.height) / 2;		}
	}
}

