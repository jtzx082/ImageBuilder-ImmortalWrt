#!/bin/sh

# UCI 默认脚本：自定义 LAN 配置和 root 密码
# 在固件首次启动时运行，完成后自动删除自身

# 修改 LAN 接口的默认 IP 地址
uci set network.lan.ipaddr='10.0.0.1'
uci commit network

# 添加 eth2 和 eth3 到 LAN 桥接设备（假设 @device[0] 是 br-lan）
uci add_list network.@device[0].ports='eth2'
uci add_list network.@device[0].ports='eth3'
uci commit network

# 设置 root 密码为 'password'（警告：生产环境请使用更强密码！）
echo -e "password\npassword" | passwd root

# 应用网络更改（重启接口以生效）
ifup lan

# 退出并标记脚本完成（UCI 默认脚本会自动删除）
exit 0
