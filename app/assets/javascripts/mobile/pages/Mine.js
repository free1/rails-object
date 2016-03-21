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

const Mine = React.createClass({

  // 点击提交按钮
  handleSubmit(e) {
    e.preventDefault();
    const uname = ReactDom.findDOMNode(this.refs.uname).value.trim();
    const pwd = ReactDom.findDOMNode(this.refs.pwd).value.trim();
    const form = ReactDom.findDOMNode(this.refs.form);
    this.onSubmitUserInfo({uname, pwd});
    form.reset();
  },

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
      url: Tool.TmpUrl + "/sessions",
      type: 'post',
      data: {session: {name: userinfo.uname, password: userinfo.pwd}}
    }).done(function(){
      console.log(userinfo);
    }).fail(function(){
      console.log("error");
    });
  },

  render() {
    return (
      <Container {...this.props}>

        <Group
          header="登录"
        >
          <form className="form-set" ref="form" onSubmit={e => {this.handleSubmit(e)}} >
            <Field placeholder="用户名" ref="uname" />
            <Field placeholder="密码" type="password" ref="pwd" />
            <Button amStyle="primary" block>提交</Button>
          </form>

        </Group>

        <a href="/auth/wechat">微信登陆 </a>
      </Container>
    );
  },
});

export default Mine;
