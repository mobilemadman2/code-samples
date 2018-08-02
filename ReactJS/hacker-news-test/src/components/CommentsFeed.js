import React from 'react'
import LoadingIcon from './LoadingIcon'

import ReactHtmlParser from 'react-html-parser';

class CommentsFeed extends React.Component {
  render() {
    const {data, commentsClass} = this.props
    return (
      <section className={`news-feed-comments news-feed-comments--${commentsClass}`}>
        <h3 className="news-feed-comments_header">
          expand comments
        </h3>
        <ul className="news-feed-comments__list">
          {data.map( item =>
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
