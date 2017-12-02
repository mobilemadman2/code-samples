package net.believecollective.ag2010.view.generics.buttons {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.frameworks.pureMVC2.view.buttons.BButtonBase;
	import net.believecollective.model.vo.BButtonDefaultVO;

	import com.greensock.TweenMax;

	import flash.display.Sprite;
	import flash.events.MouseEvent;

	/**
	 * @author Marianne
	 */
	public class AGButton extends BButtonBase {
		
		public var mcRollover : Sprite;
		
		public function AGButton(arg_oBVO : BButtonDefaultVO = null) {
			super(arg_oBVO);
			TweenMax.to(mcRollover, 0, {autoAlpha: 0});
		}
		
		public function fToggle(arg_b: Boolean) : void {
			var t_nAlpha : Number = (arg_b) ? 1 : 0;
			TweenMax.to(mcRollover, ApplicationFacade.TWEEN_DURATION, {autoAlpha: t_nAlpha});
		}
		
		override public function fMouseMOUSE_OUT(event : MouseEvent) : void {
			super.fMouseMOUSE_OUT(event);
			fToggle(false);
		}

		override public function fMouseMOUSE_OVER(event : MouseEvent) : void {
			super.fMouseMOUSE_OVER(event);
			fToggle(true);
		}
		
		override public function set theEnabled(arg_b : Boolean) : void {
			if (arg_b == _bEnabled) return;
			super.theEnabled = arg_b;
			var t_nAlpha : Number = (_bEnabled) ? 1 : 0.5;
			TweenMax.to(this, ApplicationFacade.TWEEN_DURATION, {autoAlpha: t_nAlpha});
		}
		
	}
}
