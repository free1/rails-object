# 基本介绍

直接访问[chuangkejiazu](http://chuangkejiazu.com/)。[手机版](http://chuangkejiazu.com?mobile=1)


## 方案

* Ruby管理：rbenv
* Ruby: Ruby 2.1.2
* 后端框架：Rails 4.2.0
* 前端框架：bootstrap 3 + jquery + coffeescript + scss
* mobile框架: react + es6 + browserify + amazeui + jquery
* 旧版API: grape + swagger + entity
* 新版API: rails_metal + jbuilder
* 数据库：MySQL
* 计划任务：whenever
* 抓取网页：nokogiri
* 备份：backup
* 文件上传：qiniu
* 编辑器：simditor
* 缓存：Memcached + redis
* 任务队列：sidekiq
* 服务器和站点监控：New relic + monit + god
* 部署：Capistrano3
* 邮件发送：sendcloud
* 短信发送:   云片
* 反向代理：Nginx
* Web容器：unicorn
* 搜索：elasticsearch, sunspot(废弃)
* 日志系统: elk，[地址](http://chuangkejiazu.com:5601/)


## 功能组件

* 抓取文章，使用nokogiri每天定时抓取三个网站的文章。
* 搜索系统，使用elasticsearch，支持中文分词和定位分析，sunspot(废弃)，sphinx(暂时不支持中文分词)停止使用。
* 资源上传，使用[七牛服务](http://www.qiniu.com/)。
* 发送邮件，使用[sendcloud服务](https://sendcloud.sohu.com/)。
* 系统监控，使用[newrelic](https://rpm.newrelic.com)。
* 用户系统，支持用户名邮箱登录，支持第三方(qq, weibo, github, douban, weixin)登录。
* 基本的运维配置，monit监控进程（邮件报警），whenever+backup自动备份，god监控。
* 基本的部署配置，capistrano自动一键部署。
* 系统消息实时刷新。
* 各种文章帖子基本操作，评论，赞，收藏等。
* 性能监控。
* 换成metal和jbuild作为新api方便升级rails 5。
* 日志系统elk(elasticsearch, logstash, kibana)。
* 支付系统(activemerchant)。
* 第三方支持微信jssdk等。

## 简单安装(测试运行在 Ubuntu 14.04 64位)

* 进入远程服务器将 `install_server_module_to_ubuntu` 中的脚本放入一个文件中。
* 运行命令 `chmod +x install_server_module_to_ubuntu` 使它变为可执行文件，并执行 `./install_server_module_to_ubuntu` 。
* 输入deploy密码， `exit` 并以deploy用户进入服务器。
* 同样执行 `./install_rails_module_to_deploy` 。
* 要使rbenv生效需要新开一个deploy控制台。
* 运行 `rbenv install 2.1.2` 。
* 运行 `rbenv global 2.1.2` 。
* 修改capistrano的ip地址。
* 修改nginx，unicorn配置文件。
* 本地执行 `cap production deploy` 。
* 填写服务器配置，参考example。
* `sudo ln -nfs /home/deploy/apps/weixin_test/current/config/nginx.conf /etc/nginx/sites-enabled/weixin_test`
* 安装[elasticsearch](https://www.elastic.co/guide/en/elasticsearch/reference/current/_installation.html)，[安装logstash](https://www.elastic.co/guide/en/logstash/current/package-repositories.html)，[安装kibana](https://www.elastic.co/guide/en/kibana/4.4/setup.html)


## 后端next

* 可以上传视频并转码支持移动端
* 使用shield(或其它)给elk日志系统加上权限认证
* 购买功能
* 用户可以选择所在地(地级市)
* 给mysql做主从
* nginx两台服务器配置(负载均衡，页面缓存等)
* 缓存机制

