使用的ucos版本为V2.52

bsp：为板级支持包包含中断处理，uart通信和定时器相关的函数
build：编译过程中产生的obj
h：头文件
init：启动时首先执行的代码“startup.s”
lib：标准c库和gcc库
port：移植代码（和处理器相关）
ucos：ucos V2.52源码
usrApp：入口函数main和一个简单的应用

编译前需要重新配置makefile中的 INCLUDEPATH ?= "C:/workspace/ucos_raspberryPi/h" 为实际工程的"h"文件夹所在的位置

该移植版本在window 32位操作系统中使用yagarto工具链编译时可以正常使用。如果使用其他工具链或是在linux操作系统下编译可能需要替换"lib"文件夹下的libc.a和libgcc.a库

有什么问题的话可以发邮件给我：litaozju@zju.edu.cn