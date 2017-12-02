package net.believecollective.ag2010.events {
	import flash.events.Event;

	/**
	 * @author Marianne
	 */
	public class AGTimelineElementEvent extends Event {
		
		public static const AGTIMELINE_EVENT_CLICK : String = "timeline_event_click";
		public static const AGTIMELINE_EVENT_ROLLOVER : String = "timeline_event_rollover";
		public static const AGTIMELINE_EVENT_ROLLOUT : String = "timeline_event_rollout";
		public static const AGTIMELINE_GRAPHIC_LOADED : String = "timeline_graphic_loaded";		public static const AGTIMELINE_LABEL_ADDED : String = "timeline_label_added";		public static const AGTIMELINE_EVENT_TOGGLED_ON : String = "timeline_event_toggled_on";

		public function AGTimelineElementEvent( type : String) {
			super(type, true);
		}
	}
}
