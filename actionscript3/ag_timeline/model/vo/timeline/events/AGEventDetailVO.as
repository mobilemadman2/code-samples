
package net.believecollective.ag2010.model.vo.timeline.events {
	import net.believecollective.model.StandardConfig;

	/**
	 * @author Dan Mackie (dan@believecollective.net)
	 */
	public class AGEventDetailVO extends StandardConfig {

		private var _sTitle : String;		private var _sContent : String;
		private var _sCredits : String;
		private var _sTimelineText : String;		private var _sTimeline : String;
		private var _nID : Number;
		
		public function AGEventDetailVO() {		}
		
		public function get title() : String {
			return _sTitle;
		}
		
		public function get content() : String {
			return _sContent;
		}
		
		public function set content(sContent : String) : void {
			_sContent = sContent;
		}
		
		public function set title(sTitle : String) : void {
			_sTitle = sTitle;
		}
		
		public function get credits() : String {
			return _sCredits;
		}
		
		public function set credits(sCredits : String) : void {
			_sCredits = sCredits;
		}
		
		public function get timeline() : String {
			return _sTimeline;
		}
		
		public function set timeline(sTimeline : String) : void {
			_sTimeline = sTimeline;
		}
		
		public function get timelineText() : String {
			return _sTimelineText;
		}
		
		public function set timelineText(sTimeline : String) : void {
			_sTimelineText = sTimeline;
		}
		
		public function get theID() : Number {
			return _nID;
		}
		
		public function set theID(nID : Number) : void {
			_nID = nID;
		}
	}
}
