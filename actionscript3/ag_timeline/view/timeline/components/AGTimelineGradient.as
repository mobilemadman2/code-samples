package net.believecollective.ag2010.view.timeline.components {
	import net.believecollective.ag2010.app.ApplicationFacade;

	import com.greensock.TweenMax;

	import flash.display.MovieClip;

	/**
	 * @author Marianne
	 */
	public class AGTimelineGradient extends MovieClip {
		public function AGTimelineGradient() {
		}
		
		public function fToggle(arg_b : Boolean) : void {
			if (visible == arg_b) return;
			var t_nAlpha : Number = (arg_b) ? 1 : 0;
			TweenMax.to(this, ApplicationFacade.TWEEN_DURATION, {autoAlpha : t_nAlpha});
		}
		
	}
}
