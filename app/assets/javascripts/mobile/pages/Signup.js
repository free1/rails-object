import React from 'react';
import ReactDom from 'react-dom';
import {
  Group,
  Field,
  Button,
} from 'amazeui-touch';
import Tool from '../Tool'

const Signup = React.createClass({
  handleSubmit(e) {
    e.preventDefault();
    const uname = ReactDom.findDOMNode(this.refs.uname).value.trim();
    const email = ReactDom.findDOMNode(this.refs.email).value.trim();
    const password = ReactDom.findDOMNode(this.refs.pwd).value.trim();
    const pwd_conf = ReactDom.findDOMNode(this.refs.pwd_conf).value.trim();
    const form = ReactDom.findDOMNode(this.refs.form);
    // console.log({uname, email, pwd, pwd_conf});
    this.onSignupSubmit({uname, email, password, pwd_conf});
    form.reset();
  },

  onSignupSubmit(userinfo) {
    console.log(userinfo);
    $.ajax({
      url: Tool.ProductUrl + "/api/v1/users/signup",
      type: "post",
      context: this,
      data: {name: userinfo.uname, email: userinfo.email, password: userinfo.password}
    }).done(function(data){
      console.log(data);
      var rememberToken = data.user["remember_token"];
      document.cookie = "remember_token=" + rememberToken;
      window.location.href = "/";
    }).fail(function(xhr, status, err){
      console.log(xhr, status, err);
      alert(xhr.responseText);
    });
  },

  render: function() {
    return (
      <Group header="注册">
        <form className="form-set" ref="form" onSubmit={e => {this.handleSubmit(e)}} >
          <Field placeholder="用户名" ref="uname" />
          <Field placeholder="邮箱" ref="email" />
          <Field placeholder="密码" type="password" ref="pwd" />
          <Field placeholder="确认密码" type="password" ref="pwd_conf" />
          <Button amStyle="primary" block>提交</Button>
        </form>
        <a href="#/mine">登录 </a>
      </Group>
    );
  },
});

export default Signup;
