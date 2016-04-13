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
      // url: Tool.BaseUrl + '/topinfo',
      url: Tool.ProductUrl + '/new_api/v2/categories',
      context: this,
      success: function(data) {
        if (data.success == 1) {
          var data = data.data
          var renderResult = [];
          for (var i = 0; i < data.length; i++) {
            // console.log(data[i]);
            var sortName = data[i].name;
            var list = data[i].products;
            var renderList = [];
            for (var j = 0; j < list.length; j++) {
              renderList.push({
                img: list[j].cover_path,
                link: '#',
                title: list[j].title,
                desc: "点击: " + list[j].watch_count + " || 价格" + list[j].price
              });
            }
            renderResult.push(<div key={ sortName }><AMUIReact.Divider />
              <AMUIReact.Titlebar theme='cols' title={ sortName }/>
              <AMUIReact.Gallery theme='bordered' data={ renderList }/></div>);
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
        } else {
          console.log("error");
          this.setState({isError: true});
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
