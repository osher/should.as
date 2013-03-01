package should.tests
{
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class Should_suite
	{
		import tdd.Should;
		private static var s:Should = new Should();

		public var c1:Exist_testCase;
		public var c2:Should_general_testCase;
		public var c3:Should_typeCheckers_testCase;
		public var c4:Should_connectors_testrCase;
		public var c5:Should_assertFunctions_testCase;
	}
}