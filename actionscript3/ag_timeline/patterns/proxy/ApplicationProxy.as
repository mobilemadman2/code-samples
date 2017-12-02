
package net.believecollective.ag2010.patterns.proxy {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.ag2010.patterns.mediators.ApplicationMediator;
	import net.believecollective.frameworks.pureMVC2.app.ApplicationFacadeBase;
	import net.believecollective.utils.Tracer;
	import net.believecollective.utils.webservices.WebServiceLoadRequestVO;
	import net.believecollective.utils.xml.XMLLoadRequest;

	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

	/**
	 * @author Dan Mackie (dan@believecollective.net)
	 * Desc: load external data
	 */
	public class ApplicationProxy extends Proxy implements IProxy {

		public static const NAME : String = "ApplicationProxy";
		private var nStartupXMLCount : Number;
		
		public function ApplicationProxy() {
			super(NAME);
			nStartupXMLCount = 0;
		}
		
		public function fLangsParsed() : void {
			var t_a : Array = new Array();
			var t_oCP : ConfigProxy = facade.retrieveProxy(ConfigProxy.NAME) as ConfigProxy;
			t_a = t_oCP.config.eraIDs;	
			if (t_a.length > 0 && t_a[0] != ""){
				for (var i : Number = 0;i < t_a.length; i++) {
					var t_s : String = t_a[i] as String;
					var t_sBasePath : String = (ApplicationFacade.IS_USING_LOCAL) ? "" : ApplicationFacade.BASEPATH + "images/flash/timeline/";
					var t_sFilePath : String = t_sBasePath + ApplicationFacade.XMLPATH + "eras/" + t_s + ".xml";
					sendNotification(ApplicationFacadeBase.CMD_LOAD_XML, new XMLLoadRequest(t_sFilePath, ApplicationFacade.CMD_XML_ERA_PASRSE));
				}
			}else{
				(facade.retrieveProxy(ApplicationProxy.NAME) as ApplicationProxy).fConfigParsed();
			}
		}
		
		public function fConfigParsed() : void {
			var t_oCP:ConfigProxy = facade.retrieveProxy(ConfigProxy.NAME) as ConfigProxy;
//			// get active event ID
//			if (t_oCP.config.uselocalxml) ApplicationFacade.ACTIVE_ITEM_ID = ApplicationFacade.DEFAULT_ACTIVE_ITEM_ID;
//			else  ApplicationFacade.ACTIVE_ITEM_ID = ApplicationFacadeBase.ROOT.loaderInfo.parameters.id;
//			//
			sendNotification(ApplicationFacadeBase.CMD_CREATE_APP_INTERFACES, ApplicationMediator.NAME);
			//As each of the following XML files is parsed the fStartUpXMLParsed is called from parser command
			var t_aStartupXMLS:Array = t_oCP.config.startupXMLS;
			if (t_aStartupXMLS.length > 0) {
				for (var i : Number = 0; i < t_aStartupXMLS.length; i++) {
					sendNotification(ApplicationFacadeBase.CMD_LOAD_XML, new XMLLoadRequest(ApplicationFacade.XMLPATH + t_aStartupXMLS[i]+".xml", ApplicationFacade.CMD_STARTUP_XML_PARSE));
				}
			}else{
				//Timeline PHP Call is typically of the form:
				//http://dev.ayo-gorkhali.org/timelineservice.php?lang=en
				//If config set to use local XML (for ease of testing) we load TIMELINE XML
				if (ApplicationFacade.IS_USING_LOCAL) {
					Tracer.TRACE("GETTING LOCAL TIMELINE XML...");
					sendNotification	(
											ApplicationFacadeBase.CMD_LOAD_XML, 
											new XMLLoadRequest	
											(
												ApplicationFacade.XMLPATH + ApplicationFacade.TIMELINE_XML_LOCAL_FILENAME, 
												ApplicationFacade.CMD_TIMELINE_XML_PARSE
											)
										);
				}else{
					//Call webservice pulled from embed code to get XML return
					Tracer.TRACE("USING REMOTE WEBSERICE TO GET TIMELINE XML...");
					var t_bBustCache : Boolean = (facade.retrieveProxy(HistoryProxy.NAME)as HistoryProxy)._oHistory.data.bustTimelineCache; // bust the cache once a day					var t_sTimeLineWebserviceURL:String = ApplicationFacadeBase.ROOT.loaderInfo.parameters.service;
//					sendNotification(ApplicationFacade.CMD_CALL_WEBSERVICE, new WebServiceLoadRequestVO(t_sTimeLineWebserviceURL, ApplicationFacade.CMD_TIMELINE_XML_PARSE, t_bBustCache));					sendNotification(ApplicationFacade.CMD_CALL_WEBSERVICE, new WebServiceLoadRequestVO(t_sTimeLineWebserviceURL, ApplicationFacade.CMD_TIMELINE_XML_PARSE));
				}
			}
		}
		
		public function fTimelineParsed() : void {
			var t_s: String = (ApplicationFacade.IS_USING_LOCAL) ? "" : ApplicationFacade.BASEPATH + ApplicationFacade.REMOTE_TIMELINE_FILEPATH;
			sendNotification	(
										ApplicationFacadeBase.CMD_LOAD_XML, 
										new XMLLoadRequest	
										(
												t_s + ApplicationFacade.XMLPATH + ApplicationFacade.LANDSCAPE_XML_LOCAL_FILENAME, 
												ApplicationFacade.CMD_LANDSCAPE_XML_PARSE)
										);
				
		}		
		
		public function fStartUpXMLParsed() : void {
			//Increments the config number for the startup XMLs required... This needs to be set in config
			nStartupXMLCount ++;
			var t_nStartupXMLS:Number = (facade.retrieveProxy(ConfigProxy.NAME) as ConfigProxy).config.startupXMLS.length;
			if (t_nStartupXMLS == nStartupXMLCount) sendNotification(ApplicationFacade.CMD_START_INTERFACE);
		}
		
		public function fGetStageProxy() : AGStageProxy {
			return facade.retrieveProxy(AGStageProxy.NAME) as AGStageProxy;
		}
	}
}