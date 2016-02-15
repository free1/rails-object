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
  AvgGrid,
  Titlebar,
  Panel,
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

var avgGridInstance = (
  <AvgGrid sm={2} md={3} lg={4} className="am-thumbnails">
    <li><img className="am-thumbnail" src="http://s.amazeui.org/media/i/demos/bing-1.jpg" /></li>
    <li><img className="am-thumbnail" src="http://s.amazeui.org/media/i/demos/bing-2.jpg" /></li>
    <li><img className="am-thumbnail" src="http://s.amazeui.org/media/i/demos/bing-3.jpg" /></li>
    <li><img className="am-thumbnail" src="http://s.amazeui.org/media/i/demos/bing-4.jpg" /></li>
    <li><img className="am-thumbnail" src="http://s.amazeui.org/media/i/demos/bing-1.jpg" /></li>
    <li><img className="am-thumbnail" src="http://s.amazeui.org/media/i/demos/bing-2.jpg" /></li>
    <li><img className="am-thumbnail" src="http://s.amazeui.org/media/i/demos/bing-3.jpg" /></li>
    <li><img className="am-thumbnail" src="http://s.amazeui.org/media/i/demos/bing-4.jpg" /></li>
  </AvgGrid>
);

const Index = React.createClass({
  getDefaultProps() {
    return {
      transition: 'rfr',
    };
  },

  render() {
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
                  {avgGridInstance}
                </Panel>
              </div>
            </Col>
          </Grid>
      </View>
    );
  },
});

export default Index;
