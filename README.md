
# NuGet packaging of Oniguruma binaries

The [DevOps `azure-pipelines.yml`](azure-pipelines.yml) build definition in this repository 
compiles the source code in the [`3rdparty/oniguruma` submodule](https://github.com/kkos/oniguruma), 
and builds a NuGet package to redistribute the native binaries.

Source code is located at https://github.com/kkos/oniguruma 

Packages CI build is published to https://www.myget.org/F/oniguruma

To use CI builds, add the NuGet feed Uri https://www.myget.org/F/oniguruma/api/v3/index.json to your NuGet.config

