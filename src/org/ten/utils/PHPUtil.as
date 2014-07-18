package org.ten.utils
{
	public class PHPUtil
	{
		
		/**
		 * Converts an integer response from the server
		 * into a boolean.
		 * 
		 * @param integer the response from the server
		 * @return true if integer is 1, false otherwise
		 */
		public static function intToBool(integer:int):Boolean
		{
			return (integer == 1);
		}

	}
}