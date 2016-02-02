import React from 'react';
import {
  Container,
  Group,
} from 'amazeui-touch';

import Tool from '../Tool'

const Discover = React.createClass({
  loadingData: function () {
    $.ajax({
      method: 'get',
      url: Tool.BaseUrl + '',
      context: this,
      success: function (data) {
        if (data.code == 0) {
          this.setState({load: true, data: data.result});
        } else {
          this.setState({error: true, load: true});
        }
      },
      error: function () {
        this.setState({error: true, load: true});
      }
    });
  },

  getInitialState: function () {
    return {
      data: null,
      load: false,
      error: false
    }
  },

  render() {
    if (!this.state.load) {
      this.loadingData();
      return <Tool.StartElement />;
    }

    if (this.state.error) {
      return <Tool.BadErrorElement />;
    }

    return (
      <p>ss</p>
    );
  },
});

export default Discover;
