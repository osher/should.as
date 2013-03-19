package tdd
{
	public class Should
	{
		private static var _not:Shouldnt = new Shouldnt();
		
		private var _value:*;
		private var _negate:Boolean = false;
		private var _err:*;

		//static constructur
		{
			Object.prototype.should = function(attr:String=null):Should
			{
				return attr ? new tdd.Should(this[attr]) : new tdd.Should(this);
			};
			Object.prototype.setPropertyIsEnumerable("should",false);
		}
		
		public function Should(v:*=null){
			_value = v;
		}
		
		//--- static -------------------------------------------------------------------
		
		public static function get not():Shouldnt
		{
			return _not;
		}
		
		public static function fail(s:String):void
		{
			//TODO - allow use assert.fail
			throw new ShouldError(s);
		}

		public static function exist(o:*):void
		{
			if (null == o) Should.fail("expected " + i(o) + " to exist");
		}

		public static function inspect(o:*):String
		{
			return i(o); 
		}	
	
		//--- member -------------------------------------------------------------------

		//----- connectors
		public function get be():Should{
			return this;
		}

		public function get and():Should{
			return this;
		}

		public function get an():Should{
			return this;
		}

		public function get a():Should{
			return this;
		}
		
		public function get have():Should{
			return this;
		}
		
		//----- negativator
		public function get not():Should{
			_negate = true;
			return this;
		}
		
		//----- type checkers
		public function get array():Should{
			this.claim(
				_value is Array
				, function():String{ return s('expected ', this.inspect, ' to be of type Array' ) }
				, function():String{ return s('expected ', this.inspect, ' to not be of type Array' ) }
				, true 
				, _value
			);
			return this;
		}
		
		public function get boolean():Should{
			this.claim(
				_value is Boolean
				, function():String{ return s('expected ', this.inspect, ' to be of type Boolean' ) }
				, function():String{ return s('expected ', this.inspect, ' not to be of type Boolean' ) }
				, Boolean 
				, _value
			);
			return this;
		}
		
		public function get string():Should{
			this.claim(
				_value is String
				, function():String{ return s('expected ', this.inspect, ' to be of type String' ) }
				, function():String{ return s('expected ', this.inspect, ' not to be of type String' ) }
				, String 
				, _value
			);
			return this;
		}

		public function get number():Should{
			this.claim(
				_value is Number
				, function():String{ return s('expected ', this.inspect, ' to be of type Number' ) }
				, function():String{ return s('expected ', this.inspect, ' not to be of type Number' ) }
				, Number 
				, _value
			);
			return this;
		}

		public function get object():Should{
			this.claim(
				_value is Object
				, function():String{ return s('expected ', this.inspect, ' to be of type Object' ) }
				, function():String{ return s('expected ', this.inspect, ' not to be of type Object' ) }
				, Number 
				, _value
			);
			return this;
		}
		
		public function get date():Should{
			this.claim(
				_value is Date
				, function():String{ return s('expected ', this.inspect, ' to be Date' ) }
				, function():String{ return s('expected ', this.inspect, ' not to be Date' ) }
				, Date 
				, _value
			);
			return this;
		}
		
		public function get handler():Should{
			this.claim(
				_value is Function
				, function():String{ return s('expected ', this.inspect, ' to be a Function' ) }
				, function():String{ return s('expected ', this.inspect, ' not to be a Function' ) }
				, Date 
				, _value
			);
			return this;
		}

		//----- checkers of strict/constant value
		public function get $true():Should{
			this.claim(
				true ===_value
				, function():String{ return s('expected ', this.inspect, ' to be boolean:true' ) }
				, function():String{ return s('expected ', this.inspect, ' to not be boolean:true' ) }
				, true 
				, _value
			);
			return this;
		}
		
		public function get $false():Should{
			this.claim(
				false ===_value
				, function():String{ return s('expected ', this.inspect, ' to be boolean:false' ) }
				, function():String{ return s('expected ', this.inspect, ' to not be boolean:false' ) }
				, true 
				, _value
			);
			return this;
		}

		public function get $NaN():Should{
			this.claim(
				isNaN (_value )
				, function():String{ return s('expected ', this.inspect, ' to be Number.NaN' ) }
				, function():String{ return s('expected ', this.inspect, ' to not be Number.NaN' ) }
				, true 
				, _value
			);
			return this;
		}

		public function get $Infinity():Should{
			this.claim(
				Infinity == _value
				, function():String{ return s('expected ', this.inspect, ' to be Number.NaN' ) }
				, function():String{ return s('expected ', this.inspect, ' to not be Number.NaN' ) }
				, true 
				, _value
			);
			return this;
		}
		
		//----- assert functions
		
		public function empty():Should{
			this.claim(
				_value.length === 0
				, function():String{ return 'expected ' + this.inspect + ' to be empty' }
				, function():String{ return 'expected ' + this.inspect + ' not to be empty' }
		        , "<empty>"
				, _value
			);
			return this;
		}
		
		public function ok():Should{
			this.claim(
				_value
			, function():String{ return 'expected ' + this.inspect + ' to be truthy' }
			, function():String{ return 'expected ' + this.inspect + ' to be falsey' }
			);
			return this;
		}
		
		public function equal(val:*,desc:String=null):Should
		{
			this.claim(
				val === _value
		    , function():String{ return s('expected ', this.inspect, ' to strictEqual '     , i(val) , (desc ? " | " + desc : "") ) }
		    , function():String{ return s('expected ', this.inspect, ' to not strictEqual ' , i(val) , (desc ? " | " + desc : "") ) }
			, val
			, _value
			);
			return this;
		}
		
		public function within(start:Number, finish:Number, desc:String=null):Should{
			if (start > finish) {
				//change places
				start  = start + finish;
				finish = start - finish;
				start  = start - finish;
			}
			var range:String = start + ".." + finish;
			this.claim(
				start <= _value && _value <= finish
				, function():String{ return s('expected ', this.inspect, ' to be within ', start, '..', finish , (desc ? " | " + desc : "") ) }
				, function():String{ return s('expected ', this.inspect, ' to be out of ', start, '..', finish , (desc ? " | " + desc : "") ) }
				, s(start, '..', finish)
				, _value
			);			
			return this;
		}
		
		public function approximately(value:Number, delta:Number, desc:String=null):Should{
			return within(value - delta, value + delta, desc);
		}
		
		//TODO: ofType
		
		//TODO: instanceof
		
		public function greaterThan(value:Number, desc:String=null):Should{
			this.claim(
				_value > value
				, function():String{ return s('expected ', this.inspect, ' to be bigger than ', value, (desc ? " | " + desc : "") ) }
				, function():String{ return s('expected ', this.inspect, ' to be no bigger than ', value, (desc ? " | " + desc : "") ) }
				, value
				, _value
			);
			return this;
		}
		
		public function greaterThanOrEqual(value:Number, desc:String=null):Should{
			this.claim(
				_value >= value
				, function():String{ return s('expected ', this.inspect, ' to be bigger than or equal to ', value, (desc ? " | " + desc : "") ) }
				, function():String{ return s('expected ', this.inspect, ' to be lesser than ', value, (desc ? " | " + desc : "") ) }
				, value
				, _value
			);
			return this;
		}
		
		public function lesserThan(value:Number, desc:String=null):Should{
			this.claim(
				_value < value
				, function():String{ return s('expected ', this.inspect, ' to be lesser than ', value, (desc ? " | " + desc : "") ) }
				, function():String{ return s('expected ', this.inspect, ' to be no lesser than ', value, (desc ? " | " + desc : "") ) }
				, value
				, _value
			);
			return this;
		}
		
		public function lesserThanOrEqual(value:Number, desc:String=null):Should{
			this.claim(
				_value <= value
				, function():String{ return s('expected ', this.inspect, ' to be lesser than or equal to ', value, (desc ? " | " + desc : "") ) }
				, function():String{ return s('expected ', this.inspect, ' to be bigger than ', value, (desc ? " | " + desc : "") ) }
				, value
				, _value
			);
			return this;
		}
		
		public function match(value:RegExp, desc:String=null):Should{
			this.claim(
				value.exec(_value)
				, function():String{ return s('expected ', this.inspect, ' to match ', value, (desc ? " | " + desc : "") ) }
				, function():String{ return s('expected ', this.inspect, ' to match ', value, (desc ? " | " + desc : "") ) }
				, value
				, _value
			);
			return this;
		}
		
		public function property(attr:String, val:*=undefined,desc:String=null):Should{
			if (val === undefined){
				this.claim(
					_value[attr]
				, function():String{ return s('expected ', this.inspect, ' to have property ', attr , (desc ? " | " + desc : "") ) }
				, function():String{ return s('expected ', this.inspect, ' not to have property ', attr , (desc ? " | " + desc : "") ) }
				, "<property>"
				, _value[attr]
				);
			}else{
				this.claim(
					_value[attr] == val //TODO - replace with to deepEqual
					, function():String{ return s('expected ', this.inspect, ' to have property ', attr, ' of ', i(val), ' but got ', i(_value[attr]), (desc ? " | " + desc : "") ) }
					, function():String{ return s('expected ', this.inspect, ' not to have property ', attr , ' of ', i(val), (desc ? " | " + desc : "") ) }
					, s(attr," of ",val)
					, _value[attr]
				);				
			}
			
			return this;
		}
		
		public function properties(...args):Should{
			var sAttrs:String = 'one of ' + args.join()
			  , has:Should = this
			  ;
			args.forEach(function(attr:*,ix:int,arr:Array):void{
				has.property( attr, undefined, sAttrs ); 
			});
			return this;
		}
		
		public function ownProperty(attr:String, val:*=undefined,desc:String=null):Should{
			if (val === undefined){
				this.claim(
					_value is Object && _value.hasOwnProperty(attr) && _value[attr]
					, function():String{ return s('expected ', this.inspect, ' to have own property ', attr , (desc ? " | " + desc : "") ) }
					, function():String{ return s('expected ', this.inspect, ' not to have own property ', attr , (desc ? " | " + desc : "") ) }
					, "<own-property>"
					, _value[attr]
				);
			}else{
				this.claim(
					_value is Object && _value.hasOwnProperty(attr) && _value[attr] == val //TODO - replace with to deepEqual
					, function():String{ return s('expected ', this.inspect, ' to have own property ', attr, ' of ', i(val), ' but got ', i(_value[attr]), (desc ? " | " + desc : "") ) }
					, function():String{ return s('expected ', this.inspect, ' not to have own property ', attr , ' of ', i(val), (desc ? " | " + desc : "") ) }
					, s(attr," of ",val)
					, _value[attr]
				);
			}
						
			return this;
		}
		
		public function ownProperties(...args):Should{
			var sAttrs:String = 'one of ' + args.join()
				, has:Should = this
				;
			args.forEach(function(attr:*,ix:int,arr:Array):void{
				has.ownProperty( attr, undefined, sAttrs ); 
			});
			return this;
		}
		
		//TODO - include
		
		//TODO - includeEql
		
		//TODO - keys
		
		public function throws(err:* = "",args:Array = null,ctx:Object = null):Should{
			this.handler;
			var f:Function = _value as Function
			  , e:Error
			  , errInfo:String = ""
			  , ok:Boolean = true
			  ;
			
			try {
				f.apply(ctx, args || []);
				ok = false;
			}catch(ex:Error){
				_err = e = ex;
			}
			
			if (ok && err){
				if (err is String) {
					ok = err == e.message;
					if (!ok) errInfo = s(" with a the message '" , err , "', but got '" , e.message , "'");
				} else if (err is RegExp) {
					ok = (err as RegExp).test(e.message);
					if (!ok) errInfo = s(" with a message matching '" , err , "', but got '" , e.message , "'");
				} else if (err is Class) {
					ok = e is err;
					if (!ok) errInfo = s(" of type '" , err , "', but got '" , e.name , "'");
				} else if (err is Function) {
					err(_err);
				}
			}
			
			this.claim( 
				ok
				, function():String { return s("expected an exception to be thrown " , errInfo ) }
				, err 
				  ? function():String { return s("expected error like ", err," not to be thrown, but got " , errInfo ) }
				  : function():String { return s("expected no error to be thrown, got " , errInfo ) }
			);
			return this;
		}
		
		//--- member alliases ----------------------------------------------------------
		//----- handler
		public function get func():Should { return this.handler; }
		public function get method():Should { return this.handler; }
		public function get $function():Should { return this.handler; }

		//----- equal
		public function eql(val:*, desc:String=null):Should { return this.equal(val,desc); }
		public function equals(val:*, desc:String=null):Should { return this.equal(val,desc); }
		public function equalsTo(val:*, desc:String=null):Should { return this.equal(val,desc);	}
		public function equalTo(val:*, desc:String=null):Should { return this.equal(val,desc); }
		//----- within
		public function between(start:Number, finish:Number, desc:String=null):Should{ return within(start,finish,desc); }
		//----- approximately
		public function approx(value:Number, delta:Number, desc:String=null):Should{ return approximately(value, delta, desc); }
		public function around(value:Number, delta:Number, desc:String=null):Should{ return approximately(value, delta, desc); }
		//----- greaterThan
		public function gt(value:Number, desc:String=null):Should{ return greaterThan(value,desc); }
		public function above(value:Number, desc:String=null):Should{ return greaterThan(value,desc); }
		//----- greaterThanOrEqual
		public function gte(value:Number, desc:String=null):Should{ return greaterThanOrEqual(value,desc); }
		//----- lesserThan
		public function lt(value:Number, desc:String=null):Should{ return lesserThan(value,desc); }
		public function bellow(value:Number, desc:String=null):Should{ return lesserThan(value,desc); }
		//----- lesserThanOrEqual
		public function lte(value:Number, desc:String=null):Should{ return lesserThanOrEqual(value,desc); }
		//----- property
		public function prop(attr:String,val:*,desc:String):Should{ return property(attr,val,desc); }
		//----- properties
		public function props(...args):Should{ return properties.apply(this, args) }
		//----- property
		public function ownProp(attr:String,val:*,desc:String):Should{ return ownProperty(attr,val,desc); }
		//----- properties
		public function ownProps(...args):Should{ return ownProperties.apply(this, args) }
		//----- throws
	 	public function raise(err:* = "", args:Array = null, ctx:Object = null):Should{ return throws(err,args,ctx) }
		public function raises(err:* = "", args:Array = null, ctx:Object = null):Should{ return throws(err,args,ctx) }
		public function throwErr(err:* = "", args:Array = null, ctx:Object = null):Should{ return throws(err,args,ctx) }
		public function throwError(err:* = "", args:Array = null, ctx:Object = null):Should{ return throws(err,args,ctx) }
		public function $throw(err:* = "", args:Array = null, ctx:Object = null):Should{ return throws(err,args,ctx) }
		
		//--- internals ----------------------------------------------------------------

		internal function claim(expr:*, msg:Function, negatedMsg:Function, expected:*=undefined, showDiff=undefined):void{
			var fMsg:Function = _negate ? negatedMsg : msg
				, ok:Boolean = _negate ? !expr : !!expr
				//, obj = _value
				;
			
			//_negate = false; TODO ? do we need it?
			
			if (ok) return;
			
			var err:Error = new ShouldError( fMsg.call(this) );
			
			/*
			err.actual = obj;
			err.expected = expected;
			err.startStackFunction = this.assert;
			err.negated = this.negate;
			err.showDiff = showDiff;
			*/
			
			throw err;
		}

		internal static function s(...args):String{
			return args.join("")
		}

		
		internal static function i(o:*):String
		{
			var t:String = typeof o,
			    str:String = "";
			
			switch( t ){
				case "string":  
				case "boolean": 
				case "number": 
					return t + ":" + o;
				case "object":
					return o ? "object:" + o.toString() : o === undefined ? "undefined" : "null";
			}
			
			return str;
		}
		
		internal function get inspect():String{
			return i(_value);
		}
		
	}
}