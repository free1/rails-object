import React from 'react';
import ReactCSSTransitionGroup from 'react-addons-css-transition-group'
import AMUIReact from 'amazeui-react';

export default {
  BaseUrl: "http://bilibili-service.daoapp.io",
  TmpUrl: "http://localhost:5000",
  ProductUrl: "http://chuangkejiazu.com",

  // header设置

  // 读条加载组件
  LoadingElement: React.createClass({
    render: function () {
      return <div className='am-text-center loading-content'>
        <i className='am-icon-refresh am-icon-spin am-icon-lg'/>
        <p>努力加载中</p>
      </div>;
    }
  }),

  // 错误部件
  ErrorElement: React.createClass({
    render: function () {
      return <div className='am-text-center loading-content'>
        <i className='am-icon-exclamation-circle am-icon-lg'/>
        <p>加载失败,刷新下吧~</p>
      </div>;
    }
  }),

  // 启动界面
  StartElement: React.createClass({
    render: function () {
      return (<div className='am-text-center starting-content'>
          <ReactCSSTransitionGroup transitionName='index' transitionEnterTimeout={0} transitionLeaveTimeout={0}
                                   transitionAppear={true} transitionAppearTimeout={500}>
            <div className='start-bg'></div>
          </ReactCSSTransitionGroup>
        </div>
      );
    }
  }),

  // 连接服务器异常
  BadErrorElement: React.createClass({
    render: function () {
      return <div className='am-text-center loading-content'>
        <i className='am-icon-exclamation-circle am-icon-lg'/>
        <p>服务器连接异常,请检查你的网络连接</p>
      </div>;
    }
  }),

  //加载按钮
  LoadingButton: React.createClass({
    getInitialState: function () {
      return {
        isLoading: false
      };
    },
    propTypes: {
      loadingText: React.PropTypes.string.isRequired,
      clickHandler: React.PropTypes.func
    },
    getDefaultProps: function () {
      return {
        loadingText: 'Loading',
        clickHandler: function () {
        }
      };
    },
    componentDidUpdate: function (prevProps, prevState) {
      if (this.state.isLoading) {
        this.props.clickHandler.call(this);
        this.setState({isLoading: false});
      }
    },
    handleClick: function () {
      this.setState({isLoading: true});
    },
    render: function () {
      var isLoading = this.state.isLoading;
      return (
        <AMUIReact.Button{...this.props} disabled={isLoading} onClick={!isLoading ? this.handleClick : null}>
          {isLoading ? this.props.loadingText : this.props.children}
        </AMUIReact.Button>
      );
    }
  })
}