package net.believecollective.ag2010.model.vo.timeline.scenery {
	import net.believecollective.ag2010.model.vo.timeline.events.AGEventVO;

	/**
	 * @author Marianne
	 */
	public class AGSceneryVO extends AGEventVO {
		
		public function AGSceneryVO(
										arg_iID :int,
										arg_sAlias : String, 
										arg_sFrom : String, 
										arg_nYAxis : Number,
										arg_nXAxis : Number,
										arg_nLayer : Number,
										arg_bActivated : Boolean,
										arg_bImmediate : Boolean
										){
			super(arg_iID, "", arg_sAlias, arg_sFrom, arg_sFrom, false, arg_nYAxis, arg_nXAxis, 0, arg_nLayer, "", "", "", true, arg_bActivated, arg_bImmediate);
		}	
	}
}
