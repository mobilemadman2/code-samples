
package net.believecollective.ag2010.model.vo {
	import net.believecollective.model.vo.DialogVO;

	
	/**
	 * @author DM
	 */
	public class AGFeedbackVO extends DialogVO {

		public static const EXCLAIMATION:String = "Exclaimation";		public static const NEGATIVE:String = "Negative";		public static const POSITIVE:String = "Positive";		public static const QUESTION:String = "Question";
		

		public function AGFeedbackVO	(
											arg_fCancel : Function = null, 
											arg_fConfirm : Function = null, 
											arg_sTitle : String = "", 
											arg_sMessage : String = "", 
											arg_sButtonConfirm : String = "", 
											arg_sButtonCancel : String = "",
											arg_sType:String = ""
										) {
			super(arg_fCancel, arg_fConfirm, arg_sTitle, arg_sMessage, arg_sButtonConfirm, arg_sButtonCancel, arg_sType);
		}
		
	}
}
