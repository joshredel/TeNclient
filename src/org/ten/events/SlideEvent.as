package org.ten.events
{
	import flash.events.Event;

	public class SlideEvent extends Event
	{
		/**
		 * Our Slide Event types.
		 */
		public static const SLIDE_COMPLETE:String = "sideHasCompleted";
		public static const SLIDE_LOADED:String = "slideContentHasLoaded";
		
		public function SlideEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}