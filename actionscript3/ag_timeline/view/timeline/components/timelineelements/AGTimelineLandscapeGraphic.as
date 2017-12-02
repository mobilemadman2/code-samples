package net.believecollective.ag2010.view.timeline.components.timelineelements {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.ag2010.events.AGTimelineElementEvent;
	import net.believecollective.ag2010.model.vo.timeline.events.AGEventVO;
	import net.believecollective.ag2010.view.generics.externalgraphics.AGExternalGraphic;
	import net.believecollective.ag2010.view.generics.externalgraphics.vo.AGExternalGraphicVO;
	import net.believecollective.frameworks.pureMVC2.view.loader.CallbackLoader;
	import net.believecollective.utils.Tracer;

	import com.greensock.TweenMax;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;

	/**
	 * @author Marianne
	 */
	public class AGTimelineLandscapeGraphic extends AGTimeLineElementsBase {
		
		public static const NAME : String = "AGTimelineLandscapeGraphic";
				
		protected var _oGraphic : AGExternalGraphic;
		private var _oDetailImage : AGExternalGraphic;
		
		public function AGTimelineLandscapeGraphic(arg_oVO: AGEventVO) {
			super(arg_oVO);
		}
		
		override protected function fInit() : void {
			super.fInit();
			this.z = _oVO.fLookUpZIndex();
		}

		override protected function fAddGraphics() : void {
			_sFilePath = ApplicationFacade.LANDSCAPEPATH_COMPONENTS+ _oVO.alias + ".swf";
			_oGraphic = new AGExternalGraphic(new AGExternalGraphicVO(_sFilePath, fInitLoadedGraphic, fError)) as AGExternalGraphic;
			_oGraphic.alpha = 0;
		}

		protected function fInitLoadedGraphic(event : Event): void {
			_oGraphic.gotoAndStop(1); // !! important
			addChild(_oGraphic);
			// fade into view
			TweenMax.to(_oGraphic, ApplicationFacade.FADE_TWEEN_DURATION, {autoAlpha : 1});
			if (_bActivated) fAddDetail();
			// dispatch custom event
			dispatchEvent(new AGTimelineElementEvent(AGTimelineElementEvent.AGTIMELINE_GRAPHIC_LOADED));
		}
		
		protected function fError(event : Event) : void {
			Tracer.TRACE("!!!Marianne : AGTimelineLandscapeGraphic.fError : Graphic not loaded :" + _sFilePath);
			// this graphic cannot be loaded, move on to the next
			dispatchEvent(new AGTimelineElementEvent(AGTimelineElementEvent.AGTIMELINE_GRAPHIC_LOADED));
		}
		
		private function fDetailError(event : IOErrorEvent) : void {			
			Tracer.TRACE("!!!Marianne : AGTimelineLandscapeGraphic.fDetailViewError : "+_sFilePath);
			// this graphic cannot be loaded, move on to the next
			dispatchEvent(event);
		}
		
		override public function fAddDetail(): void {
			_sFilePath = ApplicationFacade.IMAGE_LANDSCAPE_DETAILPATH_COMPONENTS + _oVO.alias + ".png";
			_oDetailImage = new AGExternalGraphic(new AGExternalGraphicVO(_sFilePath, fInitLoadedDetailImage, fDetailError)) as AGExternalGraphic; // add a png
			_oGraphic.play(); // play the swf
		}

		private function fInitLoadedDetailImage(event : Event): void {
			_oDetailImage.alpha =0;
			addChild(_oDetailImage);
			TweenMax.to(_oDetailImage, ApplicationFacade.TWEEN_DURATION, {autoAlpha: 1});
			if (_oVO.activated == true) fToggle(true);
		}
		
		override public function play() : void {
			if ((_oGraphic.getChildAt(0) as CallbackLoader).content is MovieClip){
				(((_oGraphic.getChildAt(0) as CallbackLoader).content as MovieClip).getChildAt(0) as MovieClip).gotoAndPlay(1); // !! important;
			}
		}
		
		override public function stop() : void {
			if ((_oGraphic.getChildAt(0) as CallbackLoader).content is MovieClip){
				(((_oGraphic.getChildAt(0) as CallbackLoader).content as MovieClip).getChildAt(0) as MovieClip).gotoAndStop(1); // !! important;
			}
		}
		
	}
}
