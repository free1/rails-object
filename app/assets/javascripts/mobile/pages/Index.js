import React from 'react';
import {
  Container,
  Group,
  NavBar,
  View,
  Slider,
} from 'amazeui-touch';
import {
  Link,
} from 'react-router';
import {
  Grid,
  Col,
  Titlebar,
  Panel,
  Gallery,
} from 'amazeui-react';

const sliderIntance = (
  <Slider >
    <Slider.Item>
      <img src="http://s.amazeui.org/media/i/demos/bing-1.jpg" />
    </Slider.Item>
    <Slider.Item>
      <img src="http://s.amazeui.org/media/i/demos/bing-2.jpg" />
    </Slider.Item>
    <Slider.Item>
      <img src="http://s.amazeui.org/media/i/demos/bing-3.jpg" />
    </Slider.Item>
    <Slider.Item>
      <img src="http://s.amazeui.org/media/i/demos/bing-4.jpg" />
    </Slider.Item>
  </Slider>
);

const Index = React.createClass({
  getDefaultProps() {
    return {
      transition: 'rfr',
    };
  },

  render() {
    var videosInsert = [];
    for (var j = 0; j < 8; j++) {
      videosInsert.push({
        img: "http://s.amazeui.org/media/i/demos/bing-1.jpg",
        link: '#',
        title: 'test'
      });
    }

    return (
      <View>
        <NavBar
          amStyle="primary"
          title="React Demo"
        />
          <Grid className="doc-g centre-body">
            <Col md={8} mdOffset={2} >
              <div>
                {sliderIntance}
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

export default Index;
