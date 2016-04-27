import React from 'react';
import ReactDom from 'react-dom';
import {
  Container,
  Group,
  Slider,
  Field,
  Button,
} from 'amazeui-touch';
import Tool from '../Tool';

// 登陆表单
var LoginFrom = React.createClass({
  // 点击提交按钮
  handleSubmit(e) {
    e.preventDefault();
    const uname = ReactDom.findDOMNode(this.refs.uname).value.trim();
    const pwd = ReactDom.findDOMNode(this.refs.pwd).value.trim();
    const form = ReactDom.findDOMNode(this.refs.form);
    this.props.onUserSubmit({uname, pwd});
    form.reset();
  },
  render() {
    return (
      <Group header="登录">
        <form className="form-set" ref="form" onSubmit={e => {this.handleSubmit(e)}} >
          <Field placeholder="用户名" ref="uname" />
          <Field placeholder="密码" type="password" ref="pwd" />
          <Button amStyle="primary" block>提交</Button>
        </form>
        <a href="/auth/wechat">微信登陆 </a>
        <a href="#/signup">注册 </a>
      </Group>
    );
  }
});

const Mine = React.createClass({
  // rails CSRF
  allowCSRF() {
    $.ajaxSetup({
        headers: {
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      }
    });
  },

  // 将数据提交至服务器
  onSubmitUserInfo(userinfo) {
    this.allowCSRF();
    // 提交服务器
    $.ajax({
      url: Tool.ProductUrl + "/sessions",
      type: 'post',
      data: {session: {name: userinfo.uname, password: userinfo.pwd}}
    }).done(function(data){
      // document.cookie = "remember_token=" + data;
      window.location.href = "/";
    }).fail(function(){
      console.log("error");
      alert("登录失败");
    });
  },

  // 获取cookie
  getCookie(key) {
    var keyValue = document.cookie.match('(^|;) ?' + key + '=([^;]*)(;|$)');
    return keyValue ? keyValue[2] : null;
  },
  
  // 获取用户信息
  getLoginInfo() {
    var token = this.getCookie('remember_token');
    if (token == null) {
      console.log("没有token");
      return false;
    }
    token = token.trim();
    var jqXHR = $.ajax({
      url: Tool.ProductUrl + "/api/v1/users/current_user",
      type: 'get',
      context: this,
      // todo 同步才可以获取内部数据
      async: false,
      data: {token: token}
    }).done(function(data){
      // console.log(data);
    }).fail(function(){
      console.log("error");
    });
    return jqXHR.responseText;
  },

  render() {
    var MineContent;
    var user = JSON.parse(this.getLoginInfo()).user
    console.log(user);
    if (user == null) {
      MineContent = <LoginFrom onUserSubmit={this.onSubmitUserInfo} />
    } else {
      MineContent = <div>
                                  <h1>{user.name}</h1>
                                  <h1>{user.email}</h1>
                                  <h1>{user.avatar_path}</h1>
                              </div>
    }
    return (
      <Container {...this.props}>
        {MineContent}
      </Container>
    );
  },
});

export default Mine;
