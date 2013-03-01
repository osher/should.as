package tdd
{
	public class Shouldnt	
	{
		public function Shouldnt(){}
		
		public function exist(o:*):void
		{
			if (null != o) {
				Should.fail("expected " + Should.i(o) + " not to exist");
			}
		}			
	}
}