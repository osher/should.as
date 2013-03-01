package should.tests
{
	import tdd.Should;

	public class Exist_testCase
	{		
		// static should.exist() pass:
		[Test(description="test static should.exist() pass w/ bool")]
		public function test_stticShouldExists_bool_pass():void
		{
			Should.exist(false);
		}

		[Test(description="test static should.exist() pass w/ number")]
		public function test_stticShouldExists_number_pass():void
		{
			Should.exist(0);
			Should.exist(1);
			Should.exist(-1);
		}

		[Test(description="test static should.exist() pass w/ object")]
		public function test_stticShouldExists_object_pass():void
		{
			Should.exist({});
		}

		[Test(description="test static should.exist() pass w/ string")]
		public function test_stticShouldExists_string_pass():void
		{
			Should.exist({});
			Should.exist(new Vector.<String>());
			Should.exist(new Vector.<Boolean>());
			Should.exist(new Date());
		}

		[Test(description="test static should.exist() pass w/ array")]
		public function test_stticShouldExists_array_pass():void
		{
			Should.exist([]);
			Should.exist([1,3,4]);
			Should.exist([1,{},"str"]);
		}

		[Test(description="test static should.exist() pass w/ function")]
		public function test_stticShouldExists_function_pass():void
		{
			Should.exist(function():void{});
		}


		// static should.exist() fail:
		[Test(description="test static should.exist() fail w/ null",
		      expects="tdd.ShouldError")]
		public function test_stticShouldExists_null_fail():void
		{
			Should.exist(null);	
		}

		[Test(description="test static should.exist() fail w/ undefined",
		      expects="tdd.ShouldError")]
		public function test_stticShouldExists_undefined_fail():void
		{
			Should.exist(undefined);	
		}


		// static should.not.exist() pass:
		[Test(description="test static should.not.exist() pass w/ null")]
		public function test_stticShouldNotExists_null_pass():void
		{
			Should.not.exist(null);	
		}
		
		[Test(description="test static should.not.exist() pass w/ undefined")]
		public function test_stticShouldNotExists_undefined_pass():void
		{
			Should.not.exist(undefined);	
		}

		
		// static should.not.exist() fail:
		[Test(description="test static should.not.exist() fail w/ null",
		      expects="tdd.ShouldError")]
		public function test_stticShouldNotExists_bool_fail():void
		{
			Should.not.exist(true);	
			Should.not.exist(false);	
		}

		[Test(description="test static should.not.exist() fail w/ number",
		      expects="tdd.ShouldError")]
		public function test_stticShouldNotExists_number_fail():void
		{
			Should.not.exist(0);	
			Should.not.exist(1);	
			Should.not.exist(-1);	
		}


		[Test(description="test static should.not.exist() fail w/ string",
		      expects="tdd.ShouldError")]
		public function test_stticShouldNotExists_string_fail():void
		{
			Should.not.exist("str");	
			Should.not.exist("");	
		}
		
		[Test(description="test static should.not.exist() fail w/ object",
		      expects="tdd.ShouldError")]
		public function test_stticShouldNotExists_object_fail():void
		{
			Should.not.exist({});	
		}
		
		[Test(description="test static should.not.exist() fail w/ array",
		      expects="tdd.ShouldError")]
		public function test_stticShouldNotExists_array_fail():void
		{
			Should.not.exist([]);	
		}
		
		
		[Test(description="test static should.not.exist() fail w/ function",
		      expects="tdd.ShouldError")]
		public function test_stticShouldNotExists_function_fail():void
		{
			Should.not.exist(new function():void{});	
		}
	}
}