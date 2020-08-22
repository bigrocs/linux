# step 1: 安装必要的一些系统工具
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
# Step 2: 添加软件源信息
sudo yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
# Step 3: 更新并安装 Docker-CE
sudo yum makecache fast
sudo yum -y install docker-ce
# Step 4: 开启Docker服务
sudo service docker start
# 设置开机启动
sudo systemctl enable docker

# 设置阿里云镜像日志大小
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://za6g16o8.mirror.aliyuncs.com"],
  "log-driver":"json-file",
  "log-opts":{ "max-size" :"50m","max-file":"3"}
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker

# 同步时间
yum install ntp ntpdate -y
sudo tee /etc/ntp.conf <<-'EOF'
{
server ntp3.aliyun.com iburst+service
}
EOF
# 安装 rancher open-iscsi 
yum install iscsi-initiator-utils -y
