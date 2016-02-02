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
} from 'amazeui-touch';

import Index from './pages/Index';
import Page from './pages/Page';

const App = React.createClass({
  render() {
    const {
      location,
      params,
      children,
      ...props,
    } = this.props;
    const transition = children.props.transition || 'sfr';

    return (
      <Container direction="column" id="sk-container">

        <Container transition={transition}>
          {React.cloneElement(children, {key: location.key})}
        </Container>

        <TabBar amStyle="primary" >
          <TabBar.Item
            component={Link}
            icon="home"
            title="首页"
            selected={!params.page}
            to="/"
          />
          <TabBar.Item
            component={Link}
            icon="gear"
            title="发现"
            selected={params.page === 'find'}
            to="/find"
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
      <Route path=":page" component={Page} />
    </Route>
  </Router>
);

document.addEventListener('DOMContentLoaded', () => {
  render(routes, document.getElementById('root'));
});

