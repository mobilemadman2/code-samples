package net.believecollective.ag2010.view.timeline.components.timelineelements.dividerelements {
	import net.believecollective.ag2010.model.vo.timeline.events.AGEventVO;

	/**
	 * @author Marianne
	 */
	public class AGDividerVO extends AGEventVO {
		
		public function AGDividerVO(		
										arg_sText: String,
										arg_nStartX: Number,										arg_iChronolgicalPosition: int,
										arg_nLayer : Number
										) {
											
			chronologicalPosition = arg_iChronolgicalPosition;								
			super(-1, arg_sText, "", "", "", true,0,arg_nStartX, -1, arg_nLayer, "", "", "", true, false);
		}
		
		override public function fLookUpZIndex() : Number {
			switch(layer) {
				case 0:
					return 200;
					break;
				case 1:
					return 110;
					break;
				case 2:
					return 80;
					break;
				case 3:
					return 0;
					break;
				default:
					return 0;
					break;
			}
		}
		
	}
}
