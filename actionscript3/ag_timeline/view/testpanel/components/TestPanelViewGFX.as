
package net.believecollective.ag2010.view.testpanel.components {
	import fl.controls.TextArea;

	import net.believecollective.ag2010.patterns.proxy.ConfigProxy;
	import net.believecollective.utils.Tracer;

	import flash.display.MovieClip;

	
	/**
	 * LoaderView Component
	 * 
	 * @author Dan Mackie (dan@believecollective.net)
	 */
	public class TestPanelViewGFX extends MovieClip {
		
		public var txtTrace : TextArea;
		
		function TestPanelViewGFX(arg_oConfig : ConfigProxy) {
			//Register the trace text area with the tracer 
			Tracer.SETTEXTFIELDTRACERMC(this);
		}
		
		public function fTrace(arg_s:String):void {
			txtTrace.text = arg_s;
		}
		
	}
}
