# bgfxCI
CI builds of bgfx for x86 platform

# How to use

See [cmake](cmake) folder for include files. Then in your own library `CMakeLists.txt` do:

```cmake
find_package(BGFX REQUIRED)

...

target_link_libraries(<libname>
  ...
  BGFX::BGFX
  BGFX::BIMG
  BGFX::BX
  ...
)
```
