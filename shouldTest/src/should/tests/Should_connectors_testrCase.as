package should.tests
{
	import org.flexunit.asserts.assertTrue;
	
	import tdd.Should;

	public class Should_connectors_testrCase
	{		
		private var s:Should = {}.should();
		
		internal function checkConnector(s:Should, c:String):void{
			assertTrue(s is Should);
			assertTrue(s[c] is Should);
			assertTrue(s[c] === s);		
		}
		
		[Test]
		public function test_should_be():void{
			checkConnector(s, "be");
		}
		
		[Test]
		public function test_should_and():void{
			checkConnector(s, "and");
		}

		[Test]
		public function test_should_have():void{
			checkConnector(s, "have");
		}
		
		[Test]
		public function test_should_an():void{
			checkConnector(s, "an");
		}

		[Test]
		public function test_should_a():void{
			checkConnector(s, "a");
		}

		[Test]
		public function test_should_not():void{
			checkConnector(s, "not");
		}
		
		
	}
}