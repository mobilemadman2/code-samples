package net.believecollective.ag2010.view.testpanel {
	import net.believecollective.ag2010.patterns.proxy.ConfigProxy;	import net.believecollective.ag2010.view.AGBaseView;	import net.believecollective.ag2010.view.testpanel.components.TestPanelViewGFX;		/**
	 * @author Dan Mackie (dan@believecollective.net)
	 */
	public class TestPanelView extends AGBaseView {		public static const NAME : String = "TestPanelView";				public function TestPanelView() {			super(NAME);//			fSetDraggable(true);		}				override public function fInit() : void {			mcGFX = fCreateGFX();			}		private function fCreateGFX() : TestPanelViewGFX {			var t_o : TestPanelViewGFX = new TestPanelViewGFX(_oConfig as ConfigProxy);			addChild(t_o);			return t_o;		}	}}
	