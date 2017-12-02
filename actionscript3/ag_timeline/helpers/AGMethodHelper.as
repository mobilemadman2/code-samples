
package net.believecollective.ag2010.helpers {
	import net.believecollective.ag2010.app.ApplicationFacade;
	import net.believecollective.ag2010.model.vo.AGConfigVO;
	import net.believecollective.ag2010.model.vo.timeline.AGLandscapeVO;
	import net.believecollective.ag2010.model.vo.timeline.AGTimelineVO;
	import net.believecollective.ag2010.model.vo.timeline.eras.AGEraSceneVO;
	import net.believecollective.ag2010.model.vo.timeline.eras.AGEraVO;
	import net.believecollective.ag2010.model.vo.timeline.eras.EraStructureVO;
	import net.believecollective.ag2010.model.vo.timeline.events.AGEventDetailVO;
	import net.believecollective.ag2010.patterns.proxy.HistoryProxy;
	import net.believecollective.model.vo.InterfaceLanguageVO;
	import net.believecollective.utils.Tracer;

	/**
	 * @author Dan Mackie - dan@believecollective.net
	 */
	public class AGMethodHelper {

		public static function fParseLangXML(arg_xml : XML) : InterfaceLanguageVO {
			var t_oLang : InterfaceLanguageVO = new InterfaceLanguageVO(arg_xml);
			return t_oLang;
		}
		
		public static function fParseEraXML(arg_xml : XML) : EraStructureVO {
			var t_oEra : EraStructureVO = new EraStructureVO(arg_xml);
			return t_oEra;
		}

		public static function parseConfig(arg_XMLList : XML) : AGConfigVO {
			var t_oVO : AGConfigVO = new AGConfigVO();
			for each (var n : XML in arg_XMLList) {
				if (String(n.startup_xmls) != "") {
					t_oVO.startupXMLS = (String(n.startup_xmls)).split(",");
				}else{
					t_oVO.startupXMLS = new Array();
				}
				t_oVO.bcURL = String(n.bc_url);
				t_oVO.maxAppWidth = Number(n.max_app_width);	
				t_oVO.maxAppHeight = Number(n.max_app_height);
				
				//Bools
				t_oVO.uselocalxml = Boolean(Number(n.uselocalxml));				t_oVO.testmode = Boolean(Number(n.test_mode));
				ApplicationFacade.LOADERDELAY = (t_oVO.testmode) ? 0 : 3 ;				t_oVO.tooltips = Boolean(Number(n.tooltips));				t_oVO.tooltipsOn = Boolean(Number(n.tooltips));				
				//Language IDs
				var t_a : Array = n.language_view_ids.split(",");
				for (var i : Number = 0;i < t_a.length; i++) {
					t_oVO.fAddLangID(t_a[i]);
				}
				// Era IDs
				var t_a : Array = n.era_ids.split(",");
				for (var i : Number = 0;i < t_a.length; i++) {
					t_oVO.fAddEraID(t_a[i]);
				}
			}
			return t_oVO;
		}
	
		public static function parseTimeline(arg_XMLList : XML, arg_oHistory : HistoryProxy, arg_oText : InterfaceLanguageVO, arg_aDateObjects : Array ) : AGTimelineVO {			var t_oVO : AGTimelineVO = new AGTimelineVO();
			for each (var n : XML in arg_XMLList) {
				for (var i : Number = 0;i < arg_XMLList[0].era.length(); i++) {
					var t_oDateData : EraStructureVO = arg_aDateObjects[i];
					var t_nPixelStart : Number =0;
					for (var j: int = 0 ; j< i; j++) {
						t_nPixelStart += (arg_aDateObjects[j] as EraStructureVO).width;
					}
					t_oDateData.startX = t_nPixelStart;
					var t_oEra:AGEraVO = new AGEraVO(	arg_XMLList[0].era[i] as XML,
														i, // chronolgical position
														arg_oHistory, // flags if an event should be activated
														arg_oText.theInterfaceText[i].theText, // era date string
														arg_oText.theInterfaceText[i+ arg_XMLList[0].era.length()].theText, // era intro text 
														t_oDateData // date data from era xml
														);
					t_oVO.fAddEra(t_oEra);
				}
			}
			return t_oVO;
		}
		
		public static function parseLandscape(arg_XMLList : XML,arg_oHistory : HistoryProxy, arg_aDateObjects : Array) : AGLandscapeVO {
			var t_oVO : AGLandscapeVO = new AGLandscapeVO();
			for each (var n : XML in arg_XMLList) {
				for (var i : Number = 0;i < arg_XMLList[0].era.length(); i++) {
					var t_oEra:AGEraSceneVO = new AGEraSceneVO(arg_XMLList[0].era[i] as XML, i, arg_oHistory, arg_aDateObjects[i] as EraStructureVO);
					t_oVO.fAddEra(t_oEra);
				}
			}
			return t_oVO;
		}
		
		public static function parseEventDetail(arg_XMLList : XML) : AGEventDetailVO{
			var t_oVO : AGEventDetailVO = new AGEventDetailVO();
			t_oVO.theID = arg_XMLList.id;
			t_oVO.title = arg_XMLList.title;
			var t_sContent : String = fParseforHtmlTags(arg_XMLList.introtext);			
			var t_sCredits : String = arg_XMLList.credit;
			var t_iOpen: int = t_sCredits.search("<"+ ApplicationFacade.LANGUAGE + ">");
			var t_iClose: int = t_sCredits.search("</"+ ApplicationFacade.LANGUAGE + ">");
			t_oVO.credits = t_sCredits.substring(t_iOpen + 2 + ApplicationFacade.LANGUAGE.length, t_iClose);
			t_oVO.content = t_sContent;			return t_oVO;
		}
		
		private static function fParseforHtmlTags(arg_s : String): String {
			arg_s = arg_s.replace("<blockquote>", "<p class = 'quote'>");			arg_s = arg_s.replace("</blockquote>", "</p>");
			arg_s = arg_s.replace("<h2>", "<p class = 'h2'>");
			arg_s = arg_s.replace("</h2>", "</p>");
			return arg_s; 
		}
		
	}
}
