package net.believecollective.ag2010.view.timeline.components {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.ag2010.model.vo.timeline.dates.AGDatesVO;
	import net.believecollective.ag2010.model.vo.timeline.events.AGEventVO;
	import net.believecollective.ag2010.view.timeline.components.timelineelements.AGTimeLineElementsBase;
	import net.believecollective.ag2010.view.timeline.components.timelineelements.AGTimelineDates;
	import net.believecollective.ag2010.view.timeline.components.timelineelements.AGTimelineEraMask;
	import net.believecollective.ag2010.view.timeline.components.timelineelements.AGTimelineEventGraphic;
	import net.believecollective.ag2010.view.timeline.components.timelineelements.AGTimelineEventLabel;
	import net.believecollective.ag2010.view.timeline.components.timelineelements.AGTimelineLandscapeGraphic;

	import flash.display.MovieClip;

	/**
	 * @author Marianne
	 * 
	 * the container class of all landscape, events graphics and labels for a specific layer of a specific era
	 * sets the horizontal positioning of its children
	 * all children share a 'date factor' determined by the chronolgical position of this.parent (AGTimelineEra)
	 * all children share a 'paralax factor' determined by the index (depth) of this
	 */
	 
	public class AGTimelineLayer extends MovieClip {
		
		private var _nParalaxFactor : Number;	// Layer specific X-position-scaling factor		

		public function AGTimelineLayer() : void {
		}

		public function fAddElement(arg_sElementName: String, arg_oVO : AGEventVO) : AGTimeLineElementsBase {
			var t_o: AGTimeLineElementsBase;
			switch (arg_sElementName){
				case AGTimelineEventLabel.NAME:
					t_o = new AGTimelineEventLabel(arg_oVO) as AGTimelineEventLabel;
				break;
				case AGTimelineEventGraphic.NAME:
					t_o = new AGTimelineEventGraphic(arg_oVO) as AGTimelineEventGraphic;
				break;
				case AGTimelineLandscapeGraphic.NAME:
					t_o = new AGTimelineLandscapeGraphic(arg_oVO) as AGTimelineLandscapeGraphic;
				break;
				case AGTimelineEraMask.NAME:
					t_o = new AGTimelineEraMask(arg_oVO) as AGTimelineEraMask;
				break;
				case AGTimelineDates.NAME:
					t_o = new AGTimelineDates(arg_oVO as AGDatesVO) as AGTimelineDates;
				break;
			}
//			t_o.x = (t_o.xAxis - ApplicationFacade.CURRENT_X_IN_FOCUS) / _nParalaxFactor;			t_o.x = (t_o.xAxis - ApplicationFacade.CURRENT_X_IN_FOCUS);
//			t_o.x = (t_o.xAxis);
			addChild(t_o);
			return t_o;
		}

		public function fMoveContent() : void {
			for(var i:int = 0; i< numChildren; i++){
				var t_o : AGTimeLineElementsBase = getChildAt(i) as AGTimeLineElementsBase;
////				t_o.targetX = (t_o.xAxis - ApplicationFacade.CURRENT_X_IN_FOCUS)  / _nParalaxFactor;
				t_o.targetX = t_o.xAxis - ApplicationFacade.CURRENT_X_IN_FOCUS;
			}	
		}

///////// GETTERS SETTERS

		public function set paralaxFactor(nParalaxFactor : Number) : void {
			_nParalaxFactor = nParalaxFactor;
		}

		
		
	}
}
