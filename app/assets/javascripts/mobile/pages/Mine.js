import React from 'react';
import {
  Container,
  Group,
  Slider,
} from 'amazeui-touch';

const Mine = React.createClass({
  render() {
    return (
      <Container {...this.props}>
        <Group
          header="Page 2"
          noPadded
        >
          mine
        </Group>
      </Container>
    );
  },
});

export default Mine;
