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
    const query = this.refs.query.getValue().trim();
    this.onSearchQuery(query);
  },

  onSearchQuery(query) {
    $.ajax({
      url: Tool.TmpUrl + "/products/search",
      type: "get",
      data: {query: query}
    }).done(function(data){

    }).fail(function(){
      console.log("error");
    });
  },

  render: function() {
    return (
      <Container>
        <Col md={8} mdOffset={2} >
          <Field
            placeholder="搜索"
            ref="query"
            btnAfter={<Button onClick={this.handleSubmit}><Icon name="search" /></Button>}
          />
        </Col>
      </Container>
    );
  },
});

export default Search;
