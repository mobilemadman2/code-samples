package net.believecollective.ag2010.model.vo {
		/**
	 * @author Dan M
	 */
	public class LoaderDataVO {		private var _nPerc : Number;		private var _sMessage : String;				public function LoaderDataVO(arg_nPerc:Number, arg_sMessage:String) {			_nPerc = arg_nPerc;			_sMessage = arg_sMessage;		}		public function get percentage() : Number {			return _nPerc;		}				public function get message() : String {			return _sMessage;		}	}
}
