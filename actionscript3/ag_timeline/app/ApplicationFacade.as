
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
		public static var HORIZONTAL_FOCUS_POINT : Number = 240; // the x-coordinate of paralax focus
		public static var LOADERDELAY : Number = 2;
		public static var IS_USING_LOCAL : Boolean = false;
		public static var BASEPATH : String = "http://www.ayo-gorkhali.org/";
		public static var LANGUAGE : String = "en";
		public static var IS_DRAGGING : Boolean;
		
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
		public static const REMOTE_TIMELINE_FILEPATH : String = "images/flash/timeline/";
		public static const IMAGEPATH_COMPONENTS : String = "assets/images/";
		public static const SWFPATH_COMPONENTS : String = "assets/swf/";
		// XML
		public static const ARTICLE_SERVICE_LOCAL_FILENAME: String = "service.php?";
		public static const LANGUAGEPATH : String = "assets/language/";	//Used to get the interface language path XML dir
		public static const URL_CONCAT_CHAR : String = "&";
		// Navigator
		public static var NAV_X_BUFFER : Number = 18;
		// Detail View
		public static const DETAIL_TEXT_MAX_HEIGHT : Number = 144;
		//GENERICS
		public static const APP_HEIGHT : Number = 300;
		public static const FRAME_RATE : Number = 25;
		public static const FADE_TWEEN_DURATION : Number = 0.9;
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
		public static const CMD_CALL_WEBSERVICE : String = "command_call_webservice";
		public static const CMD_STARTUP_XML_PARSE : String = "command_startup_xml_parse";
		public static const CMD_START_INTERFACE : String = "command_start_interface";
		public static const CMD_LOAD_FONTS : String = "command_load_fonts";
		//NOTIFICATION EVENTS
		public static const NOTE_GFX_LOAD_ERROR : String = "note_gfx_load_error";
		public static const NOTE_INIT_VIEWS : String = "note_init_views";
		public static const NOTE_DATA_UPDATE : String = "note_data_update";
		public static const NOTE_UPDATE_LOADER : String = "note_update_loader";
		public static const NOTE_NEW_DATA_LOADED : String = "note_new_data_loaded";
		// mouse movements
		public static const NOTE_MOUSE_LEAVE : String = "note_mouse_mouse_leave";
		public static const NOTE_MOUSE_MOVE : String = "note_mouse_mouse_move";
		// timeline interaction
		public static const NOTE_TIMELINE_MOVE : String = "note_timeline_shift";
		// controls
		public static const NOTE_TOGGLE_FULL_SCREEN : String = "note_toggle_full_screen";
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
			registerCommand(CMD_XML_LANG_PARSE, ParseLanguageXMLCommand);
			registerCommand(CMD_STARTUP_XML_PARSE, ParseStartupXMLCommand);
			registerCommand(CMD_CREATE_VIEW_AND_MEDIATOR, CreateViewAndMediatorCommand);
			registerCommand(CMD_LOAD_FONTS, LoadFontsCommand);	
		}

		public function startup( arg_mcRoot : DisplayObject ) : void {
			ROOT = arg_mcRoot;
			sendNotification(CMD_STARTUP, arg_mcRoot);
		}
		
	}
}