
package net.believecollective.ag2010.patterns.commands {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.ag2010.patterns.proxy.ApplicationProxy;
	import net.believecollective.ag2010.patterns.proxy.ConfigProxy;
	import net.believecollective.frameworks.pureMVC2.app.ApplicationFacadeBase;
	import net.believecollective.utils.xml.XMLLoadRequest;

	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;

	/**	
	 * @author Dan Mackie (dan@believecollective.net)
	 */
	public class LoadFontsCommand extends SimpleCommand implements ICommand {

		private var _aFonts : Array;
		private var _nCounter : int;

		
		override public function execute(notification : INotification) : void {
			_aFonts = notification.getBody() as Array;
			_nCounter = 0;
			fLoadFont(_aFonts[0] as String);
		}	

		private function fLoadFont(arg_sFontSWFName : String) : void {
			var t_oLoader:Loader = new Loader();
			t_oLoader.contentLoaderInfo.addEventListener(Event.INIT, fFontSWFLoaded);
			var t_s: String = (ApplicationFacade.IS_USING_LOCAL) ? ApplicationFacade.LOCAL_FONTS_FILEPATH + arg_sFontSWFName + ".swf" : ApplicationFacade.BASEPATH + ApplicationFacade.REMOTE_FONTS_FILEPATH + arg_sFontSWFName + ".swf";
			t_oLoader.load(new URLRequest(t_s));
		}

		private function fFontSWFLoaded(event : Event) : void {
			_nCounter ++;
			if (_nCounter == _aFonts.length){
				fContinue();
			}
			else{
				fLoadFont(_aFonts[_nCounter]);
			}
		}	

		private function fContinue() : void {
			var t_a : Array = new Array();
			var t_oCP : ConfigProxy = facade.retrieveProxy(ConfigProxy.NAME) as ConfigProxy;
			t_a = t_oCP.config.viewIDs;	
			if (t_a.length > 0 && t_a[0] != ""){
				for (var i : Number = 0;i < t_a.length; i++) {
					var t_s : String = t_a[i] as String;
					var t_sBasePath : String = (ApplicationFacade.IS_USING_LOCAL) ? "" : ApplicationFacade.BASEPATH + "images/flash/timeline/";
					var t_sFilePath : String = t_sBasePath + ApplicationFacade.LANGUAGEPATH + ApplicationFacade.LANGUAGE + "/" + t_s + "_" + ApplicationFacade.LANGUAGE + ".xml";
					sendNotification(ApplicationFacadeBase.CMD_LOAD_XML, new XMLLoadRequest(t_sFilePath, ApplicationFacade.CMD_XML_LANG_PARSE));
				}
			}else{
				(facade.retrieveProxy(ApplicationProxy.NAME) as ApplicationProxy).fLangsParsed(); // move onto era xmls
			}
		}
	}
}

