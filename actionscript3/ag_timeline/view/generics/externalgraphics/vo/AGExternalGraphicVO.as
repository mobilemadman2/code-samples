package net.believecollective.ag2010.view.generics.externalgraphics.vo {
	import net.believecollective.model.SimpleConfig;

	/**
	 * @author Marianne
	 */
	public class AGExternalGraphicVO extends SimpleConfig {
		
		private var _sFileName : String;//		private var _nInitAlpha : Number;
		private var _oCBFComplete : Function;		private var _oCBFError : Function;
		
		public function AGExternalGraphicVO(
		
												arg_sFileName:String = "",
												arg_oCBFComplete:Function = null,												arg_oCBFError:Function = null
//												arg_nInitAlpha: Number = 1
														
														) {
			super();
		
			_sFileName = arg_sFileName;
//			_nInitAlpha = arg_nInitAlpha;
			_oCBFComplete = arg_oCBFComplete;			_oCBFError = arg_oCBFError;		} 

		public function get filename() : String {
			return _sFileName;
		}
		
//		public function get initAlpha() : * {
//			return _nInitAlpha;
//		}
		
		public function get oCBFComplete() : Function {
			return _oCBFComplete;
		}
		
		public function get oCBFError() : Function {
			return _oCBFError;
		}
	}
}
