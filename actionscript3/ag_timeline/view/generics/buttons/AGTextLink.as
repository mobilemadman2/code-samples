package net.believecollective.ag2010.view.generics.buttons {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.utils.textfields.TextUtils;

	import com.greensock.TweenMax;

	import flash.events.MouseEvent;
	import flash.text.TextField;

	/**
	 * @author Marianne	
	 */
	public class AGTextLink extends AGTextBtn {		
		public function AGTextLink() {
			TweenMax.to(mcRollover, 0, {autoAlpha: 1});
		}
		
		override protected function fAddText() : void {
			var t_sFont : String = (ApplicationFacade.LANGUAGE == "ne") ? ApplicationFacade.FONT_GURUMAA : ApplicationFacade.FONT_CORBEL_REGULAR;
			// TODO get text frOM language xml!!!
			_mcText = (this.addChild(TextUtils.ADDTEXTFIELD(10, [0,0], 13, t_sFont, 0xbc7d2c, ""))) as TextField;
		}
	
		override public function fMouseMOUSE_OUT(event : MouseEvent) : void {
			TweenMax.to(this, ApplicationFacade.TWEEN_DURATION, {tint: 0xbc7d2c});
		}

		override public function fMouseMOUSE_OVER(event : MouseEvent) : void {
			TweenMax.to(this, ApplicationFacade.TWEEN_DURATION, {tint: 0xE2A85E});
		}
		
		override public function fResize(arg_nWidth : Number = -1, arg_bRound:Boolean = true) : void {
			if (arg_nWidth == -1) arg_nWidth = _mcText.width;
			mcRollover.width = arg_nWidth;
			_mcText.x = -1+(this.width - _mcText.width)/2;
		}
		
		override public function set theEnabled(arg_b : Boolean) : void {
			super.theEnabled = arg_b;
			var t_nTint : Number = (_bEnabled) ? 0xbc7d2c : 0x000000;
			TweenMax.to(this, ApplicationFacade.TWEEN_DURATION, {tint: t_nTint});
		}
		
	}
}

