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

const sliderIntance = (
  <Slider>
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
    return (
      <View>
        <NavBar
          amStyle="primary"
          title="React Demo"
        />
          {sliderIntance}
      </View>
    );
  },
});

export default Index;
