# Object

Very straight-forward OOP Library for Lua focused on simplicity and speed.

## Overview

````lua
local object = require "object"

-- create a new prototype

Shape = object.prototype(function()
  width, height = 0, 0
  function constructor(self, width, height)
    self.width, self.height = width, height
  end
end)

-- inheritance

Square = object.prototype(Shape, function()
  function constructor(self, size)
    super.constructor(self, size, size)
  end
end)

-- creating objects

local rect1 = Shape(32, 16)
local square1 = object.create(Square, 16)
````

## Usage
### object.prototype([super,] defn)
Function used to create a new _prototype_, it returns a table containing all the variables defined in the `defn` function. 
It supports two parameters, a super _prototype_ and a defining function, the `super` parameter is optional, the `defn` function is not.

When defining a new prototype all variable declarations made inside the `defn` function are not treated as global variables but rather as variables belonging to the future prototype table. Local variables will belong exclusively to the prototype table and will not be passed on to future objects, although they can still reference them (in a way local variables can be seen as static variables).

There are three special keywords to use inside the defn function: **`self`, `super` and `constructor`**. 

The **`self`** keyword references the future prototype table itself.
````lua
local object = require "object"

Vector = object.prototype(function()
  x = 0       
  self.y = 0  -- same as the one before 
end)
````

The **`super`** keyword references a prototype table from which the new one will inherit its variables. When redefining a function already present in the super prototype you can use the super keyword to reference that prototype.

````lua
local object = require "object"

Shape = object.prototype(function()
  width, height = 0, 0
  function constructor(self, width, height)
    self.width, self.height = width, height
  end
end)

Square = object.prototype(Shape, function()
  function constructor(self, size)
    super.constructor(self, size, size)
  end
end)
````

And the **`constructor`** keyword **can only be used to define a function that'll be called when a new object is created from the prototype table**.

````lua
local object = require "object"

Vector = object.prototype(function()
  x, y = 0, 0
  function constructor(self, x, y)
    self.x, self.y = x, y
  end
end)

local vector1 = Vector(32, 32)
print(vector1.x, vector1.y)   --  32,   32
````

### object.create(prototype, ...)

This function is used to create a new object from an existing prototype.
> Alternatively you can call the prototype variable itself as a function to create a new object from it.

````lua
local object = require "object"

Vector = object.prototype(function()
  x, y = 0, 0
  function constructor(self, x, y)
    self.x, self.y = x, y
  end
end)

local vector1 = object.create(Vector, 128, 128)
local vector2 = Vector(32, 32)                    -- same as the one before
````
