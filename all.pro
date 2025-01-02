TEMPLATE = subdirs

CONFIG += debug_and_release \
    build_all
#链接器按照源文件的顺序来链接对象文件 
CONFIG += ordered

SUBDIRS += \
        OpenSky 
