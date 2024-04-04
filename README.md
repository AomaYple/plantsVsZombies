## 介绍

本项目是一个基于c++23和qt6 qml的windows植物大战僵尸游戏

## 游戏内容展示

![image](resources/show/show0.png)
![image](resources/show/show1.png)
![image](resources/show/show2.png)
![image](resources/show/show3.png)
![image](resources/show/show4.png)
![image](resources/show/show5.png)
![image](resources/show/show6.png)
![image](resources/show/show7.png)
![image](resources/show/show8.png)
![image](resources/show/show9.png)
![image](resources/show/show10.png)

## 环境

msvc，cmake，ninja，qt6

# 可暂停定时器

qml中的Timer组件是不可暂停的，本项目实现了一个可暂停的定时器，可以通过pause和resume方法来控制定时器的暂停和继续

# 起始界面

起始界面模仿原版的动画效果

# 主菜单

主菜单有开始游戏，退出游戏等选项，可以通过点击按钮来选择

# 种植

对屏幕放置5x9的矩形区域，每个区域可以放置一个植物，植物有不同的种类，每个植物有不同的特性，例如射程，攻击力，生命值等等

# 阳光

本项目中阳光是动态生成的，具有接近原版的音效和动画，有一个定时器来判断阳光的自然产生和消失

# 植物

所有的植物都是基于Plant实现的，具有许多基本的属性和方法，例如攻击，受伤，死亡等等

# 植物攻击

每次僵尸出现的时候，就会给植物的计数器加1，死亡时就会让计数器减1，当计数器为0时植物停止攻击，当计数器大于0时植物开始攻击，实现动态攻击，且只会对僵尸前面的植物生效

# 僵尸

所有的僵尸都是基于Zombie实现的，具有许多基本的属性和方法，例如攻击，受伤，死亡等等

# 僵尸攻击

每次僵尸移动时都会判断是否有植物在前面，如果有就会攻击植物，当植物死亡时会发出一个信号，僵尸就会停止攻击并继续移动

# 游戏结束

当僵尸移动到屏幕最左边时，呈现出一种游戏结束的效果，并返回到主界面

## 编译

```shell 
cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=Release
cd build
ninja
```

## 运行

```shell
cd build/PlantsVsZombies
./PlantsVsZombies
```
