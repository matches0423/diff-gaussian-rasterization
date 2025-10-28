@echo off

chcp 65001

REM download torch(v2.0.0 w/ cuda 11.8)
call curl -o torch.zip "https://download.pytorch.org/libtorch/cu118/libtorch-win-shared-with-deps-2.0.0%%%%2Bcu118.zip"
  REM extract torch
  rmdir /s /q .\third_party\libtorch
  call tar -xf torch.zip -C third_party
del torch.zip

REM setup VS build environment
call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"

REM check nvcc
call nvcc --version

REM run cmake to generate project files
rmdir /s /q build
call cmake -B build ^
  -D CMAKE_PREFIX_PATH=.\third_party\libtorch ^
  -D CAFFE2_USE_CUDNN=1 ^
  -D CMAKE_CUDA_FLAGS="-allow-unsupported-compiler -D_ALLOW_COMPILER_AND_STL_VERSION_MISMATCH"

REM compile
call MSBuild build\CudaRasterizer.vcxproj -p:Configuration=Release

pause
