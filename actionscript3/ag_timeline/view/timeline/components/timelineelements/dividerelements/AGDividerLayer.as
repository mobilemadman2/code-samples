package net.believecollective.ag2010.view.timeline.components.timelineelements.dividerelements {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.ag2010.model.vo.timeline.events.AGEventVO;
	import net.believecollective.ag2010.view.timeline.components.AGTimelineLayer;
	import net.believecollective.ag2010.view.timeline.components.timelineelements.AGTimeLineElementsBase;

	/**
	 * @author Marianne
	 */
	public class AGDividerLayer extends AGTimelineLayer {
		public function AGDividerLayer() {
			super();
		}
		
		override public function fAddElement(arg_sElementName: String, arg_oVO : AGEventVO) : AGTimeLineElementsBase {
			var t_o: AGTimeLineElementsBase;
			switch (arg_sElementName){
				case AGTimelineEraDividerBG.NAME:
					t_o = new AGTimelineEraDividerBG(arg_oVO) as AGTimelineEraDividerBG;
				break;
				case AGTimelineEraDividerEmblem.NAME:
					t_o = new AGTimelineEraDividerEmblem(arg_oVO) as AGTimelineEraDividerEmblem;
				break;
				case AGTimelineEraDividerText.NAME:
					t_o = new AGTimelineEraDividerText(arg_oVO) as AGTimelineEraDividerText;
				break;
				case AGTimelineEraDividerTitle.NAME:
					t_o = new AGTimelineEraDividerTitle(arg_oVO) as AGTimelineEraDividerTitle;
				break;
				case AGTimelineEraDividerSubtitle.NAME:
					t_o = new AGTimelineEraDividerSubtitle(arg_oVO) as AGTimelineEraDividerSubtitle;
				break;
			}
			t_o.x = (t_o.xAxis - ApplicationFacade.CURRENT_X_IN_FOCUS);//			t_o.x = (t_o.xAxis);
			addChild(t_o);
			return t_o;
		}
		
	}
}
