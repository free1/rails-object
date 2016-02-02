import React from 'react';

export default {
  BaseUrl: "",

  // 加载组件
  // LoadingElement: React.createClass({
  //   render: function () {
  //     return (

  //     );
  //   }
  // }),

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
}