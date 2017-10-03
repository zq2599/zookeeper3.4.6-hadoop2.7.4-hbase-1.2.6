# Docker image of hbase cluster
# VERSION 0.0.1
# Author: bolingcavalry

#基础镜像使用kinogmt/centos-ssh:6.7，这里面已经装好了ssh，密码是password
FROM kinogmt/centos-ssh:6.7

#作者
MAINTAINER BolingCavalry <zq2599@gmail.com>

#定义工作目录
ENV WORK_PATH /usr/local/work

#定义jdk1.8的文件夹
ENV JDK_PACKAGE_FILE jdk1.8.0_144

#定义jdk1.8的文件名
ENV JDK_RPM_FILE jdk-8u144-linux-x64.rpm

#把分割过的jdk1.8安装文件复制到工作目录
COPY ./jdkrpm-* $WORK_PATH/

#用本地分割过的文件恢复原有的jdk1.8的安装文件
RUN cat $WORK_PATH/jdkrpm-* > $WORK_PATH/$JDK_RPM_FILE

#本地安装jdk1.8，如果不加后面的yum clean all，就会报错：Rpmdb checksum is invalid
RUN yum -y localinstall $WORK_PATH/$JDK_RPM_FILE; yum clean all

#删除jdk分割文件
RUN rm $WORK_PATH/jdkrpm-*

#删除jdk安装包文件
RUN rm $WORK_PATH/$JDK_RPM_FILE

#HDFS http服务的端口
EXPOSE 50070

#YARN http服务端口
EXPOSE 8088

#HBase Master web 界面端口
EXPOSE 16010