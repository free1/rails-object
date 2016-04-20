import React from 'react';
import {
  Container,
  Field,
  Icon,
  Button,
  Col,
  List,
} from 'amazeui-touch';
import Tool from '../Tool';

const ContentList = React.createClass({
  render() {
    var data = this.props.data;
    var resultProducts = data.products;
    // console.log(data);
    return(
      <div>
        <List>
          {resultProducts.map((album, i) => {
            // console.log(album);
            var coverPath80 = <img width="80" src={album.cover_path} />
            return (
              <List.Item
                {...album}
                media = {coverPath80}
                href = {'#/product/' + album.id}
                key = {i}
              />
            );
          })}
        </List>
        <Tool.LoadingButton block clickHandler={this.props.handler} loadingText='正在加载...' key='load-btn'>
          加载更多
        </Tool.LoadingButton>
      </div>
    );
  },
});

const Search = React.createClass({

  getInitialState() {
    return {
      error: false,
      loading: false,
      isFirstVisit: false,
      page: 1,
      totalPages: 1,
      query: null,
      data: []
    }
  },

  handleSubmit(e) {
    const query = this.refs.query.getValue().trim();
    this.onSearchQuery(query, 1);
    this.setState({loading: true});
  },

  pageAdd: function () {
    this.onSearchQuery(this.state.query, this.state.page + 1);
  },

  onSearchQuery(query, page) {
    console.log("sss")
    $.ajax({
      url: Tool.TmpUrl + "/new_api/v2/search/product_search",
      type: "get",
      context: this,
      data: {query: query, per_page: 5}
    }).done(function(data){
      if (data.success == 1) {
        this.setState({
          error: false,
          loading: false,
          isFirstVisit: true,
          totalPages: data.data.meta.total_pages,
          query: query,
          data: data.data
        });
      } else {
        this.setState({error: true});
        // alert("服务器正在开小差");
      }
    }).fail(function(){
      this.setState({error: true});
      console.log("error");
    });
  },

  render() {
    return (
      <Container>
        <Col md={8} mdOffset={2} >
          <Field
            placeholder="搜索"
            ref="query"
            btnAfter={<Button onClick={this.handleSubmit}><Icon name="search" /></Button>}
          />

          {
            (this.state.error ? (<Tool.ErrorElement />) :
              (this.state.loading ? <Tool.LoadingElement /> :
                (this.state.isFirstVisit) ? <div><ContentList page={ this.state.page }
                  handler={ this.pageAdd } totalPages={ this.state.totalPages} data={ this.state.data } /></div> :
                <div></div>))
          }
        </Col>
      </Container>
    );
  },
});

export default Search;
