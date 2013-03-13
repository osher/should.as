should.as
=========

Porting of [Should.js](https://github.com/visionmedia/should.js)  to ActionScript 3

* Some implementation details are different
* Adaptation of API was also necessary - because ActionScript does not allow augment 
  prototype of Object with a property getter
  (use o.should()... instead of o.should....)

Not exact porting because of the platform differences, 
and I still have some methods to catch up with the original [should.js](https://github.com/visionmedia/should.js)
(like the HTTP testing methods) but close enough. 


How to use?
===========

After getting started (see the Important note bellow)
Suppose you want to test a method such as
```
public function getCurrentUser(){ 
    return { 
      name: "Radagast"
    , color: "Brown"
    , age  : 642
    }
}

```
So, in your test function - just go like this


```
var o:Object = getCurrentUser();

o.should().have.properties("name","color")
       and.have.property("name","Radagast");
o.name.should().not.equal("Palandoo");
o.age.should().be.aproximately(640,5); //i.e 640 +/- 5 
o.color.should().equal("Brown");
```

How can I get intellisense to help me?
==============

Now if you get stuck and need help from the intellisense, you have to do this:

```
var should:tdd.Should = o.color.should();
should. <ctrl+space>
```

which kind'a takes the sting out, but for a peek in the intelisense - it helps

How can I use it on primitive stypes?
=========
Assume that our `getCurrentUser()` function returns an instance of `User` class, 
where `name` is string, `age` is int, and `friends` as strong typed `vector` of 
instances of `User` class.

Now the compiler that was born into a world where he thinks he's smarter then you, 
and often be right about it, will complain on your code even through it's **100%** 
correct - because, no, the compiler is not ***always*** smarter then you.

The compiler does it because it does not know about the additional non-enumerable
method `should` that we put on the prototype of `Object` so that every entity in 
the system has it.


To make it pass compilation we have to cheat the compiler.
We can do it in few ways.
Assume we have
```
var u:User = getCurrentUser();
```
We can cast it:
```
(u.name as Object).should().equal("Radagast");
```

We can assign it:
```
var o:*;
o = u.name;
o.should().equal("Radagast");
```

And - my favorite - we can impose dynamic evaluation of `should` on it (that will 
return us the method handler, and we still have to invoke it).
```
u.name["should"]().equal("Radagast");
u.color["should"]().equal("Brown");
u.age["should"]().equal(758);
u.friends[0].name["should"]().equal("Gandalf");
```
All of them are ugly, but better then nothing.
My favorite is the last, which I take as least-worst, because I usually test deep 
data-structrues, and if I want to leverage the performence of strong-typing, the whole
structure is strong-typed, and thus, validated by the compiler...
and I don't want to stop and assign, or sorround with braces for casting so I can 
keep the *flow of speach*...

Important
---------

One more thing - you have to force the static constructor of Should as soon in
execution as you can, for example, I do it here:

```
[Suite]
[RunWith("org.flexunit.runners.Suite")]
public class my_awsome_test_suite
{
            //forces the static constructor of tdd.Should
    import tdd.Should;
    private static var s:Should = new Should(); 

    public var c1:testCase1;
    public var c2:testCase2;
    public var c3:testCase3;
    public var c4:testCase4;
    }
}
```    
The static constructor adds a non-enumerable property to the prototype of object.
The property is a handler referenece (effectively a method) that when you invoke it
it returns an instance of a `tdd.Should` object that implements all it takes to keep
the language close enough to english.


I'll probably add some propper README.md later, and more awsome member functions to tdd.Should

Have fun

  
