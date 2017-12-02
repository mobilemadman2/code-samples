package net.believecollective.ag2010.view.controls {
	import net.believecollective.ag2010.patterns.proxy.ConfigProxy;	import net.believecollective.ag2010.view.AGBaseView;	import net.believecollective.ag2010.view.controls.components.ControlsViewGFX;	/**
	 * @author Dan Mackie (dan@believecollective.net)
	 */
	public class ControlsView extends AGBaseView {		public static const NAME : String = "ControlsView";				public function ControlsView() {			super(NAME);		}				override public function fInit() : void {			mcGFX = fCreateGFX();			}		private function fCreateGFX() : ControlsViewGFX {			var t_o : ControlsViewGFX = new ControlsViewGFX(_oConfig as ConfigProxy);			addChild(t_o);			return t_o;		}				override public function fUpdate(arg_o : Object = null, arg_sEvent : String = "") : void {			switch(arg_sEvent){			}		}	}}
	