package should.tests
{
	import org.flexunit.AssertionError;
	import org.flexunit.asserts.fail;
	
	import tdd.Should;
	import tdd.ShouldError;

	public class Should_assertFunctions_testCase
	{	
		
		internal function fails(s:String, f:Function):void{
			var e:ShouldError;
			try{ 
				f();
			}catch(ex:tdd.ShouldError){
				return;
			}
			fail( s.replace(/\(/g,"( ") + " - did not throw" );
		}
		
		[Test]
		public function test_within():void{
			var v:*;
			v = 5;
			v.should().be.within(4,6);
			
			fails( "5.should().be.within(1,3)"
			, function():void{ v.should().be.within(1,3); }
			);
		}
		
		[Test]
		public function test_approximately():void{
			var v:*;
			v = 998;
			v.should().be.approximately(1000,2);
			
			fails( "998.should().be.approximately(1000,1)"
				, function():void{ v.should().be.approximately(1000,1); }
			);
		}
		
		[Test]
		public function test_gt():void{
			var v:*;
			v = 100;
			v.should().be.greaterThan(90);
			
			fails( "100.should().be.greaterThan(110)"
				, function():void{ v.should().be.greaterThan(110); }
			);
			fails( "100.should().be.greaterThan(100)"
				, function():void{ v.should().be.greaterThan(100); }
			);
		}
		
		[Test]
		public function test_lt():void{
			var v:*;
			v = 100;
			v.should().be.lesserThan(110);

			fails( "100.should().be.lesserThan(90)"
				, function():void{ v.should().be.lesserThan(90); }
			);
			fails( "100.should().be.lesserThan(100)"
				, function():void{ v.should().be.lesserThan(100); }
			);
		}

		[Test]
		public function test_gte():void{
			var v:*;
			v = 100;
			v.should().be.gte(90)
				     .and.gte(100);
			
			fails( "100.should().be.gte(101)"
				, function():void{ v.should().be.gte(101); }
			);
		}
		
		[Test]
		public function test_lte():void{
			var v:*;
			v = 100;
			v.should().be.lte(110)
				     .and.lte(100);
			
			fails( "100.should().be.lesserThan(90)"
				, function():void{ v.should().be.lesserThan(90); }
			);
		}
		
		[Test]
		public function test_match():void{
			var v:*;
			v = "some string";
			v.should().match(/e/);

			fails( "'some string'.should().match(/x/)"
				, function():void{ v.should().match(/x/); }
			);
		}
		
		[Test]
		public function test_property_no_value():void{
			var v:*;
			v = { a: 1, b : 2 };
			v.should().have.property("a").and.property("b");
			
			fails( "{a:1,b:2}.should().have.property('c')"
				, function():void{ v.should().have.property('c'); }
			);
		}

		[Test]
		public function test_property_with_value():void{
			var v:*;
			v = { a: 1, b : 2 };
			v.should().have.property("a",1).and.property("b",2);
			
			fails( "{a:1,b:2}.should().have.property('a',2)"
				, function():void{ v.should().have.property('a',2); }
			);
			fails( "{a:1,b:2}.should().have.property('b',1)"
				, function():void{ v.should().have.property('b',1); }
			);
			fails( "{a:1,b:2}.should().have.property('c',1)"
				, function():void{ v.should().have.property('c',1); }
			);
		}
		
		[Test]
		public function test_ownProperty_no_value():void{
			var v:*;
			v = { a: 1, b : 2 };
			v.should().have.ownProperty("a").and.ownProperty("b");
			
			fails( "{a:1,b:2}.should().have.ownProperty('should')"
				, function():void{ v.should().have.ownProperty('should'); }
			);
			
			fails( "{a:1,b:2}.should().have.ownProperty('should')"
				, function():void{ v.should().have.ownProperty('c'); }
			);
		}
		
		[Test]
		public function test_ownPproperty_with_value():void{
			var v:*;
			v = { a: 1, b : 2 };
			v.should().have.ownProperty("a",1).and.ownProperty("b",2);
			
			fails( "{a:1,b:2}.should().have.ownProperty('should')"
				, function():void{ v.should().have.ownProperty('should', {}.should); }
			);

			fails( "{a:1,b:2}.should().have.ownProperty('a',2)"
				, function():void{ v.should().have.ownProperty('a',2); }
			);
			fails( "{a:1,b:2}.should().have.ownProperty('b',1)"
				, function():void{ v.should().have.ownProperty('b',1); }
			);
			fails( "{a:1,b:2}.should().have.ownProperty('c',1)"
				, function():void{ v.should().have.ownProperty('c',1); }
			);
		}
		
		[Test]
		public function test_properties():void{
			var v:* = 
				{ a: 1, b: 2, c: 3, d : 4 };
			v.should().have.properties("a","b","c");
			
			fails( "{a:1,b:2,c:3,d:4}.should().have.properties('a','b','e')"
				, function():void{ v.should().have.properties('a','b','e') }
			);
		}
		
		[Test]
		public function test_throws_noArgsInvolved():void{
			
			var f:* = function():void{ throw new ArgumentError("haha") };
			
			f.should().raise("haha");
			f.should().raise(ArgumentError);
			f.should().raise(/ha/);
			f.should().raise();
			
			fails( "f.should().raise(AssertionError)"
				, function():void{ f.should().raise(AssertionError) }
			)
			fails( "f.should().raise('hoho')"
				, function():void{ f.should().raise('hoho') }
			)

			fails( "f.should().raise(/ho/')"
				, function():void{ f.should().raise(/ho/) }
			)
		}
		
		[Test] 
		public function test_throws_withArgs():void{
			var f:* = function(a:int,b:int):void{ throw new ArgumentError(a + " is not " + b) };
			
			f.should().raise(ArgumentError, [5,6]);
			f.should().raise("5 is not 6", [5,6]);
			f.should().raise(/is not/, [5,6]);
			f.should().raise();
			
			fails( "f.should().raise(AssertionError, [5,6])"
				, function():void{ f.should().raise(AssertionError, [5,6]) }
			)
			fails( "f.should().raise('hoho')"
				, function():void{ f.should().raise('hoho', [5,6]) }
			)
			
			fails( "f.should().raise(/ho/')"
				, function():void{ f.should().raise(/ho/, [5,6]) }
			)
			
			
		}
		
		[Test] 
		public function test_throws_withArgs_and_ctx():void{
			var f:* = function(a:int,b:int):void{ throw new ArgumentError(this.name + " sais " + a + " is not " + b) }
			  , o:Object = 
				  { name: "tester" 
				  }
		     ;
			
			f.should().raise(ArgumentError, [5,6],o);
			f.should().raise("tester sais 5 is not 6", [5,6],o);
			f.should().raise(/tester sais/, [5,6],o);
			f.should().raise(null,null,o);
			f.should().raise(null,[],o);
			f.should().raise(function(err:*):void{
				Should.exist(err);
			});
			
			fails( "f.should().raise(AssertionError, [5,6])"
				, function():void{ f.should().raise(AssertionError, [5,6], o) }
			)
			fails( "f.should().raise('hoho')"
				, function():void{ f.should().raise('hoho', [5,6], o) }
			)
			
			fails( "f.should().raise(/ho/')"
				, function():void{ f.should().raise(/ho/, [5,6], o) }
			)
			
			
		}
		
	
	}
}