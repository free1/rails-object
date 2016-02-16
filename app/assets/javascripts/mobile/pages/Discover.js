import React from 'react';
import AMUIReact from 'amazeui-react';

import Tool from '../Tool'

const Discover = React.createClass({
  getInitialState: function() {
    return {
      list: [],
      isLoad: false,
      isError: false
    }
  },
  refreshApp: function() {
    $.ajax({
      method: 'get',
      url: Tool.BaseUrl + '/topinfo',
      context: this,
      success: function(data) {
        // console.log(Object.keys(data).length)

        var renderResult = [];
        for (var i = 0; i < Tool.CategoryList.length; i++) {
          var sortName = Tool.CategoryList[i];
          if (data.hasOwnProperty(sortName)) {
            var list = data[sortName];
            var renderList = [];
            for (var j = 0; j < list.length - 1; j++) {
              renderList.push({
                img: list[j].pic,
                link: '#',
                title: list[j].title,
                desc: list[j].create
              });
            }
            renderResult.push(<div key={ sortName }><AMUIReact.Divider />
              <AMUIReact.Titlebar theme='cols' title={ sortName }/>
              <AMUIReact.Gallery theme='bordered' data={ renderList }/></div>);
          }
        }

        var loadClear = function() {
          if (this.isMounted()) {
            this.setState({
              list: renderResult,
              isLoad: true
            });
          }
        }.bind(this);

        if (!window.load) {
          setTimeout(function () {
            loadClear();
          }.bind(this), 500);
        } else {
          loadClear();
        }
      },
      error: function() {
        this.setState({isError: true});
      }
    });
  },
  componentDidMount: function() {
    this.refreshApp();
  },

  render() {
    if (this.state.isError) {
      return <Tool.ErrorElement />
    }
    return (this.state.isLoad) ? <div> { this.state.list } </div> : <Tool.LoadingElement />;
  }
});

export default Discover;
