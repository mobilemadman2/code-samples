package net.believecollective.ag2010.view.controls.components.help {
	import net.believecollective.ag2010.view.generics.buttons.AGButton;
	import net.believecollective.model.vo.BButtonDefaultVO;

	/**
	 * @author Marianne
	 */
	public class AGHelpBtn extends AGButton {
		
		public static const NAME : String = "AGHelpBtn";
		
		public function AGHelpBtn(arg_oBVO : BButtonDefaultVO = null) {
			super(arg_oBVO);
		}
	}
}
