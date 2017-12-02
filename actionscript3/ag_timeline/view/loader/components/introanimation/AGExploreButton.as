package net.believecollective.ag2010.view.loader.components.introanimation {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.frameworks.pureMVC2.view.buttons.BButtonBase;
	import net.believecollective.model.vo.BButtonDefaultVO;
	import net.believecollective.utils.textfields.TextUtils;

	import com.greensock.TweenMax;

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	/**
	 * @author Marianne
	 */
	public class AGExploreButton extends BButtonBase {
		
		public static const NAME : String = "AGExploreButton";
		
		public var _mcRollover: MovieClip;		public var _mcGlow: MovieClip;		private var _mcText: TextField;
		
		public function AGExploreButton(arg_oBVO : BButtonDefaultVO = null) {
			fInit();
			this.alpha = 0;
			super(arg_oBVO);
			TweenMax.to(_mcRollover, ApplicationFacade.TWEEN_DURATION, {autoAlpha : 0});
			fAddText();
			TweenMax.to(this, 0.3, {delay: 0.2, autoAlpha: 1});
		}

		protected function fAddText() : void {
			var t_sFont : String = (ApplicationFacade.LANGUAGE == "ne") ? ApplicationFacade.FONT_GURUMAA : ApplicationFacade.FONT_AUDIMAT_REGULAR;
			_mcText = addChild(TextUtils.ADDTEXTFIELD(10, [5,-12], 18, t_sFont, 0xFFFFFF, "")) as TextField;
			
		}

		override public function fMouseMOUSE_OUT(event : MouseEvent) : void {
			if (event.target == _mcGlow) return;
			super.fMouseMOUSE_OUT(event);
			TweenMax.to(_mcRollover, ApplicationFacade.TWEEN_DURATION, {autoAlpha : 0});
		}

		override public function fMouseMOUSE_OVER(event : MouseEvent) : void {
			if (event.target ==  _mcGlow) return;
			super.fMouseMOUSE_OVER(event);
			TweenMax.to(_mcRollover, ApplicationFacade.TWEEN_DURATION, {autoAlpha : 1});
		}
		
		override public function set theText(arg_s : String) : void {
			_mcText.htmlText = arg_s;
			_mcText.x = -1 + (_mcRollover.width - _mcText.width) /2;
//			fResize();
		}
		
		override public function fResize(arg_nWidth : Number = -1, arg_bRound:Boolean = true) : void {
//			super.fResize(arg_nWidth, arg_bRound);
//			if (_mcRollover && mcBG) _mcRollover.width = mcBG.width;
//			_mcText.x = -1+(this.width - _mcText.width)/2;
		}
	}
}
