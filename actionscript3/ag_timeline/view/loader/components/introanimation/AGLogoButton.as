package net.believecollective.ag2010.view.loader.components.introanimation {
	import net.believecollective.model.vo.BButtonDefaultVO;

	import com.greensock.TweenMax;

	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	/**
	 * @author Marianne
	 */
	public class AGLogoButton extends AGExploreButton {
		
		public var _mcOrb : MovieClip;		public var _mcKukris : MovieClip;		
		public function AGLogoButton(arg_oBVO : BButtonDefaultVO = null) {
			_mcRollover = addChild(new MovieClip()) as MovieClip;
			super(arg_oBVO);
			TweenMax.to(this, 0, {autoAlpha: 1});
		}
		
		override protected function fAddText() : void {}

		override public function fMouseMOUSE_OUT(event : MouseEvent) : void {}

		override public function fMouseMOUSE_OVER(event : MouseEvent) : void {}
		
	}
}
