import pandas as pd
pd.__version__


def my_function(name = "World"):
  print("Hello", name)

my_function()

class MyClass:
  pass # `pass` means do nothing.

MyClass
#> <class '__main__.MyClass'>
type(MyClass)
#> <class 'type'>
instance = MyClass()
instance
#> <__main__.MyClass object at 0x7fd01b4d2c10>
type(instance)
#> <class '__main__.MyClass'>

dir(MyClass)

class MyClass:

  print("MyClass's definition body is being evaluated")

  # special=>wrapping the name in double underscores. 
  # dunder : special double-underscore-wrapped token
  #   token invokes a Python language feature. 
  #   e.g. plug into specific syntactic sugars, 
  #     values otherwise hard to acquire, 
  #     extending language interfaces (e.g., the iteration protocol)

  # common dunder method __init__() - class constructor  when a class is instantiated. 
  #   to initialize the new class instance

  def __init__(self):
    # __init__ a normal function, defined with def like any other function. Except it’s inside the class body.
    # __init__ take an argument: self. self is the class instance being initialized (note the identical memory address between self and instance). Also note that we didn’t provide self when call MyClass() to create the class instance, self was spliced into the function call by the interpreter.
    # __init__ is called each time a new instance is created.
    print(self, "is initializing")
    # Other dunder’s worth knowing about are:
    # __getitem__: the function invoked when subsetting an instance with [ (Equivalent to defining a [ S3 method in R.    # 
    # __getattr__: the function invoked when subsetting with . (Equivalent to defining a $ S3 method in R.
    # __iter__ and __next__: functions invoked by for.
    # __call__: invoked when a class instance is called like a function (e.g., instance()).
    # __bool__: invoked by if and while (equivalent to as.logical() in R, but returning only a scalar, not a vector).
    # __repr__, __str__, functions invoked for formatting and pretty printing (akin to format(), dput(), and print() methods in R).
    # __enter__ and __exit__: functions invoked by with.
    # Many built-in Python functions are just sugar for invoking the dunder. For example: calling repr(x) is identical to x.__repr__(). Other builtins that are just sugar for invoking the dunder are next(), iter(), str(), list(), dict(), bool(), dir(), hash() and more!


#> MyClass's definition body is being evaluated
print("MyClass is finished being created")
#> MyClass is finished being created
instance = MyClass()
#> <__main__.MyClass object at 0x7fd01b4d1490> is initializing
print(instance)
#> <__main__.MyClass object at 0x7fd01b4d1490>
instance2 = MyClass()
#> <__main__.MyClass object at 0x7fd013f468e0> is initializing
print(instance2)
#> <__main__.MyClass object at 0x7fd013f468e0>

# https://rstudio.github.io/reticulate/articles/python_primer.html
# Functions defined inside a class code block are called methods, and the important thing to know about methods is that each time they are called from a class instance, the instance is spliced into the function call as the first argument. This applies to all functions defined in a class, including dunders. (The sole exception is if the function is decorated with something like @classmethod or @staticmethod).


