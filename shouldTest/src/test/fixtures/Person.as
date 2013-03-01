package test.fixtures
{
	public class Person
	{
		private var _name:String, 
			_age:int, 
			_friends:Array = [];
				  
		public function Person(name:String, age:int,friends:Array=[])
		{
			_age = age;
			_name = name;
			_friends = _friends.concat(friends);
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

		public function get age():int
		{
			return _age;
		}

		public function set age(value:int):void
		{
			_age = value;
		}

		public function get friends():Array
		{
			return _friends;
		}

		public function set friends(value:Array):void
		{
			_friends = value;
		}

	}
}