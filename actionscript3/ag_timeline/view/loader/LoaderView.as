package net.believecollective.ag2010.view.loader {
	import net.believecollective.ag2010.view.AGBaseView;	import net.believecollective.ag2010.view.loader.components.LoaderViewGFX;	import net.believecollective.ag2010.view.loader.components.introanimation.AGExploreButton;	import net.believecollective.model.vo.ViewTextVO;	/**
	 * @author Dan Mackie (dan@believecollective.net)
	 */
	public class LoaderView extends AGBaseView {		public static const NAME : String = "LoaderView";				public function LoaderView() {				super(NAME);		}		override public function fInit() : void {			mcGFX = fCreateGFX();		}		private function fCreateGFX() : LoaderViewGFX {			var t_o : LoaderViewGFX = new LoaderViewGFX();			addChild(t_o);			return t_o;		}		override public function fUpdate(arg_o : Object = null, arg_sEvent : String = "") : void {			switch (arg_sEvent) {				case "enableExplore":				var t_s : String = "";				for each (var oVO : ViewTextVO in _oInterfaceText.theInterfaceText) {					if (oVO.theID == AGExploreButton.NAME) t_s = oVO.theText;				}				(gfx as LoaderViewGFX).fEnableExplore(t_s);				break;								}		}	}}
