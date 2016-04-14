import React from 'react';
import {
  Container,
  Field,
  Icon,
  Button,
  Col,
} from 'amazeui-touch';
import Tool from '../Tool';

const Search = React.createClass({

  handleSubmit(e) {
    console.log("ss")
  },

  render: function() {
    return (
      <Container>
        <Col md={8} mdOffset={2} >
          <Field
            placeholder="搜索"
            btnAfter={<Button onSubmit={e => {this.handleSubmit(e)}}><Icon name="search" /></Button>}
          />
        </Col>
      </Container>
    );
  },
});

export default Search;
