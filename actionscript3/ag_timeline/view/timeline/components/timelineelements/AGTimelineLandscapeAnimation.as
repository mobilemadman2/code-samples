package net.believecollective.ag2010.view.timeline.components.timelineelements {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.ag2010.model.vo.timeline.events.AGEventVO;
	import net.believecollective.ag2010.view.generics.externalgraphics.AGExternalGraphic;
	import net.believecollective.ag2010.view.generics.externalgraphics.vo.AGExternalGraphicVO;
	import net.believecollective.utils.Tracer;

	import com.greensock.TweenMax;

	import flash.events.Event;

	/**
	 * @author Marianne
	 */
	public class AGTimelineLandscapeAnimation extends AGTimelineLandscapeGraphic {
		public function AGTimelineLandscapeAnimation(arg_oVO : AGEventVO) {
			super(arg_oVO);
		}
		
		override protected function fAddGraphics() : void {
			_sFilePath = ApplicationFacade.LANDSCAPE_ANIMATIONPATH_COMPONENTS+ _oVO.alias + ".swf";
			_oGraphic = new AGExternalGraphic(new AGExternalGraphicVO(_sFilePath, fInitLoadedGraphic, fError)) as AGExternalGraphic;
			_oGraphic.alpha = 0;
		}
		
		override protected function fInitLoadedGraphic(event : Event): void {
			addChild(_oGraphic);
			_oGraphic.play(); // !! important
			// fade into view
			TweenMax.to(_oGraphic, ApplicationFacade.FADE_TWEEN_DURATION, {autoAlpha : 1});
			if (_bActivated) fAddDetail();
		}
		
		override protected function fError(event : Event) : void {
			Tracer.TRACE("!!!Marianne : AGTimelineLandscapeGraphic.fError : Graphic not loaded :" + _sFileName);
		}
	}
}
