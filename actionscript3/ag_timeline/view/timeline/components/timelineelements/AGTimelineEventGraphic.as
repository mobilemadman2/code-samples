package net.believecollective.ag2010.view.timeline.components.timelineelements {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.ag2010.events.AGTimelineElementEvent;
	import net.believecollective.ag2010.model.vo.timeline.events.AGEventVO;
	import net.believecollective.ag2010.view.generics.externalgraphics.AGExternalGraphic;
	import net.believecollective.ag2010.view.generics.externalgraphics.vo.AGExternalGraphicVO;
	import net.believecollective.frameworks.pureMVC2.view.loader.CallbackLoader;

	import com.greensock.TweenMax;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;

	/**
	 * @author Marianne
	 */
	public class AGTimelineEventGraphic extends AGTimeLineElementsBase {
		
		public static const NAME : String = "AGTimelineEventGraphic";
		
		private var _oSilhouette : AGExternalGraphic;		private var _oDetailImage : AGExternalGraphic;
				
		public function AGTimelineEventGraphic(arg_oVO: AGEventVO) {
			super(arg_oVO);
		}

		override protected function fInit() : void {
			var t_nAlpha : Number = (_oVO.visible) ? 1 : 0;
			TweenMax.to (this, 0, {autoAlpha : t_nAlpha});
			
			this.z = _oVO.fLookUpZIndex();
			super.fInit();
			theEnabled = true;
		}	

		override protected function fAddGraphics() : void {
			if (_bActivated) {
				// bypass the silhouette
				fAddDetail();
				return;
			}
			_sFilePath = ApplicationFacade.SILHOUETTESPATH_COMPONENTS + _oVO.timelineID + "-" + _oVO.alias + ".swf";
			_oSilhouette = new AGExternalGraphic(new AGExternalGraphicVO(_sFilePath, fInitLoadedSilhouette, fSilhouetteError)) as AGExternalGraphic;
			_oSilhouette.alpha = 0;
		}

		private function fInitLoadedSilhouette(event : Event): void {
			addChild(_oSilhouette);
			// shift to top-left of event label position
			_oSilhouette.x -= 0.75 * _oSilhouette.width;			_oSilhouette.y -= 0.75 * _oSilhouette.height;
			// fade into view
			TweenMax.to(_oSilhouette, ApplicationFacade.FADE_TWEEN_DURATION, {autoAlpha : 1});
			// dispatch custom event
			dispatchEvent(new AGTimelineElementEvent(AGTimelineElementEvent.AGTIMELINE_GRAPHIC_LOADED));
		}

		override public function fAddDetail(): void {
			_sFilePath = ApplicationFacade.IMAGE_DETAILPATH_COMPONENTS +_oVO.timelineID + "-" + _oVO.alias + ".png";
			_oDetailImage = new AGExternalGraphic(new AGExternalGraphicVO(_sFilePath, fInitLoadedDetailImage, fDetailError)) as AGExternalGraphic;
		}
		
		private function fInitLoadedDetailImage(event : Event): void {
			addChild(_oDetailImage);
			TweenMax.to(_oDetailImage, 0, {autoAlpha: 0});
			if (_oVO.activated == true) fToggle(true);
			_oDetailImage.x -= 0.75 * _oDetailImage.width;			_oDetailImage.y -= 0.75 * _oDetailImage.height;
			dispatchEvent(new AGTimelineElementEvent(AGTimelineElementEvent.AGTIMELINE_GRAPHIC_LOADED));
		}

		private function fSilhouetteError(event : IOErrorEvent) : void {
			// this graphic doesn't exist, move on to the next			
			dispatchEvent(new AGTimelineElementEvent(AGTimelineElementEvent.AGTIMELINE_GRAPHIC_LOADED));
		}
		
		private function fDetailError(event : IOErrorEvent) : void {
			if (_oSilhouette == null) {
				// try to add the silhouette instead
				_bActivated = false;
				fAddDetail();
			}
			// the silhouette exists, move on...
			else dispatchEvent(new AGTimelineElementEvent(AGTimelineElementEvent.AGTIMELINE_GRAPHIC_LOADED));
		}

		override public function fToggle(arg_b: Boolean) : void {
			var t_nAlpha: Number = (arg_b) ? 1: 0;
			if (_oDetailImage) TweenMax.to(_oDetailImage, ApplicationFacade.TWEEN_DURATION, {autoAlpha: t_nAlpha});
			else {
				_oVO.activated = true;
				fAddDetail();
			}
		}
		
		public function get detailImage() : AGExternalGraphic {
			return _oDetailImage;
		}
		
		override public function play() : void {
			if ((_oSilhouette.getChildAt(0) as CallbackLoader).content is MovieClip){
				(((_oSilhouette.getChildAt(0) as CallbackLoader).content as MovieClip).getChildAt(0) as MovieClip).gotoAndPlay(1); // !! important;
			}
		}
		
		override public function stop() : void {
			if ((_oSilhouette.getChildAt(0) as CallbackLoader).content is MovieClip){
				(((_oSilhouette.getChildAt(0) as CallbackLoader).content as MovieClip).getChildAt(0) as MovieClip).gotoAndStop(1); // !! important;
			}
		}
		
	}
}
