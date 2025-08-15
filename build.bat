@echo off

chcp 65001

REM download torch(v2.0.0 w/ cuda 11.8)
call curl -L -o torch.zip "https://download.pytorch.org/libtorch/cu118/libtorch-win-shared-with-deps-2.0.0%%%%2Bcu118.zip"
    REM extract torch
    rmdir /s /q third_party\libtorch
    call tar -xf torch.zip -C third_party
del torch.zip

REM setup VS build environment
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\VC\Auxiliary\Build\vcvars64.bat"

REM check nvcc
call nvcc --version

REM run cmake to generate project files
rmdir /s /q build
mkdir build
call cmake -B build -D CMAKE_PREFIX_PATH="third_party\libtorch\" -D USE_CUDNN=1

REM compile
call MSBuild build\CudaRasterizer.vcxproj -p:Configuration=Release

pause
