
package net.believecollective.ag2010.app {
	import net.believecollective.ag2010.patterns.commands.CreateAppInterfacesCommand;
	import net.believecollective.ag2010.patterns.commands.CreateViewAndMediatorCommand;
	import net.believecollective.ag2010.patterns.commands.LoadFontsCommand;
	import net.believecollective.ag2010.patterns.commands.ParseEraXMLCommand;
	import net.believecollective.ag2010.patterns.commands.ParseLanguageXMLCommand;
	import net.believecollective.ag2010.patterns.commands.ParseStartupXMLCommand;
	import net.believecollective.ag2010.patterns.commands.ParseXMLConfigCommand;
	import net.believecollective.ag2010.patterns.commands.ParseXMLDetailCommand;
	import net.believecollective.ag2010.patterns.commands.ParseXMLLandscapeCommand;
	import net.believecollective.ag2010.patterns.commands.ParseXMLTimelineCommand;
	import net.believecollective.ag2010.patterns.commands.StartInterfaceBGCommand;
	import net.believecollective.ag2010.patterns.commands.StartInterfaceCommand;
	import net.believecollective.ag2010.patterns.commands.StartupCommand;
	import net.believecollective.frameworks.pureMVC2.app.ApplicationFacadeBase;
	import net.believecollective.frameworks.pureMVC2.patterns.commands.CallWebServiceCommand;

	import org.puremvc.as3.interfaces.IFacade;

	import flash.display.DisplayObject;

	public class ApplicationFacade extends ApplicationFacadeBase implements IFacade {
		///////////
		//STATIC VARS
		//////////
		public static var APP_WIDTH : Number = APP_WIDTH_DEFAULT;
		public static var HORIZONTAL_FOCUS_POINT : Number = 240; // the x-coordinate of paralax focus		public static var DETAIL_PANEL_X : Number = 80;//		public static var DETAIL_PANEL_X : Number = 360;
		public static var LOADERDELAY : Number = 2;
		public static var IS_USING_LOCAL : Boolean = false;
		public static var BASEPATH : String = "http://www.ayo-gorkhali.org/";		public static var CURRENT_X_IN_FOCUS : Number;
		public static var LANGUAGE : String = "en";		public static var CURRENT_ERA_IN_VIEW : Number;		public static var ACTIVE_ITEM_ID : Number = 48;
		public static var IS_DRAGGING : Boolean;		public static var IS_FACEBOOK : Boolean;		public static var EVENT_IS_ACTIVE : Boolean;
		
		///////////
		//CONSTANTS
		////////////
		
		public static const TIMELINE_PATH : String = "http://www.ayo-gorkhali.org/index.php/en/timeline/";
		
		//FONTNAMES
		//Audimat
		public static const FONT_AUDIMAT_ALL : String = "audimatAll"; // The SWF contains all the Audimat fonts below, but each font is called seperately
		public static const FONT_AUDIMAT_REGULAR : String = "audimatRegular";
		public static const FONT_AUDIMAT_ITALIC : String = "audimatItalic";
		public static const FONT_AUDIMAT_BOLD : String = "audimatBold";
		public static const FONT_AUDIMAT_BOLDITALIC : String = "audimatBoldItalic";
			//Corbel
		public static const FONT_CORBEL_ALL : String = "corbelAll"; // The SWF contains all the Corbel fonts below, but each font is called seperately
		public static const FONT_CORBEL_REGULAR : String = "corbelRegular";
		public static const FONT_CORBEL_BOLD : String = "corbelBold";
		public static const FONT_CORBEL_ITALIC : String = "corbelItalic";
		public static const FONT_CORBEL_BOLDITALIC : String = "corbelBoldItalic";
			//Gurumaa
		public static const FONT_GURUMAA : String = "gurumaa";
		// EXTERNAL ASSETS
		public static const REMOTE_TIMELINE_FILEPATH : String = "images/flash/timeline/";		public static const REMOTE_FONTS_FILEPATH : String = "images/flash/fontswfs/";		public static const LOCAL_FONTS_FILEPATH : String = "fontswfs/";
		public static const IMAGEPATH_COMPONENTS : String = "assets/images/";
		public static const SWFPATH_COMPONENTS : String = "assets/swf/";		public static const ERADIVIDERPATH_COMPONENTS : String = "eradividers/";		public static const SILHOUETTESPATH_COMPONENTS : String = "silhouettes/";		public static const LANDSCAPEPATH_COMPONENTS : String = "landscape/";		public static const LANDSCAPE_ANIMATIONPATH_COMPONENTS : String = "landscape/animations";		public static const IMAGE_DETAILPATH_COMPONENTS : String = "detail/";		public static const IMAGE_LANDSCAPE_DETAILPATH_COMPONENTS : String = "detail_landscape/";
		// XML
		public static const ARTICLE_SERVICE_LOCAL_FILENAME: String = "service.php?";		public static const CONFIG_XML_LOCAL_FILENAME : String = "config.xml";		public static const TIMELINE_XML_LOCAL_FILENAME : String = "timeline.xml";		public static const LANDSCAPE_XML_LOCAL_FILENAME : String = "landscape.xml";		public static const DETAILS_XML_LOCAL_FILENAME : String = "details.xml";
		public static const LANGUAGEPATH : String = "assets/language/";	//Used to get the interface language path XML dir
		public static const URL_CONCAT_CHAR : String = "&";		public static const URL_PAIR_CHAR : String = "=";		public static const URL_LANG_VAR : String = "lang";		public static const URL_PAGEID_VAR : String = "pageid";		public static const XMLPATH : String = "assets/xml/";		public static const AUDIOPATH : String = "assets/audio/";
		// Navigator
		public static var NAV_X_BUFFER : Number = 18;		public static const NAV_BAR_HEIGHT : Number = 28;		public static var NAV_BUTTON_SEPARATION : Number = 94;
		// Detail View
		public static const DETAIL_TEXT_MAX_HEIGHT : Number = 144;		public static const DETAIL_TEXT_WIDTH : Number = 330;
		//GENERICS
		public static const APP_HEIGHT : Number = 300;		public static const APP_WIDTH_DEFAULT : Number = 972; //
		public static const FRAME_RATE : Number = 25;		public static const TWEEN_DURATION : Number = 0.3;		public static const TIMELINE_TWEEN_DURATION : Number = 1;
		public static const FADE_TWEEN_DURATION : Number = 0.9;		public static const PANEL_DROP_OBJECT : Object = {color:0x000000, alpha:0.85, blurX:30, blurY:10, distance:2, angle: 90};		public static const BUTTON_DROP_OBJECT : Object = {color:0x000000, alpha:0.5, blurX:2, blurY:2, distance:2};		public static const TEXT_DROP_OBJECT : Object = {color:0x000000, alpha:0.4, angle: 90, blurX:2, blurY:2, distance:0.5};
		// FACEBOOK SPECS
		public static const HORIZONTAL_FOCUS_POINT_FB : Number = 70; 
		public static const DETAIL_PANEL_X_FB : Number = 23;
		public static const DETAIL_TEXT_WIDTH_FB : Number = 202;
		public static const NAV_BUTTON_SEPARATION_FB : Number = 30;
		public static const NAV_X_BUFFER_FB : Number = 12;
		public static const APP_WIDTH_FB : Number = 520; // width of the app embeded on facebook fan page
		/// CURSOR
		public static const CURSOR_MODE_MOUSE : String = "cursor_mode_mouse";
		public static const CURSOR_MODE_OPEN : String = "cursor_mode_open";
		public static const CURSOR_MODE_CLOSED : String = "cursor_mode_closed";
		public static const CURSOR_MODE_POINT : String = "cursor_mode_point";
		
		///////////
		//APPLICATION EVENTS
		///////////
		//COMMANDS
		////Startup
		public static const CMD_CALL_WEBSERVICE : String = "command_call_webservice";		public static const CMD_XML_LANG_PARSE : String = "command_xml_language_parse";		public static const CMD_XML_ERA_PASRSE : String = "command_xml_era_parse";
		public static const CMD_STARTUP_XML_PARSE : String = "command_startup_xml_parse";		public static const CMD_TIMELINE_XML_PARSE : String = "command_timeline_xml_parse";		public static const CMD_DETAIL_XML_PARSE : String = "command_detail_xml_parse";		public static const CMD_LANDSCAPE_XML_PARSE : String = "command_landscape_xml_parse";
		public static const CMD_START_INTERFACE : String = "command_start_interface";		public static const CMD_START_INTERFACE_BG : String = "command_start_interface_bg";
		public static const CMD_LOAD_FONTS : String = "command_load_fonts";		
		//NOTIFICATION EVENTS
		public static const NOTE_GFX_LOAD_ERROR : String = "note_gfx_load_error";
		public static const NOTE_INIT_VIEWS : String = "note_init_views";
		public static const NOTE_DATA_UPDATE : String = "note_data_update";
		public static const NOTE_UPDATE_LOADER : String = "note_update_loader";		public static const NOTE_FINISH_LOADING_SEQUENCE : String = "note_finish_loading_sequence";
		public static const NOTE_NEW_DATA_LOADED : String = "note_new_data_loaded";
		// mouse movements
		public static const NOTE_MOUSE_LEAVE : String = "note_mouse_mouse_leave";
		public static const NOTE_MOUSE_MOVE : String = "note_mouse_mouse_move";
		// timeline interaction
		public static const NOTE_TIMELINE_MOVE : String = "note_timeline_shift";		public static const NOTE_TIMELINE_BOUNCE : String = "note_timeline_bounce";		public static const NOTE_ENTERING_NEW_ERA : String = "note_new_era_entered";		public static const NOTE_TIMELINE_EVENT_ACTIVE : String = "note_timeline_event_active";		public static const NOTE_GET_EVENT_URL : String = "note_get_event_url";		public static const NOTE_OPEN_EVENT_URL : String = "note_open_event_url";		public static const NOTE_CLOSE_PANEL : String = "note_close_panel";		public static const NOTE_SHOW_FEEDBACK : String = "note_show_feedback";
		// controls
		public static const NOTE_TOGGLE_FULL_SCREEN : String = "note_toggle_full_screen";		public static const NOTE_TOGGLE_HELP : String = "note_toggle_help";		public static const NOTE_LAUNCH_TIMELINE : String = "note_launch_timeline";		//Test notes		public static const TESTNOTE_TOGGLE_TEST_PANEL : String = "testnote_toggle_test_panel";		public static const TESTNOTE_MAKE_PANE_ELEMENTS_DRAGGABLE : String = "testnote_make_pane_elements_draggable";		public static const TESTNOTE_TOGGLE_TOOLTIPS : String = "testnote_toggle_tooltips";
		public static const TESTNOTE_GET_ACTIVE_PANE_ELEMENT_POSITIONS : String = "testnote_get_active_pane_element_positions";
		/**
		 * Singleton ApplicationFacade Factory Method
		 */
		public static function getInstance() : ApplicationFacade {
			if ( instance == null ) instance = new ApplicationFacade();
			return instance as ApplicationFacade;
		}

		/**
		 * Register Commands with the Controller
		 */
		override protected function initializeController() : void {
			super.initializeController();
			registerCommand(CMD_STARTUP, StartupCommand);
			registerCommand(CMD_XML_CONFIG_PARSE, ParseXMLConfigCommand);
			registerCommand(CMD_XML_LANG_PARSE, ParseLanguageXMLCommand);			registerCommand(CMD_XML_ERA_PASRSE, ParseEraXMLCommand);
			registerCommand(CMD_STARTUP_XML_PARSE, ParseStartupXMLCommand);			registerCommand(CMD_TIMELINE_XML_PARSE, ParseXMLTimelineCommand);			registerCommand(CMD_DETAIL_XML_PARSE, ParseXMLDetailCommand);			registerCommand(CMD_LANDSCAPE_XML_PARSE, ParseXMLLandscapeCommand);			registerCommand(CMD_START_INTERFACE, StartInterfaceCommand);			registerCommand(CMD_START_INTERFACE_BG, StartInterfaceBGCommand);			registerCommand(CMD_CREATE_APP_INTERFACES, CreateAppInterfacesCommand);
			registerCommand(CMD_CREATE_VIEW_AND_MEDIATOR, CreateViewAndMediatorCommand);			registerCommand(CMD_CALL_WEBSERVICE, CallWebServiceCommand);
			registerCommand(CMD_LOAD_FONTS, LoadFontsCommand);	
		}

		public function startup( arg_mcRoot : DisplayObject ) : void {
			ROOT = arg_mcRoot;
			sendNotification(CMD_STARTUP, arg_mcRoot);
		}
		
	}
}