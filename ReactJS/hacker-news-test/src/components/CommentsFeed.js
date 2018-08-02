import React from 'react'
import LoadingIcon from './LoadingIcon'

import ReactHtmlParser from 'react-html-parser';

class CommentsFeed extends React.Component {
  state = {
    open: false,
    ...this.props
  }
  getClassSuffix = () => {
    if (this.props.loading) return 'loading'
    else return (this.state.open) ? 'open' : 'closed'
  }
  toggleState = () => {
    this.setState(state => {
      return { open: !state.open}
    })
  }
  render() {
    return (
      <section className={`news-feed-comments news-feed-comments--${this.getClassSuffix()}`}>
        <h3 onClick={() => this.toggleState()} className="news-feed-comments_header">
          expand comments
        </h3>
        <ul className="news-feed-comments__list">
          {this.state.data.map( item =>
            <li
              key={item.id}
              className="news-feed-comments__list-item"
              >
              <h4 className="news-feed-comments__list-author">
                {item.by}
              </h4>
              {ReactHtmlParser(item.text)}
            </li>
          )}
        </ul>
        <div className="news-feed-comments_placeholder">
          <LoadingIcon parentName="news-feed" />
          <small>loading comments</small>
        </div>
      </section>
    )
  }
}

export default CommentsFeed
