//= require_tree ./mobile

import React from 'react';
import {
  render,
} from 'react-dom';
import {
  Router,
  Route,
  Link,
  IndexRoute,
} from 'react-router';
import {
  Container,
  TabBar,
  NavBar,
} from 'amazeui-touch';

import Index from './pages/Index';
import Home from './pages/Home';
import Discover from './pages/Discover';
import Mine from './pages/Mine';
import Signup from './pages/Signup';
import Product from './pages/Product';
import Search from './pages/Search';

const App = React.createClass({
  render() {
    const {
      params,
      children,
      ...props,
    } = this.props;
    const transition = children.props.transition || 'sfr';

    return (
      <Container direction="column" id="sk-container">

        <NavBar amStyle="primary" title="React Demo" />

        <Container transition={transition} className="centre-body">
          {this.props.children}
        </Container>

        <TabBar amStyle="primary" >
          <TabBar.Item
            component={Link}
            icon="home"
            title="首页"
            selected={params.page === 'Index'}
            to="/"
          />
          <TabBar.Item
            component={Link}
            icon="gear"
            title="发现"
            selected={params.page === 'discover'}
            to="/discover"
          />
          <TabBar.Item
            component={Link}
            icon="search"
            title="搜索"
            selected={params.page === 'search'}
            to="/search"
          />
          <TabBar.Item
            component={Link}
            icon="person"
            title="我的"
            badge="1"
            selected={params.page === 'mine'}
            to="/mine"
          />
        </TabBar>
      </Container>
    );
  },
});

const routes = (
  <Router>
    <Route path="/" component={App}>
      <IndexRoute component={Index} />
      <Route path="/discover" component={Discover} />
      <Route path="/mine" component={Mine} />
      <Route path="/search" component={Search}/>
      <Route path="/product/:id" component={Product}/>
      <Route path="/signup" component={Signup}/>
    </Route>
  </Router>
);

document.addEventListener('DOMContentLoaded', () => {
  render(routes, document.getElementById('root'));
});

