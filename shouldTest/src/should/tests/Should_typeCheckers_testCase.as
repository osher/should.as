package should.tests
{
	import org.flexunit.asserts.fail;
	
	import tdd.Should;

	public class Should_typeCheckers_testCase
	{	
		import tdd.ShouldError;
		
		private var o:* = 
				{ a: [1,2,4]
			    , s: "a"
				, n: 1
				, b: true
				, t: true
				, f: false
				, inf: 1 / 0
	   		    , nan: parseInt("not-a-number")
				, d: new Date()
				};
		private var types:Array = ["array","string","number","boolean","date"]
			     , values:Array = ["$true","$false","$Infinity","$NaN"]
			     ;
		
		internal function checkArr(arr:Array, v:*, expected:String):void
		{
			arr.forEach(function(type:String,ix:*,arr:Array):void
			{
				var e:ShouldError = null
				  , should:Should = v.should()
				  ;
				
				if (type == expected) 
				{ 
					should.be[type];
				}
				else
				{
					try 
					{
						should.be[type];
					}
					catch(ex:ShouldError)
					{
						e = ex;					
					}
					if (!e) fail(Should.inspect(v) + ".should.be." + type + " - did not throw tdd.ShouldError" );
				}
			});
		}
		
		internal function checkType(v:*, expected:String):void{
			checkArr(types, v, expected);
		}

		internal function checkValues(v:*, expected:String):void{
			checkArr(values, v, expected);
		}

		[Test]
		public function test_shouldBeArray():void{
			checkType(o.a, "array");
		}

		[Test]
		public function test_shouldBeString():void{
			checkType(o.s, "string");
		}
		
		[Test]
		public function test_shouldBeNumber():void{
			checkType(o.n, "number");
		}

		[Test]
		public function test_shouldBeBool():void{
			checkType(o.b, "boolean");
		}

		[Test]
		public function test_shouldBeDate():void{
			checkType(o.d, "date");
		}
		
		[Test]
		public function test_shouldBeTrue():void{
			checkValues(o.t, "$true");
		}
		
		[Test]
		public function test_shouldBeFalse():void{
			checkValues(o.f, "$false");
		}

		[Test]
		public function test_shouldBeNaN():void{
			checkValues(o.nan, "$NaN");
		}

		[Test]
		public function test_shouldBeInf_pass():void{
			checkValues(o.inf, "$Infinity");
		}
	}
}