import React, { Component } from 'react'
import NewsFeed from './components/NewsFeed'

import './App.css'

class App extends Component {
  state = {
    storyIds: [],
    stories: [],
    loading: true,
  }
  componentDidMount() {
    const url = 'https://hacker-news.firebaseio.com/v0/topstories.json'
    fetch(url)
    .then((response) => response.json())
    .then((data) => {
      this.setState({storyIds: data.slice(0, 10)})
      this.getStory(0)
    })
    .catch((error) => console.log(error))
  }
  getStory = (index) => {
    var id = this.state.storyIds[index].toString();
    const url = `https://hacker-news.firebaseio.com/v0/item/${id}.json`
    fetch(url)
    .then((response) => response.json())
    .then((data) => {
      this.addStoryToState(this.setUpStoryData(data, id), index)
      if (++index < this.state.storyIds.length) this.getStory(index)
      else {
        this.setState({loading:false})
        this.getComments(0, 0)
      }
    })
    .catch((error) => console.log(error))
  }
  getComments = (storyIndex, commentIndex) => {
    if (this.state.stories[storyIndex].kids) {
      var id = this.state.stories[storyIndex].kids[commentIndex];
      const url = `https://hacker-news.firebaseio.com/v0/item/${id}.json`
      fetch(url)
      .then((response) => response.json())
      .then((data) => {
        this.addCommentToState(this.setUpCommentData(data, id), commentIndex, storyIndex)
        if (++commentIndex < this.state.stories[storyIndex].kids.length) this.getComments(storyIndex, commentIndex)
        else this.handleCommentsLoaded(storyIndex)
      })
      .catch((error) => console.log(error))
    } else if (++storyIndex < this.state.stories.length) {
      this.getComments(storyIndex, 0)
    }
  }

  setUpStoryData = (data, itemId) => {
    const commentsData = (data.kids) ? {commentsLoading: true, kids: data.kids.slice(0, 20)} : {}
    return Object.assign({id: itemId, comments: [], ...data, ...commentsData})
  }
  setUpCommentData = (data, itemId) => {
    return Object.assign({id: itemId, ...data})
  }

  addCommentToState = (data, index, parentIndex) => {
    let storyArray = this.state.stories.map(story => story);
    storyArray[parentIndex].comments[index] = data;
    this.setState({stories: storyArray})
  }
  addStoryToState = (data, index) => {
    let storyArray = this.state.stories.map(story => story);
    storyArray[index] = data;
    this.setState({stories: storyArray})
  }

  handleCommentsLoaded = (index) => {
    let storyArray = this.state.stories.map(story => story);
    storyArray[index].commentsLoading = false;
    this.setState({stories: storyArray})
    if (++index < this.state.stories.length) this.getComments(index, 0)
  }

  render() {
    return (
      <div className="App">
        <header className="app-header">
          <h1 className="app-header__title">Top Stories from HackerNews</h1>
        </header>
        <NewsFeed
          data={this.state.stories}
          loading={this.state.loading}
          />
        <footer className="app-footer">
          <p className="app-footer__text">
            <a
              target="_blank"
              className="cta"
              rel="noopener noreferrer"
              href="https://news.ycombinator.com/"
              >
              Read more Hacker News &rarr;
            </a>
          </p>
        </footer>
      </div>
    )
  }
}

export default App
