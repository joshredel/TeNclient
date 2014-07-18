package org.ten.events
{
	import flash.events.Event;

	public class LoginEvent extends Event
	{
		/**
		 * Our Login Event types
		 */
		public static const LOGIN_FAILED:String = "LoginFailed";
		public static const LOGIN_PASSED:String = "LoginPassed";
		
		public function LoginEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}