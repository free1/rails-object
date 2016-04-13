import React from 'react';
import {
  Container,
  Group,
  NavBar,
  View,
  Slider,
} from 'amazeui-touch';
import {
  Grid,
  Col,
  Titlebar,
  Panel,
  Gallery,
} from 'amazeui-react';
import Tool from '../Tool';

var IndexPage = React.createClass({

  render() {
    var data = this.props.data;
    // 顶部滚动
    var banners = data.roll_nav_infos;
    var bannerInsert = [];
    for (var i = 0; i < banners.length; i++) {
      bannerInsert.push({img: banners[i].cover_path, desc: banners[i].title});
    }
    // 热门推荐橱窗
    var recommands = data.hot_products;
    var videosInsert = [];
    for (var j = 0; j < recommands.length; j++) {
      videosInsert.push({
        img: recommands[j].cover_path,
        link: '#/product/' + recommands[j].id,
        title: recommands[j].title,
        desc: '点击:' + recommands[j].watch_count + " || 价格" + recommands[j].price
      });
    }

    return (
      <View>
          <Grid className="doc-g centre-body">
            <Col md={8} mdOffset={2} >
              <div>
                <Slider>
                  {bannerInsert.map(function (item, i) {
                    return (
                      <Slider.Item key={i}>
                        <a href="#">
                          <img src={item.img}/>
                          <div className="am-slider-desc">
                            {item.desc}
                          </div>
                        </a>
                      </Slider.Item>
                    );
                  })}
                </Slider>
              </div>
              
              <div>
                <Titlebar title="热门推荐" />
                <Panel>
                  <Gallery theme='imgbordered' data={videosInsert} />
                </Panel>
              </div>
            </Col>
          </Grid>
      </View>
    );
  },
});

export default React.createClass({
  loadingStartData: function() {
    $.ajax({
      method: 'get',
      // url: Tool.BaseUrl + '/indexinfo',
      url: Tool.ProductUrl + '/new_api/v2/home',
      context: this,
      success: function(data) {
        if (data.success == 1) {
          // console.log(data.data)
          this.setState({load: true, data: data.data});
        } else {
          console.log("error")
          this.setState({error: true, load: true});
        }
      },
      error: function() {
        console.log("error1")
        this.setState({error: true, load: true});
      }
    });
  },
  getInitialState: function() {
    return {
      data: null,
      load: false,
      error: false
    }
  },
  render() {
    if (!this.state.load) {
      this.loadingStartData();
      return <Tool.LoadingElement />;
    }

    if (this.state.error) {
      return <Tool.BadErrorElement />;
    }

    return (
      <div>
        <IndexPage data={this.state.data} />
      </div>
    )
  }
});
