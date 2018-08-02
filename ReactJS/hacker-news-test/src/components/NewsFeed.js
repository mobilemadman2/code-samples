import React from 'react'
import LoadingIcon from './LoadingIcon'
import CommentsFeed from './CommentsFeed'

import ReactHtmlParser from 'react-html-parser';

class NewsFeed extends React.Component {
  render() {
    const {data, loading} = this.props
    return(
      <section
        className="news-feed"
        >
        <ul className="news-feed__list">
          {data.map( item =>
            <li
              key={item.id}
              className="news-feed__list-item"
              >
              <header>
                <h2 className="news-feed__list-item-title">
                  {item.title}
                </h2>
                <p className="news-feed__list-meta">
                  <strong className="news-feed__list-item-meta--score">{`score ${item.score}` }</strong>
                  &nbsp;
                  <small className="news-feed__list-item-meta--author">{`by ${item.by}`}</small>
                </p>
              </header>
              <section className="news-feed__list-item-content">
                {(item.url) ?
                  <a
                    className="cta"
                    target="_blank"
                    href={item.url}
                    rel="noopener noreferrer"
                    >
                    Read the story &rarr;
                  </a> :
                  ''
                }
                {(item.text) ?
                  <div>
                    {ReactHtmlParser(item.text)}
                  </div> :
                  ''
                }
              </section>
              <CommentsFeed
                data={item.comments}
                commentsClass={(item.commentsLoading) ? 'loading' : 'loaded'
              } />
            </li>
          )}
        </ul>
        {(loading) ? <LoadingIcon parentName="news-feed" /> : ''}
      </section>
    );
  }
}

export default NewsFeed
