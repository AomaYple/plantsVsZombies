## 介绍

本项目是一个基于`Qt QML`的跨平台植物大战僵尸游戏

## 依赖

- [Qt](https://www.qt.io/zh-cn) >= 6.8
- [CMake](https://cmake.org) >= 3.30
- [Ninja](https://ninja-build.org) >= 1.8.2

## 构建

```shell
cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=Release
cd build
ninja
```

额外CMake选项

- `-DNATIVE=ON` 启用本机指令集（只在`Release`下生效）

## 运行

```shell
cd plantsVsZombies
./plantsVsZombies
```