package net.believecollective.ag2010.view.timeline.components.timelineelements.dividerelements {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.ag2010.events.AGTimelineElementEvent;
	import net.believecollective.ag2010.model.vo.timeline.events.AGEventVO;
	import net.believecollective.ag2010.view.generics.externalgraphics.AGExternalGraphic;
	import net.believecollective.ag2010.view.generics.externalgraphics.vo.AGExternalGraphicVO;
	import net.believecollective.utils.Tracer;

	import com.greensock.TweenMax;

	import flash.events.Event;

	/**
	 * @author Marianne
	 */
	public class AGTimelineEraDividerEmblem extends AGTimelineDividerBase {
		
		public static const NAME : String = "AGTimelineEraDividerEmblem";
		
		private var _mcGraphics : AGExternalGraphic;
		private var _sName : String;
		
		public function AGTimelineEraDividerEmblem(arg_oVO: AGEventVO) {
			_sName = arg_oVO.eventName;
			super(arg_oVO);
		}
		
		override protected function fAddGraphics() : void {
			var t_sBGFileName : String =  ApplicationFacade.ERADIVIDERPATH_COMPONENTS + _sName+ "_Emblem.swf";
			_mcGraphics = addChild(new AGExternalGraphic(new AGExternalGraphicVO(t_sBGFileName, fInitLoadedGraphic, fError))) as AGExternalGraphic;
		}

		private function fInitLoadedGraphic(event : Event): void {
			_mcGraphics.scaleX = _mcGraphics.scaleY = 1.05;
			_mcGraphics.x = (ApplicationFacade.IS_FACEBOOK == true) ? -25 : -20;
			_mcGraphics.y = -10;
			// fade into view
			TweenMax.to(this, ApplicationFacade.FADE_TWEEN_DURATION, {autoAlpha : 1});
			dispatchEvent(new AGTimelineElementEvent(AGTimelineElementEvent.AGTIMELINE_GRAPHIC_LOADED));
		}
		
		private function fError(event : Event) : void {
			Tracer.TRACE("!!!Marianne : AGTimelineEraDividerEmblem.fError : Graphic not loaded");
			// this graphic cannot be loaded, move on to the next
			dispatchEvent(new AGTimelineElementEvent(AGTimelineElementEvent.AGTIMELINE_GRAPHIC_LOADED));
		}
		
	}
}
