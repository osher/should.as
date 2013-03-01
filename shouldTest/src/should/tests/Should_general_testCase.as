package should.tests
{
	import org.flexunit.asserts.assertTrue;
	
	import tdd.Should;

	public class Should_general_testCase
	{		
		
		[Test(
			description="Object has a function attribute should of Type tdd.Should"
		)]
		public function test_objectHasShould_ofType_tddShould():void
		{
			var o:Object = {};
			
			assertTrue(!!o.should );
			assertTrue( typeof o.should == 'function' );
			assertTrue( !!o.should() );
			assertTrue( o.should() is Should);
		}
		
		[Test]
		public function test_anyHasShould_ofType_tddShould():void
		{
			var o:* = {};
			o.should().equal(o);
			
			var s:* = "bbb";
			s.should().equal("bbb");
			
			var n:* = 6;
			n.should().equal(6);
			
			var d:* = new Date();
			d.should().equal(d);
			
			var b:* = true;
			b.should().equal(true);
			
			var a:* = [];
			a.should().equal(a);
		}
		
		[Test]
		public function test_someGenericObject():void
		{
			var o:Object = 
				{ name: "Osher",
				  age: 35, 
				  friends: [ "AntonY","ScottA","AntonP"]
				};
			
			
			o.should()
				.have.properties("name","age","friends")
				.and.be.object;
			
			o.age.should()
				.be.number
				.and.between(30,40)
				.and.not.between(50,60);

			o.name.should().equal('Osher')
			
		}
		
		[Test(
			description="String has a function attribute should of Type tdd.Should"
		)]
		public function test_StringHasShould_ofType_tddShould():void
		{
			var o:String = "aaa";
			assertTrue( !!String.prototype.should );
			assertTrue( String.prototype.should == Object.prototype.should );
			assertTrue( o["should"]() is Should );
			
			assertTrue( o["should"]().equal("aaa") );
		}
		
		[Test(
			description="Number has a function attribute should of Type tdd.Should"
		)]
		public function test_intHasShould_ofType_tddShould():void
		{
			var o:int = 5;
			assertTrue( !!String.prototype.should );
			assertTrue( Number.prototype.should == Object.prototype.should );
			assertTrue( o["should"]() is Should );
			
			assertTrue( o["should"]().equal(5) );
		}


		[Test(
			description="attribute of type Number has a function attribute should of Type tdd.Should"
		)]
		public function test_attrIntHasShould_ofType_tddShould():void
		{
			var o:* = { value: 5 };
			
			assertTrue( o.value.should().equal(5) );
		}
		
		
		[Test(
			description="o.should().equal(o) - pass"
		)]		
		public function test_objectShouldStrictEqualItself_pass():void
		{
			var o:Object = {};
			o.should().equal(o);
		}
		
		[Test(
			description="o.should().equal({}) - throws",
		    expects="tdd.ShouldError"
		)]		
		public function test_objectShouldStrictEqualElse_fail():void
		{
			var o:Object = {};
			o.should().equal({});
		}

		[Test(
			description="'aaa'.should().equal('aab') - throws",
		    expects="tdd.ShouldError"
		)]		
		public function test_StringShouldStrictEqualElse_fail():void
		{
			var o:String = "aaa";
			o["should"]().equal("aab");
		}

		[Test(
			description="5.should().equal(4) - throws",
		    expects="tdd.ShouldError"
		)]		
		public function test_NumberShouldStrictEqualElse_fail():void
		{
			var o:int = 5;
			o["should"]().equal(4);
		}
	}
}