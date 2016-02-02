import React from 'react';
import {
  View,
  NavBar,
} from 'amazeui-touch';
import {
  Link,
} from 'react-router';

import Discover from './Discover';
import Mine from './Mine';
import NotFound from './NotFound';

const pages = {
  Discover,
  Mine,
};

const Home = React.createClass({
  render() {
    let page = this.props.params.page;

    if (page) {
      page = page.charAt(0).toUpperCase() + page.slice(1);
    }

    const Component = pages[page] || NotFound;
    const backNav = {
      component: Link,
      icon: 'left-nav',
      title: '返回',
      props: {
        to: '/',
      },
    };

    return (
      <View>
        <NavBar
          title={page}
          // leftNav={[backNav]}
          amStyle="primary"
        />
        <Component scrollable />
      </View>
    );
  },
});

export default Home;
