## 介绍

本项目是一个基于qml的跨平台植物大战僵尸游戏

## 可暂停定时器

qml中的Timer组件是不可暂停的，实现了一个可暂停的定时器，用于控制动画的播放

## 全局暂停

进入游戏后，当调出菜单时，游戏和所有动画会暂停，点击继续按钮后，游戏和所有动画会继续

## 植物

实现了向日葵，豌豆射手，坚果墙，寒冰射手，双发射手和土豆雷，所有这些植物都继承自一个基类Plant

## 僵尸

实现了普通僵尸，路障僵尸，铁桶僵尸和旗子僵尸，所有这些僵尸都继承自一个基类Zombie

## 动态创建对象

利用js和qml的交互，实现了动态创建阳光、植物和僵尸

## 动画

较为完整地实现了植物和僵尸的动画，以及阳光和小推车等的动画

## 铲子

实现了铲子，可以用铲子铲除植物

## 音效

利用qml multimedia实现了背景音乐和音效

## 环境

gcc or clang or msvc，cmake，ninja，qt6 quick，qt6 multimedia

## 编译

```shell 
cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=Release
cd build
ninja
```

## 运行

```shell
cd build/plantsVsZombies
./plantsVsZombies
```

## 演示

![image](show/show0.png)
![image](show/show1.png)
![image](show/show2.png)
![image](show/show3.png)
![image](show/show4.png)
![image](show/show5.png)
![image](show/show6.png)
![image](show/show7.png)
![image](show/show8.png)
![image](show/show9.png)
![image](show/show10.png)
