@echo off

chcp 65001

rmdir /s /q build
mkdir build

call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\VC\Auxiliary\Build\vcvars64.bat"
call nvcc --version

cmake -B build -D CMAKE_PREFIX_PATH=third_party/torch/ -D USE_CUDNN=1

call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\MSBuild\Current\Bin\MSBuild.exe" ./build/CudaRasterizer.vcxproj -p:Configuration=Release

pause
