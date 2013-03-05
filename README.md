should.as
=========

Porting of [Should.js](https://github.com/visionmedia/should.js)  to ActionScript 3

* Some implementatio details are different
* Adaptation of API was also necessary - because ActionScript does not allow augment prototype of Object with a property getter
  (use o.should() instead)


Not exact porting because of the platform differences, and I still have some methods to catch up with the original should.js (like the HTTP testing methods) but close enough. The main difference is that instead

var o:Object = 
    { name : "Radagast"
    , color: "Brown"
    }
o.should.have.properties("name","color")
    .and.have.property("name","Radagast");
o.name.should.not.equal("Palandoo");
o.color.should.equal("Brown");
you have to go

```
o.should().have.properties("name","color")
       and.have.property("name","Radagast");
o.name.should().not.equal("Palandoo");
o.color.should().equal("Brown");
```

(the brackets - no getter possible - so the should attribute is a method, and you have to invoke it yourself)

Now if you get stuck and need help from the intellisense, you have to do this:

```
var should:tdd.Should = o.color.should();
should. <ctrl+space>
which kind'a takes the sting out, but for a peek in the intelisense - it helps
```

Important
---------

One more thing - you have to force the static constructor of Should as soon in execution as you can, for example, I do it here:

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
    
I'll probably add some propper README.md later, and more awsome member functions to tdd.Should

Have fun

  
