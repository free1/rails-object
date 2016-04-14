import React from 'react';
import {
  Container,
  Field,
  Icon,
  Button,
} from 'amazeui-touch';
import Tool from '../Tool';

const Search = React.createClass({
  render: function() {
    return (
      <Container>
        <Field
          placeholder="搜索"
          btnAfter={<Button><Icon name="search" /></Button>}
        />
      </Container>
    );
  },
});

export default Search;
