package net.believecollective.ag2010.view.generics.buttons {
	import net.believecollective.ag2010.app.ApplicationFacade;

	import com.greensock.TweenMax;

	import flash.display.Sprite;
	import flash.events.MouseEvent;

	/**
	 * @author Marianne
	 */
	public class AGRadioBtn extends AGTextLink {
		
		public var mcCheck : Sprite;		private var _bChecked : Boolean;
		
		public function AGRadioBtn() {
			super();
			TweenMax.to(_mcText, 0, {tint: 0xFFFFFF});			TweenMax.to(mcCheck, 0, {autoAlpha: 0});
			TweenMax.to(mcBG, 0, {autoAlpha : 0.7});
			_mcText.y -= 3;
		}

		override public function fToggle(arg_b: Boolean) : void {
			super.fToggle(arg_b);
			_bChecked = arg_b;
			var t_nAlpha : Number = (arg_b) ? 1 : 0;
			TweenMax.to(mcCheck, ApplicationFacade.TWEEN_DURATION, {autoAlpha: t_nAlpha});
		}
		
		override public function fMouseMOUSE_OUT(event : MouseEvent) : void {
			TweenMax.to(mcBG, ApplicationFacade.TWEEN_DURATION, {autoAlpha : 0.7});
		}

		override public function fMouseMOUSE_OVER(event : MouseEvent) : void {
			TweenMax.to(mcBG, ApplicationFacade.TWEEN_DURATION, {autoAlpha : 1});
		}
		
		override public function fMouseCLICK(event : MouseEvent) : void {
			super.fMouseCLICK(event);
			_bChecked = !_bChecked;
			fToggle(_bChecked);
		}
		
		override public function set theEnabled(arg_b : Boolean) : void {}
		
		public function get isChecked() : Boolean {
			return _bChecked;
		}

		
	}
}
