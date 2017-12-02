package net.believecollective.ag2010.view.generics.scroller.components {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.frameworks.pureMVC2.view.buttons.BButtonBaseBase;

	import com.greensock.TweenMax;

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	/**
	 * @author Marianne
	 */
	public class AGScrollButton extends BButtonBaseBase {
		
		public var mcRollover: Sprite;
		private var _nSlideLength: Number;
		private var _nX : Number;		private var _nY : Number;
		
		public function AGScrollButton(arg_nSlideLength: Number) {
			_nSlideLength = arg_nSlideLength - this.height;
			this.x = _nX = -this.width /2;
			_nY = this.height /2;
			super();
			mcRollover.alpha = 0;
		}
		
		override public function fMouseMOUSE_OVER(event : MouseEvent) : void {
			super.fMouseMOUSE_OVER(event);
			TweenMax.to(mcRollover, ApplicationFacade.TWEEN_DURATION, {autoAlpha: 1});
		}
		
		override public function fMouseMOUSE_OUT(event : MouseEvent) : void {
			super.fMouseMOUSE_OUT(event);
			TweenMax.to(mcRollover, ApplicationFacade.TWEEN_DURATION, {autoAlpha: 0});
		}
		
		override public function fMouseDOWN(event : MouseEvent) : void {
			super.fMouseDOWN(event);
			var _rRect:Rectangle = new Rectangle(_nX, _nY, 0, _nSlideLength);
			startDrag(false, _rRect);
		}

		override public function fMouseUP(event : MouseEvent) : void {
			super.fMouseUP(event);
			stopDrag();
		}
		
		override public function fMouseReleaseOutside(event : MouseEvent) : void {
			fMouseUP(event);
			fMouseMOUSE_OUT(event);
		}
		
		
	}
}
